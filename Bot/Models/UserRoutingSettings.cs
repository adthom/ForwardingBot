using Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models;
using System;
using System.Management.Automation;

namespace ForwardingBot.Bot.Models
{
    public class UserRoutingSettings
    {
        public TimeSpan? CallGroupDetailDelay { get; set; }
        public string CallGroupOrder { get; set; }
        public string[] CallGroupTargets { get; set; }
        public IDelegationDetail[] Delegates { get; set; }
        public IDelegationDetail[] Delegators { get; set; }
        public string ForwardingTarget { get; set; }
        public TargetType? ForwardingTargetType { get; set; }
        public ForwardingType? ForwardingType { get; set; }
        public ICallGroupMembershipDetails[] GroupMembershipDetails { get; set; }
        public string GroupNotificationOverride { get; set; }
        public bool? IsForwardingEnabled { get; set; }
        public bool? IsUnansweredEnabled { get; set; }
        public string SipUri { get; set; }
        public TimeSpan? UnansweredDelay { get; set; }
        public string UnansweredTarget { get; set; }
        public TargetType? UnansweredTargetType { get; set; }

        public static UserRoutingSettings ConvertFromPSObject(PSObject pSObject) => new()
        {
            CallGroupDetailDelay = pSObject.Properties[nameof(CallGroupDetailDelay)].Value != null
                        ? TimeSpan.Parse((string)pSObject.Properties[nameof(CallGroupDetailDelay)].Value)
                        : null,
            CallGroupOrder = (string)pSObject.Properties[nameof(CallGroupOrder)].Value,
            Delegates = (IDelegationDetail[])pSObject.Properties[nameof(Delegates)].Value,
            Delegators = (IDelegationDetail[])pSObject.Properties[nameof(Delegators)].Value,
            CallGroupTargets = (string[])pSObject.Properties[nameof(CallGroupTargets)].Value,
            ForwardingTarget = (string)pSObject.Properties[nameof(ForwardingTarget)].Value,
            ForwardingTargetType = (TargetType?)(pSObject.Properties[nameof(ForwardingTargetType)].Value != null
                    ? Enum.Parse(typeof(TargetType), (string)pSObject.Properties[nameof(ForwardingTargetType)].Value)
                    : null),
            ForwardingType = (ForwardingType?)(pSObject.Properties[nameof(ForwardingType)].Value != null
                    ? Enum.Parse(typeof(ForwardingType), (string)pSObject.Properties[nameof(ForwardingType)].Value)
                    : null),
            GroupMembershipDetails = (ICallGroupMembershipDetails[])pSObject.Properties[nameof(GroupMembershipDetails)].Value,
            GroupNotificationOverride = (string)pSObject.Properties[nameof(GroupNotificationOverride)].Value,
            IsForwardingEnabled = (bool?)pSObject.Properties[nameof(IsForwardingEnabled)].Value,
            IsUnansweredEnabled = (bool?)pSObject.Properties[nameof(IsUnansweredEnabled)].Value,
            SipUri = (string)pSObject.Properties[nameof(SipUri)].Value,
            UnansweredDelay = pSObject.Properties[nameof(UnansweredDelay)].Value != null
                        ? TimeSpan.Parse((string)pSObject.Properties[nameof(UnansweredDelay)].Value)
                        : null,
            UnansweredTarget = (string)pSObject.Properties[nameof(UnansweredTarget)].Value,
            UnansweredTargetType = (TargetType?)(pSObject.Properties[nameof(UnansweredTargetType)].Value != null
                    ? Enum.Parse(typeof(TargetType), (string)pSObject.Properties[nameof(UnansweredTargetType)].Value)
                    : null),
        };

        public static UserRoutingSettings ConvertFromIUserRoutingSettings(IUserRoutingSettings userRoutingSettings) => new()
        {
            CallGroupDetailDelay = userRoutingSettings.CallGroupDetailDelay != null
                ? TimeSpan.Parse(userRoutingSettings.CallGroupDetailDelay)
                : null,
            CallGroupOrder = userRoutingSettings.CallGroupOrder,
            CallGroupTargets = userRoutingSettings.CallGroupTargets,
            Delegates = userRoutingSettings.Delegates,
            Delegators = userRoutingSettings.Delegators,
            ForwardingTarget = userRoutingSettings.ForwardingTarget,
            ForwardingTargetType = (TargetType?)(userRoutingSettings.ForwardingTargetType != null
                ? Enum.Parse(typeof(TargetType), userRoutingSettings.ForwardingTargetType)
                : null),
            ForwardingType = (ForwardingType?)(userRoutingSettings.ForwardingType != null
                ? Enum.Parse(typeof(ForwardingType), userRoutingSettings.ForwardingType)
                : null),
            GroupMembershipDetails = userRoutingSettings.GroupMembershipDetails,
            GroupNotificationOverride = userRoutingSettings.GroupNotificationOverride,
            IsForwardingEnabled = userRoutingSettings.IsForwardingEnabled,
            IsUnansweredEnabled = userRoutingSettings.IsUnansweredEnabled,
            SipUri = userRoutingSettings.SipUri,
            UnansweredDelay = userRoutingSettings.UnansweredDelay != null
                ? TimeSpan.Parse(userRoutingSettings.UnansweredDelay)
                : null,
            UnansweredTarget = userRoutingSettings.UnansweredTarget,
            UnansweredTargetType = (TargetType?)(userRoutingSettings.UnansweredTargetType != null
                ? Enum.Parse(typeof(TargetType), userRoutingSettings.UnansweredTargetType)
                : null),
        };

    }

    public enum ForwardingType
    {
        Immediate,
        Simultaneous
    }

    public enum TargetType
    {
        Voicemail,
        SingleTarget,
        MyDelegates,
        Group
    }
}
