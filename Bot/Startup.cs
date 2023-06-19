// <copyright file="Startup.cs" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.
// </copyright>

namespace ForwardingBot.Bot
{
    using Microsoft.AspNetCore.Builder;
    using Microsoft.AspNetCore.Hosting;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Extensions.Configuration;
    using Microsoft.Extensions.DependencyInjection;
    using Microsoft.Extensions.Logging;
    using Microsoft.Graph.Communications.Common.Telemetry;
    using ForwardingBot.Common.Logging;
    using ForwardingBot.Bot.Services;
    using System.Management.Automation;
    using System.Security;
    using System.Text.Json.Serialization;
    using System.Text.Json;
    using ForwardingBot.Bot.Extensions;

    /// <summary>
    /// Startup class.
    /// </summary>
    public class Startup
    {
        private readonly GraphLogger logger;
        private readonly SampleObserver observer;

        /// <summary>
        /// Initializes a new instance of the <see cref="Startup"/> class.
        /// </summary>
        /// <param name="configuration">Project configurations.</param>
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
            logger = new GraphLogger(typeof(Startup).Assembly.GetName().Name);
            logger.ObfuscationConfiguration.ObfuscationSerializerSettings.ReferenceHandler = ReferenceHandler.IgnoreCycles;
            logger.ObfuscationConfiguration.ObfuscationSerializerSettings.DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull;
            logger.ObfuscationConfiguration.ObfuscationSerializerSettings.Converters.Add(new JsonStringEnumConverter(JsonNamingPolicy.CamelCase, false));
            observer = new SampleObserver(logger);
        }

        /// <summary>
        /// Gets the configuration.
        /// </summary>
        public IConfiguration Configuration { get; }

        /// <summary>
        /// This method gets called by the runtime. Use this method to add services to the container.
        /// </summary>
        /// <param name="services">Services.</param>
        public void ConfigureServices(IServiceCollection services)
        {
            services
                .AddSingleton(observer)
                .AddSingleton<IGraphLogger>(logger);

            services
                .AddSingleton<ITeamsUserForwardingConfigurationService>(_ => {
                    var config = Configuration.GetSection("TeamsAdmin");
                    var username = config.GetValue<string>("Username");
                    var pwd = new SecureString();
                    foreach (var c in config.GetValue<string>("Password"))
                        pwd.AppendChar(c);
                    var cred = new PSCredential(username, pwd);
                    return new TeamsUserForwardingConfigurationService(cred, logger);
                });

            services
                .AddBot(options => Configuration.Bind("Bot", options))
                .AddMvc();

            services.AddControllers();
        }

        /// <summary>
        /// This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        /// </summary>
        /// <param name="app">App builder.</param>
        /// <param name="env">Hosting environment.</param>
        /// /// <param name="loggerFactory">The logger of ILogger instance.</param>
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env, ILoggerFactory loggerFactory)
        {
            logger.BindToILoggerFactory(loggerFactory);

            if (env.EnvironmentName == "Development")
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles();
            app.UseCookiePolicy();

            app.UseRouting();
            
            app.UseEndpoints(endpoints => endpoints.MapControllers());
        }
    }
}
