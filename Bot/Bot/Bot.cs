// <copyright file="Bot.cs" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.
// </copyright>

namespace ForwardingBot.Bot
{
    using System;
    using System.Collections.Concurrent;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.Linq;
    using System.Net;
    using System.Net.Http;
    using System.Net.Http.Headers;
    using System.Text;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Http;
    using Microsoft.AspNetCore.Http.Extensions;
    using Microsoft.Extensions.Primitives;
    using Microsoft.Graph;
    using Microsoft.Graph.Communications.Client.Authentication;
    using Microsoft.Graph.Communications.Client.Transport;
    using Microsoft.Graph.Communications.Common;
    using Microsoft.Graph.Communications.Common.Telemetry;
    using Microsoft.Graph.Communications.Common.Transport;
    using Microsoft.Graph.Communications.Core.Notifications;
    using Microsoft.Graph.Communications.Core.Serialization;
    using ForwardingBot.Common;
    using ForwardingBot.Common.Authentication;
    using ForwardingBot.Common.Transport;
    using ForwardingBot.Bot.Controllers;
    using ForwardingBot.Bot.Extensions;
    using ForwardingBot.Bot.Services;
    using System.Text.Json.Serialization;
    using System.Text.Json;

    /// <summary>
    /// The core bot class.
    /// </summary>
    public class Bot
    {
        private readonly Uri botBaseUri;

        /// <summary>
        /// Initializes a new instance of the <see cref="Bot" /> class.
        /// </summary>
        /// <param name="options">The bot options.</param>
        /// <param name="graphLogger">The graph logger.</param>
        public Bot(BotOptions options, IGraphLogger graphLogger, ITeamsUserForwardingConfigurationService forwardingConfigurationService)
        {
            botBaseUri = options.BotBaseUrl;
            GraphLogger = graphLogger;
            var name = GetType().Assembly.GetName().Name;
            AuthenticationProvider = new AuthenticationProvider(name, options.AppId, options.AppSecret, graphLogger);
            Serializer = new CommsSerializer();
            Serializer.JsonSerializerSettings.ReferenceHandler = ReferenceHandler.IgnoreCycles;
            Serializer.JsonSerializerSettings.DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull;
            Serializer.JsonSerializerSettings.Converters.Add(new JsonStringEnumConverter(JsonNamingPolicy.CamelCase, false));

            var authenticationWrapper = new AuthenticationWrapper(AuthenticationProvider);
            NotificationProcessor = new NotificationProcessor(Serializer);
            NotificationProcessor.OnNotificationReceived += NotificationProcessor_OnNotificationReceived;
            RequestBuilder = new GraphServiceClient(options.PlaceCallEndpointUrl.AbsoluteUri, authenticationWrapper);

            // Add the default headers used by the graph client.
            // This will include SdkVersion.
            var defaultProperties = new List<IGraphProperty<IEnumerable<string>>>();
            using (HttpClient tempClient = GraphClientFactory.Create(authenticationWrapper))
            {
                defaultProperties.AddRange(tempClient.DefaultRequestHeaders
                    .Select(header => GraphProperty.RequestProperty(header.Key, header.Value)));
            }

            // graph client
            var productInfo = new ProductInfoHeaderValue(
                typeof(Bot).Assembly.GetName().Name,
                typeof(Bot).Assembly.GetName().Version.ToString());

            var jsonSerializerSettings = new JsonSerializerOptions
            {
                ReferenceHandler = ReferenceHandler.IgnoreCycles,
                DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull,
            };
            jsonSerializerSettings.Converters.Add(new JsonStringEnumConverter(JsonNamingPolicy.CamelCase, false));


            GraphApiClient = new GraphAuthClient(
                GraphLogger,
                jsonSerializerSettings,
                new HttpClient(),
                AuthenticationProvider,
                productInfo,
                defaultProperties);

            ForwardingConfigurationService = forwardingConfigurationService;
        }

        /// <summary>
        /// Gets graph logger.
        /// </summary>
        public IGraphLogger GraphLogger { get; }

        /// <summary>
        /// Gets the authentication provider.
        /// </summary>
        public IRequestAuthenticationProvider AuthenticationProvider { get; }

        /// <summary>
        /// Gets the notification processor.
        /// </summary>
        public INotificationProcessor NotificationProcessor { get; }

        /// <summary>
        /// Gets the URI builder.
        /// </summary>
        public GraphServiceClient RequestBuilder { get; }

        /// <summary>
        /// Gets the serializer.
        /// </summary>
        public CommsSerializer Serializer { get; }

        /// <summary>
        /// Gets the stateless graph client.
        /// </summary>
        public IGraphClient GraphApiClient { get; }

        /// <summary>
        /// Gets the forwarding configuration provider for the calling user.
        /// </summary>
        public ITeamsUserForwardingConfigurationService ForwardingConfigurationService { get; }

        // while this is threadsafe, it is only in memory, so for bots that span multiple instances, this will be problematic.
        // ignoring for now due to PoC -- not suitable for production, consider another distributed, thread-safe short-term storage mechanism to track the submitted tones
        private readonly ConcurrentDictionary<string, ConcurrentBag<ToneInfo>> _toneInfoCache = new();

        private readonly ConcurrentDictionary<Guid, Call> _callCache = new();

        private readonly HashSet<Guid> _awaitingTermination = new();

        /// <summary>
        /// Processes the notification asynchronously.
        /// Here we make sure we log the http request and catch/log any errors.
        /// </summary>
        /// <param name="request">The request.</param>
        /// <param name="response">The response.</param>
        /// <returns>The <see cref="Task"/>.</returns>
        public async Task ProcessNotificationAsync(HttpRequest request, HttpResponse response)
        {
            // TODO: Parse out the scenario id and request id headers.
            var headers = request.Headers
                .Select(pair => new KeyValuePair<string, IEnumerable<string>>(pair.Key, pair.Value));

            // Don't log content since we can't PII scrub here (we don't know the type).
            var stopwatch = new Stopwatch();
            stopwatch.Start();
            GraphLogger.LogHttpMessage(
                TraceLevel.Verbose,
                TransactionDirection.Incoming,
                HttpTraceType.HttpRequest,
                request.GetDisplayUrl(),
                request.Method,
                obfuscatedContent: null,
                headers: headers);

            try
            {
                var httpRequest = request.CreateRequestMessage();
                var results = await AuthenticationProvider.ValidateInboundRequestAsync(httpRequest).ConfigureAwait(false);
                if (results.IsValid)
                {
                    var httpResponse = await NotificationProcessor.ProcessNotificationAsync(httpRequest).ConfigureAwait(false);
                    await httpResponse.CreateHttpResponseAsync(response).ConfigureAwait(false);
                }
                else
                {
                    var httpResponse = new HttpResponseMessage(HttpStatusCode.Forbidden)
                    {
                        RequestMessage = httpRequest
                    };
                    await httpResponse.CreateHttpResponseAsync(response).ConfigureAwait(false);
                }

                headers = response.Headers.Select(
                    pair => new KeyValuePair<string, IEnumerable<string>>(pair.Key, pair.Value));

                GraphLogger.LogHttpMessage(
                    TraceLevel.Verbose,
                    TransactionDirection.Incoming,
                    HttpTraceType.HttpResponse,
                    request.GetDisplayUrl(),
                    request.Method,
                    obfuscatedContent: null,
                    headers: headers,
                    responseCode: response.StatusCode,
                    responseTime: stopwatch.ElapsedMilliseconds);
            }
            catch (ServiceException e)
            {
                string obfuscatedContent = null;
                if ((int)e.StatusCode >= 300)
                {
                    response.StatusCode = (int)e.StatusCode;
                    await response.WriteAsync(e.ToString()).ConfigureAwait(false);
                    obfuscatedContent = GraphLogger.SerializeAndObfuscate(e, true);
                }
                else if ((int)e.StatusCode >= 200)
                {
                    response.StatusCode = (int)e.StatusCode;
                }
                else
                {
                    response.StatusCode = (int)e.StatusCode;
                    await response.WriteAsync(e.ToString()).ConfigureAwait(false);
                    obfuscatedContent = GraphLogger.SerializeAndObfuscate(e, true);
                }

                headers = response.Headers.Select(
                    pair => new KeyValuePair<string, IEnumerable<string>>(pair.Key, pair.Value));

                if (e.ResponseHeaders?.Any() == true)
                {
                    foreach (var pair in e.ResponseHeaders)
                    {
                        response.Headers.Add(pair.Key, new StringValues(pair.Value.ToArray()));
                    }

                    headers = headers.Concat(e.ResponseHeaders);
                }

                GraphLogger.LogHttpMessage(
                    TraceLevel.Error,
                    TransactionDirection.Incoming,
                    HttpTraceType.HttpResponse,
                    request.GetDisplayUrl(),
                    request.Method,
                    obfuscatedContent,
                    headers,
                    response.StatusCode,
                    responseTime: stopwatch.ElapsedMilliseconds);
            }
            catch (Exception e)
            {
                response.StatusCode = (int)HttpStatusCode.InternalServerError;
                await response.WriteAsync(e.ToString()).ConfigureAwait(false);

                var obfuscatedContent = GraphLogger.SerializeAndObfuscate(e, true);
                headers = response.Headers.Select(
                    pair => new KeyValuePair<string, IEnumerable<string>>(pair.Key, pair.Value));

                GraphLogger.LogHttpMessage(
                    TraceLevel.Error,
                    TransactionDirection.Incoming,
                    HttpTraceType.HttpResponse,
                    request.GetDisplayUrl(),
                    request.Method,
                    obfuscatedContent,
                    headers,
                    response.StatusCode,
                    responseTime: stopwatch.ElapsedMilliseconds);
            }
        }

        /// <summary>
        /// Raised when the <see cref="INotificationProcessor"/> has received a notification.
        /// </summary>
        /// <param name="args">The <see cref="NotificationEventArgs"/> instance containing the event data.</param>
        private void NotificationProcessor_OnNotificationReceived(NotificationEventArgs args)
        {
#pragma warning disable 4014
            // Processing notification in the background.
            // This ensures we're not holding on to the request.
            NotificationProcessor_OnNotificationReceivedAsync(args).ForgetAndLogExceptionAsync(
                GraphLogger,
                $"Error processing notification {args.Notification.ResourceUrl} with scenario {args.ScenarioId}");
#pragma warning restore 4014
        }

        private void EnsureHasNeededComponents(Call originalCall, Guid scenarioId)
        {
            if (!string.IsNullOrEmpty(originalCall.Id) && _callCache.TryAdd(scenarioId, originalCall))
            {
                // this will set the source to the OnBehalfOf context if it exists, so that the forwarding is configured for the correct user
                var originalSource = originalCall.Source.Identity.GetPrimaryIdentity().Id;
                originalCall.Source.Identity = originalCall.IncomingContext.OnBehalfOf ?? originalCall.Source.Identity;
                if (originalSource != originalCall.Source.Identity.GetPrimaryIdentity().Id)
                    GraphLogger.Log(TraceLevel.Info, $"Caller {originalSource} is calling on-behalf-of {originalCall.Source.Identity.GetPrimaryIdentity().Id}");
                return;
            }

            if (_callCache.TryGetValue(scenarioId, out var cachedCall))
            {
                originalCall.Source ??= cachedCall.Source;
                originalCall.TenantId ??= cachedCall.TenantId;
                if (string.IsNullOrEmpty(originalCall.Id))
                {
                    originalCall.Id = cachedCall.Id;
                    GraphLogger.Log(TraceLevel.Info, $"Call Id missing, retrieved from cache: {originalCall.Id}");
                }
            }

            if (string.IsNullOrEmpty(originalCall.Id))
            {
                throw new ServiceException(
                                       new Error
                                       {
                                           Code = nameof(HttpStatusCode.BadRequest),
                                           Message = "Call Id is missing."
                                       });
            }
        }

        /// <summary>
        /// Raised when the <see cref="INotificationProcessor"/> has received a notification asynchronously.
        /// </summary>
        /// <param name="args">The <see cref="NotificationEventArgs"/> instance containing the event data.</param>
        /// <returns>The <see cref="Task"/>.</returns>
        private async Task NotificationProcessor_OnNotificationReceivedAsync(NotificationEventArgs args)
        {
            GraphLogger.CorrelationId = args.ScenarioId;
            var headers = new[]
            {
                new KeyValuePair<string, IEnumerable<string>>(HttpConstants.HeaderNames.ScenarioId, new[] { args.ScenarioId.ToString() }),
                new KeyValuePair<string, IEnumerable<string>>(HttpConstants.HeaderNames.ClientRequestId, new[] { args.RequestId.ToString() }),
                new KeyValuePair<string, IEnumerable<string>>(HttpConstants.HeaderNames.Tenant, new[] { args.TenantId }),
            };

            // Create obfuscation content to match what we
            // would have gotten from the service, then log.
            var notifications = new CommsNotifications { Value = new[] { args.Notification } };
            var obfuscatedContent = GraphLogger.SerializeAndObfuscate(notifications, true);
            GraphLogger.LogHttpMessage(
                TraceLevel.Info,
                TransactionDirection.Incoming,
                HttpTraceType.HttpRequest,
                args.CallbackUri.ToString(),
                Microsoft.AspNetCore.Http.HttpMethods.Post,
                obfuscatedContent,
                headers,
                correlationId: args.ScenarioId,
                requestId: args.RequestId);

            if (args.ResourceData is Call call)
            {
                EnsureHasNeededComponents(call, args.ScenarioId);
                if (args.ChangeType == ChangeType.Created && call.State == CallState.Incoming)
                {
                    GraphLogger.Info($"Answering call {call.Id}");
                    await BotAnswerIncomingCallAsync(call.Id, call.TenantId, args.ScenarioId).ConfigureAwait(false);
                    return;
                }
                GraphLogger.Info($"Call {call.Id} State: {call.State}");
                if (args.ChangeType == ChangeType.Updated && (call.State == CallState.Established || call.State == CallState.Establishing))
                {
                    if (call.ToneInfo == null && call.MediaState?.Audio == MediaState.Active)
                    {
                        await BotSubscribesToToneAsync(call.Id, call.TenantId, args.ScenarioId).ConfigureAwait(false);
                        await BotPlayInitialPromptAsync(call.Id, call.TenantId, args.ScenarioId).ConfigureAwait(false);
                        return;
                    }
                    if (call.ToneInfo != null)
                    {
                        var tones = _toneInfoCache.GetOrAdd(call.Id, new ConcurrentBag<ToneInfo>());
                        if (call.ToneInfo.Tone != null && call.ToneInfo.Tone > Tone.Tone9)
                        {
                            await BotCancelsMediaProcessingAsync(call.Id, call.TenantId, args.ScenarioId).ConfigureAwait(false);
                            var target = GetTargetFromTones(tones);
                            var configureTask = ConfigureForwardingAsync(call.Source.Identity.GetPrimaryIdentity(), target);
                            while (!configureTask.IsCompleted)
                            {
                                await BotPlayHoldLoopAsync(call.Id, call.TenantId, args.ScenarioId);
                                await Task.WhenAny(configureTask, Task.Delay(HoldLoopDuration.Value)).ConfigureAwait(false);
                            }
                            await BotCancelsMediaProcessingAsync(call.Id, call.TenantId, args.ScenarioId).ConfigureAwait(false);
                            var successful = configureTask.Result;
                            if (successful)
                            {
                                await BotPlaySuccessPromptAsync(call.Id, call.TenantId, args.ScenarioId).ConfigureAwait(false);
                                _awaitingTermination.Add(args.ScenarioId);
                            }
                            else
                            {
                                GraphLogger.Error($"Failed to configure forwarding for {call.Source.Identity.GetPrimaryIdentity().Id} to {target}");
                                await BotPlayErrorPromptAsync(call.Id, call.TenantId, args.ScenarioId).ConfigureAwait(false);
                            }
                            return;
                        }
                        tones.Add(call.ToneInfo);
                    }
                    return;
                }
                if (args.ChangeType == ChangeType.Deleted && call.State == CallState.Terminated)
                {
                    _toneInfoCache.TryRemove(call.Id, out _);
                    _callCache.TryRemove(args.ScenarioId, out _);
                }
                return;
            }
            if (args.ResourceData is PlayPromptOperation operation
                && operation.Status == OperationStatus.Completed
                && _awaitingTermination.Contains(args.ScenarioId)
                && _callCache.TryGetValue(args.ScenarioId, out var cachedCall)
            )
            {
                await BotEndsCallAsync(cachedCall.Id, cachedCall.TenantId, args.ScenarioId).ConfigureAwait(false);
                _awaitingTermination.Remove(args.ScenarioId);
            }
        }

        public Lazy<TimeSpan> HoldLoopDuration = new (() =>
            {
                var holdBytes = System.IO.File.ReadAllBytes("wwwroot\\audio\\hold.wav");
                var bitrate = BitConverter.ToInt32(new[] { holdBytes[28], holdBytes[29], holdBytes[30], holdBytes[31] }, 0);
                return TimeSpan.FromSeconds((holdBytes.Length - 8) / bitrate);
            });

        /// <summary>
        /// Bot terminates incoming call.
        /// </summary>
        /// <param name="callId">The call identifier.</param>
        /// <param name="tenantId">The tenant identifier.</param>
        /// <param name="scenarioId">The scenario identifier.</param>
        /// <returns>The <see cref="Task"/>.</returns>
        private async Task BotEndsCallAsync(string callId, string tenantId, Guid scenarioId)
        {
            var endCallRequest = RequestBuilder.Communications.Calls[callId].Request();
            await GraphApiClient.SendAsync(endCallRequest, RequestType.Delete, tenantId, scenarioId).ConfigureAwait(false);
        }


        /// <summary>
        /// Configures the forwarding for the calling user.
        /// </summary>
        /// <param name="identity">The Identity for which to configure call forwarding.</param>
        /// <param name="target">The phone number string to forward the call, if empty, forwarding will be disabled.</param>
        /// <returns>The <see cref="Task{bool}"/> which indicates if the confiuration was succesful.</returns>
        private async Task<bool> ConfigureForwardingAsync(Identity identity, string target)
        {
            GraphLogger.Info($"Configuring {identity.DisplayName ?? identity.Id} {(string.IsNullOrEmpty(target) ? "to disable forwarding" : $"to forward to {target}")}");
            return string.IsNullOrEmpty(target)
                ? await ForwardingConfigurationService.DisableForwarding(identity).ConfigureAwait(false)
                : await ForwardingConfigurationService.EnableForwarding(identity, target).ConfigureAwait(false);
        }

        /// <summary>
        /// Converts ToneInfo sequences to their string representation as integer digits. The tones are
        /// ordered by their SequenceId in ascending order and converted  like Tone.Tone2 => 2 until a
        /// null value or non-digit Tone is reached
        /// </summary>
        /// <param name="tones"></param>
        /// <returns>The <see cref="string"/> of DTMF tones converted to digits.</returns>
        private static string GetTargetFromTones(ConcurrentBag<ToneInfo> tones)
        {
            var targetString = new StringBuilder();
            foreach (var tone in tones.OrderBy(t => t.SequenceId).TakeWhile(t => t?.Tone <= Tone.Tone9))
                targetString.Append((int)tone.Tone);
            return targetString.ToString();
        }

        /// <summary>
        /// Subscribes to Tone.
        /// </summary>
        /// <param name="callId">The call identifier.</param>
        /// <param name="tenantId">The tenant identifier.</param>
        /// <param name="scenarioId">The scenario identifier.</param>
        /// <returns>The <see cref="Task"/>.</returns>
        private async Task BotSubscribesToToneAsync(string callId, string tenantId, Guid scenarioId)
        {
            var toneRequest = RequestBuilder.Communications.Calls[callId].SubscribeToTone(callId).Request();
            await GraphApiClient.SendAsync(toneRequest, RequestType.Create, tenantId, scenarioId).ConfigureAwait(false);
        }

        /// <summary>
        /// Bot answers incoming call.
        /// </summary>
        /// <param name="callId">The identifier of the call to transfer.</param>
        /// <param name="tenantId">The tenant identifier.</param>
        /// <param name="scenarioId">The scenario identifier.</param>
        /// <returns>The <see cref="Task"/>.</returns>
        private async Task BotAnswerIncomingCallAsync(string callId, string tenantId, Guid scenarioId)
        {
            var answerRequest = RequestBuilder.Communications.Calls[callId].Answer(
                    callbackUri: new Uri(botBaseUri, ControllerConstants.CallbackPrefix).ToString(),
                    mediaConfig: new ServiceHostedMediaConfig
                    {
                        PreFetchMedia = new List<MediaInfo>()
                        {
                            new MediaInfo()
                            {
                                Uri = new Uri(botBaseUri, "audio/initial.wav").ToString(),
                                ResourceId = Initial_MediaResourceId,
                            },
                            new MediaInfo()
                            {
                                Uri = new Uri(botBaseUri, "audio/success.wav").ToString(),
                                ResourceId = Success_MediaResourceId,
                            },
                            new MediaInfo()
                            {
                                Uri = new Uri(botBaseUri, "audio/error.wav").ToString(),
                                ResourceId = Error_MediaResourceId,
                            },
                            new MediaInfo()
                            {
                                Uri = new Uri(botBaseUri, "audio/hold.wav").ToString(),
                                ResourceId = Hold_MediaResourceId,
                            },
                        },
                    },
                    acceptedModalities: new List<Modality> { Modality.Audio }
                ).Request();

            await GraphApiClient.SendAsync(answerRequest, RequestType.Create, tenantId, scenarioId).ConfigureAwait(false);
        }

        private readonly string Initial_MediaResourceId = Guid.NewGuid().ToString();

        private readonly string Success_MediaResourceId = Guid.NewGuid().ToString();
        
        private readonly string Error_MediaResourceId = Guid.NewGuid().ToString();

        private readonly string Hold_MediaResourceId = Guid.NewGuid().ToString();

        /// <summary>
        /// Bot plays the initial notification.
        /// </summary>
        /// <param name="callId">The call identifier.</param>
        /// <param name="tenantId">The Tenant identifier.</param>
        /// <param name="scenarioId">The scenario identifier.</param>
        /// <returns>The <see cref="Task"/>.</returns>
        private async Task BotPlayInitialPromptAsync(string callId, string tenantId, Guid scenarioId)
        {
            var prompts = new Prompt[]
            {
                new MediaPrompt
                {
                    MediaInfo = new MediaInfo()
                    {
                         Uri = new Uri(botBaseUri, "audio/initial.wav").ToString(),
                         ResourceId = Initial_MediaResourceId,
                    },
                },
            };

            var playPromptRequest = RequestBuilder.Communications.Calls[callId].PlayPrompt(
                    prompts: prompts,
                    clientContext: callId
                ).Request();

            await GraphApiClient.SendAsync(playPromptRequest, RequestType.Create, tenantId, scenarioId).ConfigureAwait(false);
        }

        /// <summary>
        /// Bot plays the ding notification.
        /// </summary>
        /// <param name="callId">The call identifier.</param>
        /// <param name="tenantId">The Tenant identifier.</param>
        /// <param name="scenarioId">The scenario identifier.</param>
        /// <returns>The <see cref="Task"/>.</returns>
        private async Task BotPlayHoldLoopAsync(string callId, string tenantId, Guid scenarioId)
        {
            var prompts = new Prompt[]
            {
                new MediaPrompt
                {
                    MediaInfo = new MediaInfo()
                    {
                         Uri = new Uri(botBaseUri, "audio/hold.wav").ToString(),
                         ResourceId = Hold_MediaResourceId,
                    },
                },
            };

            var playPromptRequest = RequestBuilder.Communications.Calls[callId].PlayPrompt(
                    prompts: prompts,
                    clientContext: callId
                ).Request();

            await GraphApiClient.SendAsync(playPromptRequest, RequestType.Create, tenantId, scenarioId).ConfigureAwait(false);
        }

        /// <summary>
        /// Bot plays the success notification.
        /// </summary>
        /// <param name="callId">The call identifier.</param>
        /// <param name="tenantId">The Tenant identifier.</param>
        /// <param name="scenarioId">The scenario identifier.</param>
        /// <returns>The <see cref="Task"/>.</returns>
        private async Task BotPlaySuccessPromptAsync(string callId, string tenantId, Guid scenarioId)
        {
            var prompts = new Prompt[]
            {
                new MediaPrompt
                {
                    MediaInfo = new MediaInfo()
                    {
                         Uri = new Uri(botBaseUri, "audio/success.wav").ToString(),
                         ResourceId = Success_MediaResourceId,
                    },
                },
            };

            var playPromptRequest = RequestBuilder.Communications.Calls[callId].PlayPrompt(
                    prompts: prompts,
                    clientContext: callId
                ).Request();

            await GraphApiClient.SendAsync(playPromptRequest, RequestType.Create, tenantId, scenarioId).ConfigureAwait(false);
        }

        /// <summary>
        /// Bot cancels any media processing.
        /// </summary>
        /// <param name="callId">The call identifier.</param>
        /// <param name="tenantId">The Tenant identifier.</param>
        /// <param name="scenarioId">The scenario identifier.</param>
        /// <returns>The <see cref="Task"/>.</returns>
        private async Task BotCancelsMediaProcessingAsync(string callId, string tenantId, Guid scenarioId)
        {
            await GraphApiClient.SendAsync(
                RequestBuilder.Communications.Calls[callId].CancelMediaProcessing(clientContext: callId).Request(),
                RequestType.Create,
                tenantId,
                scenarioId
            ).ConfigureAwait(false);
        }

        /// <summary>
        /// Bot plays the error notification.
        /// </summary>
        /// <param name="callId">The call identifier.</param>
        /// <param name="tenantId">The Tenant identifier.</param>
        /// <param name="scenarioId">The scenario identifier.</param>
        /// <returns>The <see cref="Task"/>.</returns>
        private async Task BotPlayErrorPromptAsync(string callId, string tenantId, Guid scenarioId)
        {
            if (_toneInfoCache.TryGetValue(callId, out var toneInfo))
            {
                // remove items from cache so we can get data on retry
                toneInfo.Clear();
            }

            var prompts = new Prompt[]
            {
                new MediaPrompt
                {
                    MediaInfo = new MediaInfo()
                    {
                         Uri = new Uri(botBaseUri, "audio/error.wav").ToString(),
                         ResourceId = Error_MediaResourceId,
                    },

                },
                new MediaPrompt
                {
                    MediaInfo = new MediaInfo()
                    {
                         Uri = new Uri(botBaseUri, "audio/initial.wav").ToString(),
                         ResourceId = Initial_MediaResourceId,
                    },
                },
            };

            var playPromptRequest = RequestBuilder.Communications.Calls[callId].PlayPrompt(
                    prompts: prompts,
                    clientContext: callId
                ).Request();

            await GraphApiClient.SendAsync(playPromptRequest, RequestType.Create, tenantId, scenarioId).ConfigureAwait(false);

        }
    }
}