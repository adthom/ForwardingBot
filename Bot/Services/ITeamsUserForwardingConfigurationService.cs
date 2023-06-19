namespace ForwardingBot.Bot.Services
{
    using Microsoft.Graph;
    using System.Threading;
    using System.Threading.Tasks;
    
    public interface ITeamsUserForwardingConfigurationService
    {
        Task<bool> DisableForwarding(Identity identity);
        Task<bool> EnableForwarding(Identity identity, string target);
    }
}