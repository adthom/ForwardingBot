namespace ForwardingBot.Bot.Services
{
    using ForwardingBot.Bot.Models;
    using Microsoft.Graph.Communications.Common.Telemetry;
    using Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models;
    using System;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.IO;
    using System.Linq;
    using System.Management.Automation;
    using System.Management.Automation.Runspaces;
    using System.Threading.Tasks;
    using Identity = Microsoft.Graph.Identity;
    using UserRoutingSettings = ForwardingBot.Bot.Models.UserRoutingSettings;

    public class TeamsUserForwardingConfigurationService : ITeamsUserForwardingConfigurationService, IDisposable
    {
        private const string ModuleName = "MicrosoftTeams";
        private const string SetCommandName = "Set-CsUserCallingSettings";
        private const string GetCommandName = "Get-CsUserCallingSettings";
        private const string ConnectCommandName = "Connect-MicrosoftTeams";
        private const int MAX_RUNSPACE_COUNT = 8;
        private const int COMMAND_TIMEOUT_SECONDS = 60;

        private readonly PSCredential adminCredential;

        private readonly IGraphLogger graphLogger;

        private RunspacePool runspacePool;
        private bool isInitalized;
        private readonly object _lock;
        private bool disposedValue;

        public TeamsUserForwardingConfigurationService(PSCredential adminCredential, IGraphLogger graphLogger)
        {
            this.adminCredential = adminCredential;
            this.graphLogger = graphLogger.CreateShim(nameof(TeamsUserForwardingConfigurationService));
            isInitalized = false;
            _lock = new object();
        }

        public async Task Initialize()
        {
            if (disposedValue)
                throw new ObjectDisposedException(nameof(TeamsUserForwardingConfigurationService));

            if (!isInitalized)
            {
                lock (_lock)
                {
                    if (isInitalized) return;
                    isInitalized = true;
                }
            }

            graphLogger.Log(TraceLevel.Info, "Initializing RunspacePool...");

            var iss = InitialSessionState.CreateDefault2();
            iss.ExecutionPolicy = Microsoft.PowerShell.ExecutionPolicy.Bypass;
            iss.Variables.Clear();
            iss.ImportPSModulesFromPath(Path.Combine(Directory.GetCurrentDirectory(), "Modules", ModuleName));
            iss.Variables.Add(new SessionStateVariableEntry("DebugPreference", ActionPreference.Continue, "DebugPreference"));
            iss.Variables.Add(new SessionStateVariableEntry("VerbosePreference", ActionPreference.Continue, "VerbosePreference"));
            iss.Variables.Add(new SessionStateVariableEntry("InformationPreference", ActionPreference.Continue, "InformationPreference"));
            iss.Variables.Add(new SessionStateVariableEntry("WarningPreference", ActionPreference.Continue, "WarningPreference"));
            iss.Variables.Add(new SessionStateVariableEntry("ErrorActionPreference", ActionPreference.Stop, "ErrorActionPreference"));

            runspacePool = RunspaceFactory.CreateRunspacePool(iss);
            runspacePool.SetMinRunspaces(1);
            runspacePool.SetMaxRunspaces(MAX_RUNSPACE_COUNT);

            runspacePool.ThreadOptions = PSThreadOptions.UseCurrentThread;
            await Task.Factory.FromAsync(runspacePool.BeginOpen, runspacePool.EndOpen, null).ConfigureAwait(false);
        }

        private void AddStreamHandlers(PowerShell shell)
        {
            if (shell == null)
                throw new ArgumentNullException(nameof(shell));

            var loggedRecords = new HashSet<object>();
            void debugLogger(object sender, DataAddedEventArgs e) => graphLogger.Log(TraceLevel.Verbose, string.Format("Debug:{0}", string.Join("\nDebug:", ((PSDataCollection<DebugRecord>)sender).Where(r => loggedRecords.Add(r)).Select(e => e.ToString()))));
            void verboseLogger(object sender, DataAddedEventArgs e) => graphLogger.Log(TraceLevel.Verbose, string.Format("Verbose:{0}", string.Join("\nVerbose:", ((PSDataCollection<VerboseRecord>)sender).Where(r => loggedRecords.Add(r)).Select(e => e.ToString()))));
            void progressLogger(object sender, DataAddedEventArgs e) => graphLogger.Log(TraceLevel.Info, string.Format("Progress:{0}", string.Join("\nProgress:", ((PSDataCollection<ProgressRecord>)sender).Where(r => loggedRecords.Add(r)).Select(e => e.ToString()))));
            void informationLogger(object sender, DataAddedEventArgs e) => graphLogger.Log(TraceLevel.Info, string.Format("Information:{0}", string.Join("\nInformation:", ((PSDataCollection<InformationRecord>)sender).Where(r => loggedRecords.Add(r)).Select(e => e.ToString()))));
            void warningLogger(object sender, DataAddedEventArgs e) => graphLogger.Log(TraceLevel.Warning, string.Format("Warning:{0}", string.Join("\nWarning:", ((PSDataCollection<WarningRecord>)sender).Where(r => loggedRecords.Add(r)).Select(e => e.ToString()))));
            void errorLogger(object sender, DataAddedEventArgs e) => graphLogger.Log(TraceLevel.Error, string.Format("Error:{0}", string.Join("\nError:", ((PSDataCollection<ErrorRecord>)sender).Where(r => loggedRecords.Add(r)).Select(e => e.ToString()))));
            shell.Streams.Debug.DataAdded += debugLogger;
            shell.Streams.Verbose.DataAdded += verboseLogger;
            shell.Streams.Progress.DataAdded += progressLogger;
            shell.Streams.Information.DataAdded += informationLogger;
            shell.Streams.Warning.DataAdded += warningLogger;
            shell.Streams.Error.DataAdded += errorLogger;
        }

        public async Task<bool> DisableForwarding(Identity identity)
        {
            var current = await GetCurrentUserRoutingSettings(identity);
            if (current == null)
            {
                return false;
            }
            if (current.IsForwardingEnabled == false)
            {
                return true;
            }

            var parameters = new Dictionary<string, object>
            {
                { "Identity", identity.Id },
                { "IsForwardingEnabled", false },
            };

            return await TryExecuteVoidCommand(SetCommandName, parameters);
        }

        public async Task<bool> EnableForwarding(Identity identity, string target)
        {
            var current = await GetCurrentUserRoutingSettings(identity);
            if (current == null || (current.IsUnansweredEnabled == true && !await DisableUnanswered(identity)))
            {
                return false;
            }

            if (current.IsForwardingEnabled == true
                && current.ForwardingTarget == target
                && current.ForwardingTargetType == TargetType.SingleTarget
                && current.ForwardingType == ForwardingType.Immediate)
            {
                return true;
            }

            var parameters = new Dictionary<string, object>
            {
                { "Identity", identity.Id },
                { "IsForwardingEnabled", true },
                { "ForwardingTarget", target },
                { "ForwardingTargetType", nameof(TargetType.SingleTarget) },
                { "ForwardingType", nameof(ForwardingType.Immediate) },
            };

            return await TryExecuteVoidCommand(SetCommandName, parameters);
        }

        public async Task<bool> DisableUnanswered(Identity identity)
        {
            var parameters = new Dictionary<string, object>
            {
                { "Identity", identity.Id },
                { "IsUnansweredEnabled", false },
            };

            return await TryExecuteVoidCommand(SetCommandName, parameters);
        }

        private readonly HashSet<string> EUIIFields = new(StringComparer.InvariantCultureIgnoreCase)
            {
                "Identity",
                "ForwardingTarget",
            };

        public async Task<UserRoutingSettings> GetCurrentUserRoutingSettings(Identity identity)
        {
            var parameters = new Dictionary<string, object>
            {
                { "Identity", identity.Id },
            };
            var allResults = await ExecuteCommand<IUserRoutingSettings>(GetCommandName, parameters);
            var result = allResults?.FirstOrDefault();
            if (result == null)
                return null;
            return UserRoutingSettings.ConvertFromIUserRoutingSettings(result);
        }

        private async Task<bool> TryExecuteVoidCommand(string commandName, Dictionary<string, object> parameters)
        {
            var timeoutTask = Task.Delay(TimeSpan.FromSeconds(COMMAND_TIMEOUT_SECONDS));
            using var shell = await CreateTeamsPowerShell()
                .ContinueWith(
                t => t.Result
                    .AddStatement()
                    .AddCommand(commandName)
                    .AddParameters(parameters)
                ).ConfigureAwait(false);
            AddStreamHandlers(shell);
            graphLogger.Log(TraceLevel.Verbose, $"Running {string.Join(' ', commandName, parameters.Select(p => $"-{p.Key}:{(EUIIFields.Contains(p.Key) ? "<REDACTED>" : p.Value)}"))}");
            try
            {
                var shellTask = Task.Factory.FromAsync(shell.BeginInvoke(), shell.EndInvoke).ContinueWith(t =>
                {
                    if (t.Exception != null)
                    {
                        graphLogger.Log(TraceLevel.Error, t.Exception);
                    }
                    return t.Result;
                });
                var completedTask = await Task.WhenAny(shellTask, timeoutTask).ConfigureAwait(false);
                if (completedTask == timeoutTask && !shellTask.IsCompleted)
                {
                    graphLogger.Log(TraceLevel.Warning, "Stopping execution...");
                    await Task.Factory.FromAsync(shell.BeginStop, shell.EndStop, null).ConfigureAwait(false);
                    throw new TimeoutException("Command execution timeout");
                }
                return !shell.HadErrors;
            }
            catch (Exception ex)
            {
                graphLogger.Log(TraceLevel.Error, ex);
                return false;
            }
        }

        private async Task<IEnumerable<PSObject>> ExecuteCommand(string commandName, Dictionary<string, object> parameters)
        {
            return await ExecuteCommand<PSObject>(commandName, parameters);
        }

        private async Task<IEnumerable<T>> ExecuteCommand<T>(string commandName, Dictionary<string, object> parameters)
        {
            var timeoutTask = Task.Delay(TimeSpan.FromSeconds(COMMAND_TIMEOUT_SECONDS));
            using var shell = await CreateTeamsPowerShell()
                .ContinueWith(
                t => t.Result
                    .AddStatement()
                    .AddCommand(commandName)
                    .AddParameters(parameters)
                ).ConfigureAwait(false);
            AddStreamHandlers(shell);
            graphLogger.Log(TraceLevel.Verbose, $"Running {string.Join(' ', commandName, parameters.Select(p => $"-{p.Key}:{(EUIIFields.Contains(p.Key) ? "<REDACTED>" : p.Value)}"))}");
            try
            {
                var shellTask = Task.Factory.FromAsync(shell.BeginInvoke(), shell.EndInvoke).ContinueWith(t =>
                {
                    if (t.Exception != null)
                    {
                        graphLogger.Log(TraceLevel.Error, t.Exception);
                    }
                    return t.Result;
                });
                var completedTask = await Task.WhenAny(shellTask, timeoutTask).ConfigureAwait(false);
                if (completedTask == timeoutTask && !shellTask.IsCompleted)
                {
                    graphLogger.Log(TraceLevel.Warning, "Stopping execution...");
                    await Task.Factory.FromAsync(shell.BeginStop, shell.EndStop, null).ConfigureAwait(false);
                    throw new TimeoutException("Command execution timeout");
                }
                if (shell.HadErrors)
                {
                    return null;
                }
                return shellTask.Result.Select(r => r.BaseObject).OfType<T>();
            }
            catch (Exception ex)
            {
                graphLogger.Log(TraceLevel.Error, ex);
                return null;
            }
        }

        private async Task<PowerShell> CreateTeamsPowerShell()
        {
            await Initialize().ConfigureAwait(false);
            var shell = PowerShell.Create(RunspaceMode.NewRunspace);
            shell.RunspacePool = runspacePool;
            while (shell.RunspacePool.RunspacePoolStateInfo.State != RunspacePoolState.Opened)
            {
                await Task.Delay(10);
            }
            return shell
                .AddCommand(ConnectCommandName)
                .AddParameter("Credential", adminCredential);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    runspacePool?.Dispose();
                    runspacePool = null;
                }

                disposedValue = true;
            }
        }

        public void Dispose()
        {
            // Do not change this code. Put cleanup code in 'Dispose(bool disposing)' method
            Dispose(disposing: true);
            GC.SuppressFinalize(this);
        }
    }
}
