# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this file is to throw an error message that it is deprecated or there is equivalent cmdlets that do the work

function Invoke-CsDeprecatedError {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [System.String]
        # Error action.
        ${DeprecatedErrorMessage},

        [Parameter(Mandatory=$false)]
        [System.Collections.Hashtable]
        $PropertyBag
    )

    process {
        Write-Error -Message $DeprecatedErrorMessage
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Format enum of the cmdlet output

class ProcessedGetOnlineEnhancedEmergencyServiceDisclaimerResponse {
    [string]$Country
    [string]$Version
    [string]$Content
    [string]$Response
    [string]$RespondedByObjectId
    [DateTime]$ResponseTimestamp
    [string]$CorrelationId
    [string]$Locale
}

function Get-CsOnlineEnhancedEmergencyServiceDisclaimerModern {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true)]
        [System.String]
        # CountryOrRegion of the Emergency Disclaimer
        ${CountryOrRegion},
        
        [Parameter(Mandatory=$false)]
        [System.String]
        # Version of the Emergency Disclaimer
        ${Version},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try 
        {
            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $edresponse = ''
            
            $input = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsOnlineEnhancedEmergencyServiceDisclaimer @PSBoundParameters -ErrorAction Stop @httpPipelineArgs

            if ($input -ne $null -and $input.Response -ne $null)
            {
                switch ($input.Response)
                {
                    0 {$edresponse = 'None'}
                    1 {$edresponse = 'Accepted'}
                    2 {$edresponse = 'NotAccepted'}
                }

                $result = [ProcessedGetOnlineEnhancedEmergencyServiceDisclaimerResponse]::new()
                $result.Content = $input.Content
                $result.CorrelationId = $input.CorrelationId
                $result.Country = $input.Country
                $result.Locale = $input.Locale
                $result.RespondedByObjectId = $input.RespondedByObjectId
                $result.Response = $edresponse
                $result.ResponseTimestamp = $input.ResponseTimestamp
                $result.Version = $input.Version

                return $result   
            }
        }
        catch
        {
            Write-Host $_
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Provide option to Accept or Reject Disclaimer

class ProcessedSetOnlineEnhancedEmergencyServiceDisclaimerResponse {
    [string]$Country
    [string]$Version
    [string]$Content
    [string]$Response
    [string]$RespondedByObjectId
    [DateTime]$ResponseTimestamp
    [string]$CorrelationId
    [string]$Locale
}

function Set-CsOnlineEnhancedEmergencyServiceDisclaimerModern {
    [CmdletBinding(PositionalBinding=$false)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # CountryOrRegion of the Emergency Disclaimer
        ${CountryOrRegion},
        [Parameter(Mandatory=$false, position=1)]
        [System.String]
        # Version of the Emergency Disclaimer
        ${Version},
        [Parameter(Mandatory=$false)]
        [System.Management.Automation.SwitchParameter]
        # ForceAccept Emergency Disclaimer, Disclaimer will pop up without this parameter provided
        ${ForceAccept},
        [Parameter(Mandatory=$false)]
        [System.String]
        # Response of the Emergency Disclaimer
        ${Response},
        [Parameter(Mandatory=$false)]
        [System.String]
        # RespondedByObjectId of the Emergency Disclaimer
        ${RespondedByObjectId},
        [Parameter(Mandatory=$false)]
        [System.String]
        # ResponseTimestamp of the Emergency Disclaimer
        ${ResponseTimestamp},
        [Parameter(Mandatory=$false)]
        [System.String]
        # Locale of the Emergency Disclaimer
        ${Locale},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $ged = $null
            $edContent = $null
            $edCountry = $null
            $edVersion = $null
            $edResponse = $null
            $edRespondedByObjectId = $null
            $edResponseTimestamp = $null
            $edLocale = $null

            try
            {
                $ged = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsOnlineEnhancedEmergencyServiceDisclaimer @PSBoundParameters -ErrorAction Stop @httpPipelineArgs
                $edContent = Out-String -InputObject $ged.Content
                $edCountry = Out-String -InputObject $ged.Country
                $edVersion = Out-String -InputObject $ged.Version
                $edResponse = Out-String -InputObject $ged.Response
                $edRespondedByObjectId = Out-String -InputObject $ged.RespondedByObjectId
                $edResponseTimestamp = [DateTime]::UtcNow.ToString('u')
                $edLocale = Out-String -InputObject $ged.Locale

                if ([string]::IsNullOrEmpty($edContent))
                {
                    $DiagnosticCode = Out-String -InputObject $ged.DiagnosticCode
                    $DiagnosticCorrelationId = Out-String -InputObject $ged.DiagnosticCorrelationId
                    #$DiagnosticDebugContent = Out-String -InputObject $ged.DiagnosticDebugContent
                    $DiagnosticGenevaLogsUrl = Out-String -InputObject $ged.DiagnosticGenevaLogsUrl
                    $DiagnosticReason = Out-String -InputObject $ged.DiagnosticReason
                    $DiagnosticSubCode = Out-String -InputObject $ged.DiagnosticSubCode
                
                    Write-Host "DiagnosticCode : "$DiagnosticCode
                    Write-Host "DiagnosticCorrelationId :" $DiagnosticCorrelationId
                    #Write-Host $DiagnosticDebugContent
                    Write-Host "DiagnosticGenevaLogsUrl : " $DiagnosticGenevaLogsUrl
                    Write-Host "DiagnosticReason : " $DiagnosticReason
                    Write-Host "DiagnosticSubCode : "$DiagnosticSubCode
                    Return
                }
            } catch {
                throw
            }
        
            if(!${ForceAccept})
            {
                $confirmation = Read-Host $edContent"`n[Y] Yes  [N] No  (default is `"N`")"
                switch($confirmation) {
                    'Y' {
                        Break
                    }
                    Default {
                    Return
                    }
                }

            } else {
                $null = $PSBoundParameters.Remove('ForceAccept')
            }

            try {

                [System.String[]]$global:configscopes = @("48ac35b8-9aa8-4d74-927d-1f4a14a0b239/user_impersonation")
            
                Write-Host "Timestamp " $edResponseTimestamp

                $edResponse = 1

                Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsOnlineEnhancedEmergencyServiceDisclaimer -Country ${CountryOrRegion} -Version ${Version} -Content $edContent -Response $edResponse -RespondedByObjectId $edRespondedByObjectId  -ResponseTimestamp $edResponseTimestamp -Locale ${Locale}  -ErrorAction Stop @httpPipelineArgs
            } catch {
                throw
            }   
            
        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: transforming the results to the custom objects

function Get-CsConfigurationModern {
    [CmdletBinding(DefaultParameterSetName = 'ConfigType')]
    param(
        [Parameter(Mandatory=$true, ParameterSetName='ConfigType')]
        [Parameter(Mandatory=$true, ParameterSetName='Identity')]
        [Parameter(Mandatory=$true, ParameterSetName='Filter')]
        [System.String]
        # Type of configuration retrieved.
        ${ConfigType},

        [Parameter(Mandatory=$true, ParameterSetName='Identity')]
        [System.String]
        # Name of configuration retrieved.
        ${Identity},

        [Parameter(Mandatory=$true, ParameterSetName='Filter')]
        [System.String]
        # Name of configuration retrieved.
        ${Filter},

        [Parameter(Mandatory=$false)]
        [System.Collections.Hashtable]
        ${PropertyBag},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $null = $customCmdletUtils.ProcessArgs()

            $xdsConfigurationOutput0 = $null

            $HashArguments = @{ ConfigType = $ConfigType}

            if (![string]::IsNullOrWhiteSpace($Identity))
            {
                $HashArguments.Add('ConfigName', $Identity)
            }

            $TeamsMeetingBroadcastConfiguration_FixupFormat = $false

            if($PropertyBag -ne $null)
            {
                if($ConfigType -eq 'TeamsMeetingBroadcastConfiguration')
                {
                    if($PropertyBag['ExposeSDNConfigurationJsonBlob'] -eq $true)
                    {
                        $TeamsMeetingBroadcastConfiguration_FixupFormat = $true
                        $HashArguments.Add('HttpPipelinePrepend', { param($req, $callback, $next )  $req.RequestUri = [Uri]($req.RequestUri.ToString() + '?ExposeSDNConfigurationJsonBlob=true'); return $next.SendAsync($req, $callback); })
                    }
                }
                else
                {
                    #ignore
                }
            }

            $null = $customCmdletUtils.PutHttpPipelineSteps($HashArguments)

            $xdsConfigurationOutput0 = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsConfiguration @HashArguments

            $xdsConfigurationOutput = ($xdsConfigurationOutput0 | %{
                Convert-PsCustomObjectToPsObject (ConvertFrom-Json -InputObject $_)
            })

            if (![string]::IsNullOrWhiteSpace($Filter))
            {
                $xdsConfigurationOutput = $xdsConfigurationOutput | Where-Object {($_.Identity -Like "$Filter") -or ($_.Identity -Like "Tag:$Filter")}
            }

            $xdsConfigurationOutput = $xdsConfigurationOutput | %{ Set-FormatOnConfigObject -ConfigObject $_ -ConfigType $ConfigType }

            if($ConfigType -eq 'TenantFederationSettings')
            {
                $xdsConfigurationOutput = $xdsConfigurationOutput | %{ Convert-PsCustomObjectToPsObject (Set-FixTenantFedConfigObject -ConfigObject $_) }
            }

            if($ConfigType -eq 'OnlinePSTNGateway')
            {
                $xdsConfigurationOutput = $xdsConfigurationOutput | %{ Convert-PsCustomObjectToPsObject (Set-FixTypoInOnlinePSTNGatewayConfigObject -ConfigObject $_) }
            }

            if($TeamsMeetingBroadcastConfiguration_FixupFormat)
            {
                #why are we special handling this? when legacy is run, the format type name is sdnconfigurationextension which is not a wellknown type inside SfbRpsModule.format.ps1xml
                #so we hack this here so that we order them and select what we need (so we dont return key, datasource)
                $xdsConfigurationOutput = ($xdsConfigurationOutput | select Identity, SupportURL, AllowSdnProviderForBroadcastMeeting, SdnName, SdnLicenseId, SdnAzureSubscriptionId, SdnApiTemplateUrl, SdnApiToken, SdnRuntimeconfiguration, SdnAttendeeFallbackCount)
            }

            return (Sort-GlobalFirst $xdsConfigurationOutput)

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}

# output Identity=Global before other identities
function Sort-GlobalFirst($out)
{
    # keep legacy behavior to return nothing instead of $null when nothing is found
    if (($out | measure).Count -eq 0) { return }

    $out | ?{ $_.Identity -eq "Global" }
    $out | ?{ $_.Identity -ne "Global" }
}

# convert PSCustom Object to PSObject by using psserializer
function Custom-ToString($xnode)
{
    $props_to_hide = @("Element","XsAnyElements","XsAnyAttributes")

    $nodes = $xnode.SelectNodes('*[name() = "MS" or name() = "Props"]/*')
    $values = ($nodes | % {
        if ($_.N -notin $props_to_hide)
        {
            $val = $_.SelectSingleNode("text()").Value
            if ($_.Name -eq "B") { $val = [bool]::Parse($val)}
            "$($_.N)=$val"
        }
    })
    if ($values) { [string]::Join(";", $values) }
}

function Convert-PsCustomObjectToPsObject($in)
{
    $serialized = [System.Management.Automation.PSSerializer]::Serialize($in)
    $xml = [xml]$serialized
    foreach ($obj in $xml.GetElementsByTagName("Obj"))
    {
        if ($obj.Item("LST") -eq $null -and $obj.Item("Props") -eq $null)
        {
            $props = $xml.CreateElement("Props", $xml.Objs.xmlns)
            $null = $obj.PrependChild($props)

            if ($obj.Item("ToString") -eq $null)
            {
                $text = Custom-ToString $obj
                if ($text -ne $null)
                {
                    $tostring = $xml.CreateElement("ToString", $xml.Objs.xmlns)
                    $tostring.InnerText = $text
                    $null = $obj.PrependChild($tostring)
                }
            }
        }
    }
    return [System.Management.Automation.PSSerializer]::Deserialize($xml.OuterXml)
}

function Get-FormatsForConfig {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [string]
        # The int status from status record
        ${ConfigType}
    )
    process {
        # order of values like value1 and value2 is important in lines like "ConfigType=value1, value2"
        $mappings = @(
            "ApplicationAccessPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Meeting.ApplicationAccessPolicy",
            "ApplicationMeetingConfiguration=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.PlatformApplications.ApplicationMeetingConfiguration",
            "CallingLineIdentity=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Voice.CallingLineIdentity",
            "DialPlan=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Voice.LocationProfile",
            "ExternalAccessPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.ExternalAccess.ExternalAccessPolicy",
            "InboundBlockedNumberPattern=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Voice.InboundBlockedNumberPattern#Decorated,Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Voice.InboundBlockedNumberPattern",
            "InboundExemptNumberPattern=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Voice.InboundExemptNumberPattern#Decorated,Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Voice.InboundExemptNumberPattern",
            "OnlineAudioConferencingRoutingPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Voice.OnlineAudioConferencingRoutingPolicy",
            "OnlineDialinConferencingPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.OnlineDialinConferencing.OnlineDialinConferencingPolicy",
            "OnlineDialinConferencingTenantConfiguration=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.OnlineDialInConferencing.OnlineDialinConferencingTenantConfiguration",
            "OnlineDialInConferencingTenantSettings=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.OnlineDialInConferencing.OnlineDialInConferencingTenantSettings",
            "OnlineDialInConferencingTenantSettings.AllowedDialOutExternalDomains=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.OnlineDialInConferencing.OnlineDialInConferencingAllowedDomain",
            "OnlineDialOutPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.OnlineDialOut.OnlineDialOutPolicy",
            "OnlinePSTNGateway=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.AzurePSTNTrunkConfiguration.TrunkConfig#Decorated2,Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.AzurePSTNTrunkConfiguration.TrunkConfig",
            "OnlinePstnUsages=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Voice.OnlinePstnUsages",
            "OnlineVoicemailPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.OnlineVoicemail.OnlineVoicemailPolicy",
            "OnlineVoiceRoute=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Voice.OnlineRoute#Decorated",
            "OnlineVoiceRoutingPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Voice.OnlineVoiceRoutingPolicy",
            "PrivacyConfiguration=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.UserServices.PrivacyConfiguration",
            "TeamsAcsFederationConfiguration=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.AcsConfiguration.TeamsAcsFederationConfiguration",
            "TeamsAppPermissionPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsAppPermissionPolicy",
            "TeamsAppPermissionPolicy.DefaultCatalogApps=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.DefaultCatalogApp",
            "TeamsAppPermissionPolicy.GlobalCatalogApps=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.GlobalCatalogApp",
            "TeamsAppPermissionPolicy.PrivateCatalogApps=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.PrivateCatalogApp",
            "TeamsAppSetupPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsAppSetupPolicy",
            "TeamsAppSetupPolicy.AppPresetList=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.AppPreset",
            "TeamsAppSetupPolicy.AppPresetMeetingList=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.AppPresetMeeting",
            "TeamsAppSetupPolicy.PinnedAppBarApps=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.PinnedApp",
            "TeamsAppSetupPolicy.PinnedMessageBarApps=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.PinnedMessageBarApp",
            "TeamsAudioConferencingPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.TeamsAudioConferencing.TeamsAudioConferencingPolicy",
            "TeamsCallHoldPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsCallHoldPolicy",
            "TeamsCallingPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsCallingPolicy",
            "TeamsCallParkPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsCallParkPolicy",
            "TeamsChannelsPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsChannelsPolicy",
            "TeamsClientConfiguration=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TeamsConfiguration.TeamsClientConfiguration",
            "TeamsComplianceRecordingApplication=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.ComplianceRecordingApplication#Decorated,Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.ComplianceRecordingApplication",
            "TeamsComplianceRecordingApplication.ComplianceRecordingPairedApplications=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.ComplianceRecordingPairedApplication",
            "TeamsComplianceRecordingPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsComplianceRecordingPolicy",
            "TeamsComplianceRecordingPolicy.ComplianceRecordingApplications=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.ComplianceRecordingApplication",
            "TeamsCortanaPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsCortanaPolicy",
            "TeamsEducationAssignmentsAppPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsEducationAssignmentsAppPolicy",
            "TeamsEducationConfiguration=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TeamsConfiguration.TeamsEducationConfiguration",
            "TeamsEmergencyCallingPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsEmergencyCallingPolicy",
            "TeamsEmergencyCallRoutingPolicy.EmergencyNumbers=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsEmergencyNumber",
            "TeamsEmergencyCallRoutingPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsEmergencyCallRoutingPolicy",
            "TeamsFeedbackPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsFeedbackPolicy",
            "TeamsGuestCallingConfiguration=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TeamsConfiguration.TeamsGuestCallingConfiguration",
            "TeamsGuestMeetingConfiguration=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TeamsConfiguration.TeamsGuestMeetingConfiguration",
            "TeamsGuestMessagingConfiguration=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TeamsConfiguration.TeamsGuestMessagingConfiguration",
            "TeamsIPPhonePolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsIPPhonePolicy",
            "TeamsMeetingBroadcastConfiguration=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TeamsConfiguration.TeamsMeetingBroadcastConfiguration",
            "TeamsMeetingBroadcastPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsMeetingBroadcastPolicy",
            "TeamsMeetingConfiguration=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TeamsMeetingConfiguration.TeamsMeetingConfiguration",
            "TeamsMeetingPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Meeting.TeamsMeetingPolicy",
            "TeamsMessagingPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsMessagingPolicy",
            "TeamsMigrationConfiguration=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TeamsMigrationConfiguration.TeamsMigrationConfiguration",
            "TeamsMobilityPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsMobilityPolicy",
            "TeamsNetworkRoamingPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsNetworkRoamingPolicy",
            "TeamsNotificationAndFeedsPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsNotificationAndFeedsPolicy",
            "TeamsShiftsAppPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsShiftsAppPolicy",
            "TeamsShiftsPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsShiftsPolicy",
            "TeamsSurvivableBranchAppliance=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Voice.SurvivableBranchAppliance#Decorated",
            "TeamsSurvivableBranchAppliancePolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Voice.TeamsBranchSurvivabilityPolicy",
            "TeamsTranslationRule=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.AzurePSTNTrunkConfiguration.PstnTranslationRule#Decorated",
            "TeamsTargetingPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsTargetingPolicy",
            "TeamsUnassignedNumberTreatment=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.UnassignedNumberTreatmentConfiguration.UnassignedNumberTreatment#Decorated",
            "TeamsUpdateManagementPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsUpdateManagementPolicy",
            "TeamsUpgradeConfiguration=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TeamsConfiguration.TeamsUpgradeConfiguration",
            "TeamsUpgradePolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsUpgradePolicy",
            "TeamsVdiPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsVdiPolicy",
            "TeamsVideoInteropServicePolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsVideoInteropServicePolicy",
            "TeamsVoiceApplicationsPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsVoiceApplicationsPolicy",
            "TeamsWorkLoadPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsWorkLoadPolicy",
            "TenantBlockedCallingNumbers=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Voice.TenantBlockedCallingNumbers",
            "TenantBlockedCallingNumbers.InboundBlockedNumberPatterns=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Voice.InboundBlockedNumberPattern",
            "TenantBlockedCallingNumbers.InboundExemptNumberPatterns=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Voice.InboundExemptNumberPattern",
            "TenantDialPlan=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Voice.TenantDialPlan",
            "TenantDialPlan.NormalizationRules=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Voice.NormalizationRule",
            "TenantFederationSettings=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.Edge.TenantFederationSettings",
            "TenantFederationSettings.AllowedDomains=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.Edge.AllowList",
            "TenantFederationSettings.BlockedDomains=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.Edge.DomainPattern",
            "TenantLicensingConfiguration=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TenantConfiguration.TenantLicensingConfiguration",
            "TenantMigrationConfiguration=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TenantMigration.TenantMigrationConfiguration",
            "TenantNetworkConfiguration=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TenantNetworkConfiguration.TenantNetworkConfigurationSettings",
            "TenantNetworkConfiguration.NetworkRegions=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TenantNetworkConfiguration.NetworkRegionType#Decorated",
            "TenantNetworkConfiguration.NetworkSites=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TenantNetworkConfiguration.DisplayNetworkSiteWithExpandParametersType#Decorated",
            "TenantNetworkConfiguration.Subnets=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TenantNetworkConfiguration.SubnetType#Decorated",
            "TenantNetworkRegion=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TenantNetworkConfiguration.DisplayNetworkRegionType#Decorated",
            "TenantNetworkSite=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TenantNetworkConfiguration.DisplayNetworkSiteWithExpandParametersType#Decorated",
            "TenantNetworkSubnet=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TenantNetworkConfiguration.SubnetType#Decorated",
            "TenantTrustedIPAddress=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TenantNetworkConfiguration.TrustedIP#Decorated",
            "TeamsFilesPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsFilesPolicy",
            "TeamsEnhancedEncryptionPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsEnhancedEncryptionPolicy",
            "TeamsMediaLoggingPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsMediaLoggingPolicy",
            "TeamsRoomVideoTeleConferencingPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsRoomVideoTeleConferencingPolicy",
            "TeamsEventsPolicy=Deserialized.Microsoft.Rtc.Management.WritableConfig.Policy.Teams.TeamsEventsPolicy",
            "VideoInteropServiceProvider=Deserialized.Microsoft.Rtc.Management.WritableConfig.Settings.TenantVideoInteropServiceConfiguration.VideoInteropServiceProvider#Decorated",
            "HostingProvider=Microsoft.Rtc.Management.WritableConfig.Settings.Edge.Hosted.DisplayHostingProviderExtended"
        )

        $mappings | where {$_.StartsWith("$ConfigType")}
    }
}

function Set-FormatOnConfigObject {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true)]
        # Object on which typenames need to be set
        ${ConfigObject},

        [Parameter(Mandatory=$true)]
        # Type of configuration
        ${ConfigType}
    )
    process {
        $mappings = Get-FormatsForConfig -ConfigType $ConfigType
        $parenttn = $mappings | where {$_.StartsWith("$ConfigType=")}
        $parenttnList = $parenttn.Split("=")[1].Split(",")
        $childtnmappings = $mappings | where {$_.StartsWith("$ConfigType.")}

        foreach ($inst in $ConfigObject)
        {
            for ($i = 0; $i -lt $parenttnList.Count; $i++)
            {
                $inst.PsObject.TypeNames.Insert($i, $parenttnList[$i])
            }

            foreach($tn in $childtnmappings)
            {
                $childtn = $tn.Split("=")[1]
                $childPropName = $tn.Split("=")[0].Split(".")[1]
                foreach($instc in $inst.$childPropName)
                {
                    $instc.PsObject.TypeNames.Insert(0,$childtn)
                }
            }
        }

        return $ConfigObject
    }
}

function Set-FixToStringOnAllowedDomains($in, $val)
{
    $serialized = [System.Management.Automation.PSSerializer]::Serialize($in)
    $xml = [xml]$serialized
    foreach ($obj in $xml.GetElementsByTagName("Obj"))
    {
        if ($obj.Attributes["N"].'#text' -eq 'AllowedDomains')
        {
            if ($obj.Item("ToString") -ne $null)
            {
                $obj.Item("ToString").'#text' = $val
            }
        }
    }
    return [System.Management.Automation.PSSerializer]::Deserialize($xml.OuterXml)
}

function Set-FixTenantFedConfigObject {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true)]
        # Object for Get-CsTenantFederationConfiguration
        ${ConfigObject}
    )
    process {
        if($ConfigObject.AllowedDomains.AllowedDomain -eq $null)
		{
			$ConfigObject.AllowedDomains = New-CsEdgeAllowAllKnownDomains -MsftInternalProcessingMode TryModern
		}
		elseif($ConfigObject.AllowedDomains.AllowedDomain.Count -eq 0)
		{
			$ConfigObject = Set-FixToStringOnAllowedDomains -val "" -in  $ConfigObject
		}
		elseif($ConfigObject.AllowedDomains.AllowedDomain.Count -gt 0)
		{
			$str = "Domain=" + [string]::join(",Domain=",$ConfigObject.AllowedDomains.AllowedDomain.Domain)
			$ConfigObject = Set-FixToStringOnAllowedDomains -val $str -in  $ConfigObject
		}

		return $ConfigObject
    }
}

#Add proerty OutboundTeamsNumberTranslationRules into the response object
function Set-FixTypoInOnlinePSTNGatewayConfigObject {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true)]
        # Object for Get-CsOnlinePSTNGateway
        ${ConfigObject}
    )
    process {
        foreach ($inst in $ConfigObject)
        {
			$inst | Add-Member NoteProperty 'OutboundTeamsNumberTranslationRules' $inst.OutbundTeamsNumberTranslationRules
		}

		return $ConfigObject
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Transfer $PolicyRankings from user's input from string[] to object[]

function Grant-CsGroupPolicyPackageAssignment {
    [OutputType([System.String])]
    [CmdletBinding(DefaultParameterSetName='RequiredPolicyList',
               PositionalBinding=$false,
               SupportsShouldProcess,
               ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true, position=0)]
        $GroupId,

        [Parameter(Mandatory=$false, position=1)]
        [AllowNull()]
        [AllowEmptyString()]
        $PackageName,

        [Parameter(position=2)]
        [System.String[]]
        $PolicyRankings,

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {
            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $Delimiters = ",", ".", ":", ";", " ", "`t"
            [psobject[]]$InternalRankingList = @()
            foreach ($PolicyTypeAndRank in $PolicyRankings)
            {
                $PolicyTypeAndRankArray = $PolicyTypeAndRank -Split {$Delimiters -contains $_}, 2
                $PolicyTypeAndRankArray = $PolicyTypeAndRankArray.Trim()
                if ($PolicyTypeAndRankArray.Count -lt 2)
                {
                    throw "Invalid Policy Type and Rank pair: $PolicyTypeAndRank. Please use a proper delimeter"
                }
                $PolicyTypeAndRankObject = [psobject]@{
                    PolicyType = $PolicyTypeAndRankArray[0]
                    Rank = $PolicyTypeAndRankArray[1] -as [int]
                }
                $InternalRankingList += $PolicyTypeAndRankObject
            }
            $null = $PSBoundParameters.Remove("PolicyRankings")
            $null = $PSBoundParameters.Add("PolicyRankings", $InternalRankingList)
            Microsoft.Teams.ConfigAPI.Cmdlets.internal\Grant-CsGroupPolicyPackageAssignment @PSBoundParameters @httpPipelineArgs
        }
        catch
        {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Integrate Grant-CsTeamsPolicy with Grant-CsUserPolicy, Grant-CsTenantPolicy, and Group grant

function Grant-CsTeamsPolicy {
    [CmdletBinding(PositionalBinding=$true, DefaultParameterSetName="Identity", SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param(
        [ArgumentCompleter({param ($CommandName, $ParameterName, $WordToComplete, $CommandAst, $FakeBoundParameters) return @("ApplicationAccessPolicy","BroadcastMeetingPolicy","CallingLineIdentity","ClientPolicy","CloudMeetingPolicy","ConferencingPolicy","DialoutPolicy","ExternalAccessPolicy","ExternalUserCommunicationPolicy","GraphPolicy","GroupPolicyPackageAssignment","HostedVoicemailPolicy","IPPhonePolicy","MobilityPolicy","OnlineAudioConferencingRoutingPolicy","OnlineVoicemailPolicy","OnlineVoiceRoutingPolicy","Policy","TeamsAppPermissionPolicy","TeamsAppSetupPolicy","TeamsAudioConferencingPolicy","TeamsCallHoldPolicy","TeamsCallingPolicy","TeamsCallParkPolicy","TeamsChannelsPolicy","TeamsComplianceRecordingPolicy","TeamsCortanaPolicy","TeamsEmergencyCallingPolicy","TeamsEmergencyCallRoutingPolicy","TeamsEnhancedEncryptionPolicy","TeamsFeedbackPolicy","TeamsFilesPolicy","TeamsIPPhonePolicy","TeamsMeetingBroadcastPolicy","TeamsMeetingPolicy","TeamsMessagingPolicy","TeamsMobilityPolicy","TeamsShiftsPolicy","TeamsSurvivableBranchAppliancePolicy","TeamsUpdateManagementPolicy","TeamsUpgradePolicy","TeamsVdiPolicy","TeamsVerticalPackagePolicy","TeamsVideoInteropServicePolicy","TeamsWorkLoadPolicy","TenantDialPlan","UserOrTenantPolicy","UserPolicyPackage","VoiceRoutingPolicy") | ?{ $_ -like "$WordToComplete*" } })]
        [Parameter(Mandatory=$true)]
        [System.String]
        # Type of the policy
        ${PolicyType},

        [Parameter(Mandatory=$false, Position=1)]
        [System.String]
        # Name of the policy instance
        ${PolicyName},

        # Mandatory=$false allows for deprecated "identity=$null means Grant-to-tenant" behavior
        # eventually we should set Mandatory=$true and require preferred -Global switch for that
        [Parameter(Mandatory=$false, Position=0, ParameterSetName="Identity", ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        # Unique identifier for the user
        ${Identity},

        [Parameter(Mandatory=$true, Position=0, ParameterSetName="GrantToTenant")]
        [Switch]
        # Use global indicating grant to tenant
        ${Global},

        [Parameter(Mandatory=$true, Position=0, ParameterSetName="GrantToGroup")]
        [ValidateNotNullOrEmpty()]
        [System.String]
        # Unique identifier for the group
        ${Group},
        
        [Parameter(Mandatory=$false, ParameterSetName="GrantToGroup")]
        [Nullable[int]]
        ${Rank},

        [Parameter(Mandatory=$false)]
        ${AdditionalParameters},

        [Parameter(Mandatory=$false)]
        [Switch]
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try
        {
            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()
        
            if (-not $PSBoundParameters.ContainsKey("PolicyName"))
            {
                # this parameter should be Mandatory=$true, however the [AllowNull]/[AllowEmptyString] attributes don't get surfaced to the wrapper cmdlet that is generated
                throw [System.Management.Automation.ParameterBindingException]::new("Cannot process command because of one or more missing mandatory parameters: PolicyName.")
            }

            if ($PsCmdlet.ParameterSetName -eq "GrantToGroup")
            {
                $parameters = @{
                    GroupId=$Group
                    PolicyType=$PolicyType
                    PolicyName=$PolicyName
                }
                if ($Rank) { $parameters["Rank"] = $Rank }

                Microsoft.Teams.ConfigAPI.Cmdlets.internal\Grant-CsGroupPolicyAssignment @parameters
            }
            elseif ([string]::IsNullOrWhiteSpace($Identity))
            {
                if (-not $Global)
                {
                    # The only way to grant to tenant is to use -Global
                    throw [System.Management.Automation.ParameterBindingException]::new("Cannot process command because of one or more missing mandatory parameters: Global.")
                }
                else
                {
                    Microsoft.Teams.ConfigAPI.Cmdlets.internal\Grant-CsTenantPolicy -PolicyType $PolicyType -PolicyName $PolicyName -AdditionalParameters $AdditionalParameters -forceSwitchPresent:$Force
                }
            }
            else
            {
                Microsoft.Teams.ConfigAPI.Cmdlets.internal\Grant-CsUserPolicy -Identity $Identity -PolicyType $PolicyType -PolicyName $PolicyName -AdditionalParameters $AdditionalParameters
            }
        }
        catch
        {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: transforming the results to the custom objects

function New-CsConfigurationModern {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [System.String]
        # Type of configuration retrieved.
        ${ConfigType},

        [Parameter(Mandatory=$true)]
        [System.Collections.Hashtable]
        ${PropertyBag},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            #Todo: validate that $PropertyBag contains Identity or just depend on the service to reject otherwise
            $xdsConfigurationOutput = $null

            Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsConfiguration -ConfigType $ConfigType -Body $PropertyBag -ErrorVariable err @httpPipelineArgs
            if ($err) { return }

            #Todo - Handle where new failed - because the identity already exists, rbac or someother server error
            #Todo: Ensure to test this under TPM, given we are referring the Microsoft.Teams.ConfigAPI.Cmdlets module
            $xdsConfigurationOutput = Get-CsConfigurationModern -ConfigType $ConfigType -Identity $PropertyBag['Identity']

            $xdsConfigurationOutput

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: transforming the identity

function Remove-CsConfigurationModern {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [System.String]
        # Type of configuration deleted.
        ${ConfigType},

		[Parameter(Mandatory=$true)]
        [System.String]
        # Name of configuration deleted.
        ${Identity},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            Microsoft.Teams.ConfigAPI.Cmdlets.internal\Remove-CsConfiguration -ConfigType $ConfigType -ConfigName $Identity @httpPipelineArgs

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: transforming the results to the custom objects

function Set-CsConfigurationModern {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [System.String]
        # Type of configuration retrieved.
        ${ConfigType},

        [Parameter(Mandatory=$true)]
        [System.Collections.Hashtable]
        ${PropertyBag},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()
        
            if(!($PropertyBag.ContainsKey('Identity')))
            {
                $PropertyBag['Identity'] =  "Global"
            }

            Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsConfiguration -ConfigType $ConfigType -ConfigName $PropertyBag['Identity'] -Body $PropertyBag @httpPipelineArgs

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

function Clear-CsOnlineTelephoneNumberOrder {
    [CmdletBinding(PositionalBinding=$false)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # OrderId of the Search Order
        ${OrderId},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {
            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Add("Action", "Cancel")
            Microsoft.Teams.ConfigAPI.Cmdlets.internal\Complete-CsOnlineTelephoneNumberOrder @PSBoundParameters -ErrorAction Stop @httpPipelineArgs
        
        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

function Complete-CsOnlineTelephoneNumberOrder {
    [CmdletBinding(PositionalBinding=$false)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # OrderId of the Search Order
        ${OrderId},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Add("Action", "Complete")
            Microsoft.Teams.ConfigAPI.Cmdlets.internal\Complete-CsOnlineTelephoneNumberOrder @PSBoundParameters -ErrorAction Stop @httpPipelineArgs

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

function Remove-CsOnlineTelephoneNumberModern {
    [CmdletBinding(PositionalBinding=$false)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String[]]
        # Telephone numbers to remove
        ${TelephoneNumber},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            Microsoft.Teams.ConfigAPI.Cmdlets.internal\Remove-CsOnlineTelephoneNumberPrivate -TelephoneNumber $TelephoneNumber @httpPipelineArgs

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

function Remove-CsPhoneNumberAssignment {
    [CmdletBinding(DefaultParameterSetName="RemoveSome")]
    param(
        [Parameter(Mandatory=$true, ParameterSetName='RemoveSome')]
        [Parameter(Mandatory=$true, ParameterSetName='RemoveAll')]
        [System.String]
        ${Identity},

        [Parameter(Mandatory=$true, ParameterSetName='RemoveSome')]
        [System.String]
        ${PhoneNumber},
        
        [Parameter(Mandatory=$true, ParameterSetName='RemoveSome')]
        [System.String]
        ${PhoneNumberType},
        
        [Parameter(Mandatory=$true, ParameterSetName='RemoveAll')]
        [Switch]
        ${RemoveAll},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            Microsoft.Teams.ConfigAPI.Cmdlets.internal\Remove-CsPhoneNumberAssignment @PSBoundParameters @httpPipelineArgs

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

function Set-CsPhoneNumberAssignment {
    [CmdletBinding(DefaultParameterSetName="Assignment")]
    param(
        [Parameter(Mandatory=$true, ParameterSetName='Assignment')]
        [Parameter(Mandatory=$true, ParameterSetName='Attribute')]
        [System.String]
        ${Identity},
        
        [Parameter(Mandatory=$true, ParameterSetName='Assignment')]
        [System.String]
        ${PhoneNumber},
        
        [Parameter(Mandatory=$true, ParameterSetName='Assignment')]
        [System.String]
        ${PhoneNumberType},
        
        [Parameter(Mandatory=$false, ParameterSetName='Assignment')]
        [System.String]
        ${LocationId},
        
        [Parameter(Mandatory=$true, ParameterSetName='Attribute')]
        [System.Boolean]
        ${EnterpriseVoiceEnabled},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsPhoneNumberAssignment @PSBoundParameters @httpPipelineArgs

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Write diagnostic message back to console

function Get-CsBusinessVoiceDirectoryDiagnosticData {
    [CmdletBinding(PositionalBinding=$false)]
    param(
        [Parameter(Mandatory)]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Path')]
        [System.String]
        # PartitionKey of the table.
        ${PartitionKey},

        [Parameter(Mandatory)]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Path')]
        [System.String]
        # Region to query Bvd table.
        ${Region},

        [Parameter(Mandatory)]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Path')]
        [System.String]
        # Bvd table name.
        ${Table},

        [Parameter()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Query')]
        [System.Int32]
        # Optional resultSize.
        ${ResultSize},

        [Parameter()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Query')]
        [System.String]
        # Optional row key.
        ${RowKey},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )
    
    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try
        {
            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsBusinessVoiceDirectoryDiagnosticData @PSBoundParameters

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            $output = @()
            foreach($internalProperty in $internalOutput.Property)
            {
                $entityProperty = [Microsoft.Rtc.Management.Hosted.Group.Models.EntityProperty]::new()
                $entityProperty.ParseFrom($internalProperty)
                $output += $entityProperty
            }

            $output
        }
        catch
        {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------
# Objective of this custom file: Integrate Get-CsOnlineDialinConferencingUser with Get-CsOdcUser and Search-CsOdcUser
function Get-CsOnlineDialInConferencingUser {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$false, position=0)]
        [System.String]
        # Unique identifier for the user
        ${Identity},

        [Parameter(Mandatory=$false)]
        [System.Nullable[System.Int32]]
        # Number of users to be returned
        ${ResultSize},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            if (![string]::IsNullOrWhiteSpace($Identity))
            {
                Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsOdcUser -Identity $Identity @httpPipelineArgs
            }
            else
            {
                Microsoft.Teams.ConfigAPI.Cmdlets.internal\Search-CsOdcUser -Top $ResultSize @httpPipelineArgs
            }

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Format output of Register-CsOdcServiceNumber

function Register-CsOdcServiceNumber {
    [CmdletBinding(PositionalBinding=$false, DefaultParameterSetName="ById")]
    param(

    [string]
    [ValidateNotNullOrEmpty()]
    [Parameter(Mandatory=$true, ParameterSetName="ById", Position=0)]
    ${Identity},

    [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.ConferencingServiceNumber]
    [ValidateNotNull()]
    [Parameter(Mandatory=$true, ValueFromPipeline=$true, ParameterSetName="ByInstance")]
    ${Instance},

    [string]
    [ValidateNotNull()]
    ${BridgeId},

    [string]
    [ValidateNotNullOrEmpty()]
    ${BridgeName},

    [Alias('DC')]
    ${DomainController},

    [switch]
    ${Force},
    
    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
    ${HttpPipelinePrepend})

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()
        
            if ($Identity -ne "")
            {
                $output = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Register-CsOdcServiceNumber @PSBoundParameters @httpPipelineArgs
            }
            elseif ($Instance -ne $null)
            {
                $Body = [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.ConferencingServiceNumber]::new()
                $Body.Number = $Instance.Number
                $Body.PrimaryLanguage = $Instance.PrimaryLanguage
                $Body.SecondaryLanguages = $Instance.SecondaryLanguages

                $output = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Register-CsOdcServiceNumber -Body $Body -BridgeId $BridgeId -BridgeName $BridgeName @httpPipelineArgs
            }

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Format output of Set-CsOdcBridgeModern

function Set-CsOnlineDialInConferencingBridge {
    [CmdletBinding(PositionalBinding=$false)]
    param(
    [string]
    ${Name},

    [string]
    ${DefaultServiceNumber},

    [switch]
    ${SetDefault},

    [string]
    ${Identity},

    [Alias('DC')]
    ${DomainController},

    [switch]
    ${Force},

    [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.IConferencingBridge]
    [Parameter(ValueFromPipeline)]
    ${Instance},

    [switch]
    ${AsJob},
    
    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
    ${HttpPipelinePrepend})

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            if ($Identity -ne "") {
                # This should map to SetCsOdcBridge_SetExpanded.cs
                $output = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsOdcBridge @PSBoundParameters @httpPipelineArgs
            }
            elseif ($Name -ne "") {
                $Body = [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.BridgeUpdateRequest]::new()

                if ($PSBoundParameters.ContainsKey("DefaultServiceNumber") -and $PSBoundParameters["DefaultServiceNumber"] -ne "") {
                    $Body.DefaultServiceNumber = $DefaultServiceNumber
                }

                $Body.SetDefault = $SetDefault

                # This should map to SetCsOdcBridge_Set1.cs
                $output = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsOdcBridge -Name $Name -Body $Body @httpPipelineArgs
            }
            elseif ($Instance -ne $null) {
               if ($DefaultServiceNumber -eq "" -and !($Instance.DefaultServiceNumber -eq $null)) {
                    $DefaultServiceNumber = $Instance.DefaultServiceNumber.Number
               }

               if ($PSBoundParameters.ContainsKey('SetDefault') -eq $false) {
                   $SetDefault = $Instance.IsDefault
               }

               $Body = [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.BridgeUpdateRequest]::new()

               if ($DefaultServiceNumber -ne "") {
                $Body.DefaultServiceNumber = $DefaultServiceNumber
               }

               $Body.SetDefault = $SetDefault
               $Body.Name = $Instance.Name

               # This should map to SetCsOdcBridge_Set.cs
               $output = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsOdcBridge -Identity $Instance.Identity -Body $Body @httpPipelineArgs
            }

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Format output of Set-CsOdcUserModern

function Set-CsOnlineDialInConferencingUser {
    [CmdletBinding(PositionalBinding=$false)]
    param(
    [System.Object]
    [Parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
    ${Identity},

    [string]
    ${TollFreeServiceNumber},

    [string]
    ${BridgeName},

    [switch]
    ${SendEmail},

    [string]
    ${ServiceNumber},

    [switch]
    ${Force},

    [switch]
    ${ResetLeaderPin},

    [Alias('DC')]
    ${DomainController},

    [string]
    ${SendEmailToAddress},

    [string]
    ${BridgeId},

    [Nullable[boolean]]
    ${AllowTollFreeDialIn},

    [switch]
    ${AsJob},
    
    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
    ${HttpPipelinePrepend})

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            if ($Identity -is [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.IConferencingUser]){
                $null = $PSBoundParameters.Remove('Identity')
                $PSBoundParameters.Add('Identity', $Identity.Identity)
            }

            # Change from AllowTollFreeDialIn boolean to switch.
            if ($PSBoundParameters.ContainsKey("AllowTollFreeDialIn")){
                $null = $PSBoundParameters.Remove("AllowTollFreeDialIn")
                $output = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsOdcUser -AllowTollFreeDialIn:$AllowTollFreeDialIn @PSBoundParameters @httpPipelineArgs
            }
            else{
                $output = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsOdcUser @PSBoundParameters @httpPipelineArgs
            }

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Format output of Unregister-CsOdcServiceNumber

function Unregister-CsOdcServiceNumber {
    [CmdletBinding(PositionalBinding=$false, DefaultParameterSetName="ById")]
    param(

    [string]
    [ValidateNotNullOrEmpty()]
    [Parameter(Mandatory=$true, ParameterSetName="ById", Position=0)]
    ${Identity},

    [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.ConferencingServiceNumber]
    [ValidateNotNull()]
    [Parameter(Mandatory=$true, ValueFromPipeline=$true, ParameterSetName="ByInstance")]
    ${Instance},

    [string]
    [ValidateNotNull()]
    ${BridgeId},

    [string]
    [ValidateNotNullOrEmpty()]
    ${BridgeName},

    [Alias('DC')]
    ${DomainController},

    [switch]
    ${Force},

    [switch]
    ${RemoveDefaultServiceNumber},
    
    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
    ${HttpPipelinePrepend})

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            if ($Identity -ne "") 
            {
                $output = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Unregister-CsOdcServiceNumber @PSBoundParameters @httpPipelineArgs
            }
            elseif ($Instance -ne $null)
            {
                $Body = [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.ConferencingServiceNumber]::new()
                $Body.Number = $Instance.Number
                $Body.PrimaryLanguage = $Instance.PrimaryLanguage
                $Body.SecondaryLanguages = $Instance.SecondaryLanguages

                if($PSBoundParameters.ContainsKey('RemoveDefaultServiceNumber') -eq $false)
                {
                    $output = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Unregister-CsOdcServiceNumber -Body $Body -BridgeId $BridgeId -BridgeName $BridgeName @httpPipelineArgs
                }
                else
                {
                    $output = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Unregister-CsOdcServiceNumber -Body $Body -BridgeId $BridgeId -BridgeName $BridgeName -RemoveDefaultServiceNumber @httpPipelineArgs
                }
            }

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: cmdlet for Orchestration- This cmdlets compress csv files.

function New-CsBatchTeamsDeployment 
{
    [OutputType([System.String])]
    [CmdletBinding( PositionalBinding=$false)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        $TeamsFilePath,

        [Parameter(Mandatory=$true, position=1)]
        [System.String]
        $UsersFilePath,

        [Parameter(Mandatory=$true, position=2)]
        [System.String]
        $UsersToNotify,

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try 
        {
            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

           $TeamsFile =  "$env:TEMP\Teams.csv"
           $UsersFile =  "$env:TEMP\Users.csv"
           Copy-Item $TeamsFilePath -Destination $TeamsFile -Force
           Copy-Item $UsersFilePath -Destination $UsersFile -Force
           $zipFile = "$env:TEMP\TeamsDeployment.Zip"

           $compress = @{
           LiteralPath= $TeamsFile , $UsersFile
           CompressionLevel = "Fastest"
           DestinationPath = $zipFile
           }

           Compress-Archive @compress -Update

           $FileStream = [System.IO.File]::ReadAllBytes($zipFile)
           $B64String = [System.Convert]::ToBase64String($FileStream, [System.Base64FormattingOptions]::None)

           $null = $PSBoundParameters.Remove("TeamsFilePath")
           $null = $PSBoundParameters.Remove("UsersFilePath")
           $null = $PSBoundParameters.Add("DeploymentCsv", $B64String) 

           $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsBatchTeamsDeployment @PSBoundParameters @httpPipelineArgs

           Write-Output $internalOutput 
                                            
        }
        catch
        {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: To support enums for DeploymentName and ObjectClass and support Boolean

function Invoke-CsDirectObjectSync {
    [CmdletBinding(PositionalBinding=$false)]
    param(
        [Parameter(ParameterSetName='Post', Mandatory, ValueFromPipeline)]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.IDsRequestBody]
        # Request body for DsSync cmdlet
        # To construct, see NOTES section for BODY properties and create a hash table.
        ${Body},

        [Parameter(ParameterSetName='PostExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Models.DirectoryDeploymentName]
        # Deployment Name.
        ${DeploymentName},

        [Parameter(ParameterSetName='PostExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [System.Boolean]
        ${IsValidationRequest},

        [Parameter(ParameterSetName='PostExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Models.DirectoryObjectClass]
        # Object Class enum.
        ${ObjectClass},

        [Parameter(ParameterSetName='PostExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [System.String]
        # GUID of the user.
        ${ObjectId},

        [Parameter(ParameterSetName='PostExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [System.String[]]
        # List of ObjectId.
        ${ObjectIds},

        [Parameter(ParameterSetName='PostExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [System.String]
        # Scenarios to Suppress.
        ${ScenariosToSuppress},

        [Parameter(ParameterSetName='PostExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [System.String]
        # Service Instance of the tenant.
        ${ServiceInstance},

        [Parameter(ParameterSetName='PostExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [System.Boolean]
        # Sync all the users of the tenant.
        ${SynchronizeTenantWithAllObject},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}

    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $obj = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Invoke-CsDirectObjectSync @PSBoundParameters         

            Write-Output $obj

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

function Get-CsTeamsSettingsCustomApp {
    [CmdletBinding(PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {
            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $settings = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsTeamsSettingsCustomApp @PSBoundParameters @httpPipelineArgs
            $targetProperties = $settings | Select-Object -Property isSideloadedAppsInteractionEnabled
            if ($targetProperties.isSideloadedAppsInteractionEnabled -eq $null) {
                $targetProperties.isSideloadedAppsInteractionEnabled = $false
            }
            Write-Output $targetProperties
        }
        catch
        {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

function Set-CsTeamsSettingsCustomApp {
    [CmdletBinding(PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [System.Boolean]
        ${isSideloadedAppsInteractionEnabled},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {
            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $getResult = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsTeamsSettingsCustomApp
            # Stop execution if internal cmdlet is failing
            if ($getResult -eq $null) {
                throw 'Internal Error. Please try again.'
            }

            $appSettingsListValue = @()
            $null = $PSBoundParameters.Add("isAppsEnabled", $getResult.isAppsEnabled)
            $null = $PSBoundParameters.Add("isAppsPurchaseEnabled", $getResult.isAppsPurchaseEnabled)
            $null = $PSBoundParameters.Add("isExternalAppsEnabledByDefault", $getResult.isExternalAppsEnabledByDefault)
            $null = $PSBoundParameters.Add("isLicenseBasedPinnedAppsEnabled", $getResult.isLicenseBasedPinnedAppsEnabled)
            $null = $PSBoundParameters.Add("isTenantWideAutoInstallEnabled", $getResult.isTenantWideAutoInstallEnabled)
            $null = $PSBoundParameters.Add("LobTextColor", $getResult.LobTextColor)
            $null = $PSBoundParameters.Add("LobBackground", $getResult.LobBackground)
            $null = $PSBoundParameters.Add("LobLogo", $getResult.LobLogo)
            $null = $PSBoundParameters.Add("LobLogomark", $getResult.LobLogomark)
            $null = $PSBoundParameters.Add("appSettingsList", $appSettingsListValue)
            $null = $PSBoundParameters.Add("appAccessRequestConfig", $getResult.appAccessRequestConfig)
            Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsTeamsSettingsCustomApp @PSBoundParameters @httpPipelineArgs
        }
        catch
        {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Get meeting migration transaction history for a user
.Description
Get meeting migration transaction history for a user
#>
function Get-CsMeetingMigrationTransactionHistory {
    param(
        [Parameter(Mandatory=$true)]
        [System.String]
        # Identity.
        # Supports UPN and SIP
        ${Identity},

        [Parameter()]
        [System.String]
        # CorrelationId
        ${CorrelationId},

        [Parameter()]
        [System.DateTime]
        # start time filter - to get meeting migration transaction history after starttime
        ${StartTime},

        [Parameter()]
        [System.DateTime]
        # end time filter - to get meeting migration transaction history before endtime
        ${EndTime},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {
            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Fetching only Meeting Migration transaction history
            # need to pipe to convert-ToJson | Convert-FromJson to support output in list format and sending down to further pipeline commands.
            Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsMeetingMigrationTransactionHistoryModern -userIdentity $Identity -StartTime $StartTime -EndTime $EndTime -CorrelationId $CorrelationId @httpPipelineArgs | Foreach-Object  { ( ConvertTo-Json $_) } | Foreach-Object {ConvertFrom-Json $_} 
        } 
        catch 
        {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Get meeting migration status for a user or at tenant level
.Description
Get meeting migration status for a user or tenant level
#>
function Get-CsMmsStatus {
    param(
        [Parameter()]
        [System.String]
        # end time filter - to get meeting migration status before endtime
        ${EndTime},

        [Parameter()]
        [System.String]
        # Identity.
        # Supports UPN and SIP, domainName LogonName
        ${Identity},

        [Parameter()]
        [System.String]
        # Meeting migration type - SfbToSfb, SfbToTeams, TeamsToTeams, AllToTeams, ToSameType, Unknown
        ${MigrationType},

        [Parameter()]
        [System.String]
        # start time filter - to get meeting migration status after starttime
        ${StartTime},

        [Parameter()]
        [switch]
        # SummaryOnly - to get only meting migration status summary.
        ${SummaryOnly},

        [Parameter()]
        [System.String]
        # state of meeting Migration status - Pending, InProgress, Failed, Succeeded
        ${State},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {
            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            if($PSBoundParameters.ContainsKey('SummaryOnly')) 
            {
                # Fetching only Meeting Migration status summary
                Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsMeetingMigrationStatusSummaryModern -Identity $Identity -StartTime $StartTime -EndTime $EndTime -State $state -MigrationType $MigrationType @httpPipelineArgs | ConvertTo-Json
            }
            else 
            {
                # Need to display output in a list format and should be able to pipe output to other cmdlets for filtering.
                # with Format-List, not able to send the output for piping. So did this Convert-ToJson and Converting object from Json which displays output in list format and also able to refer with index value.
                Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsMeetingMigrationStatusModern -Identity $Identity -StartTime $StartTime -EndTime $EndTime -State $state -MigrationType $MigrationType @httpPipelineArgs |  Foreach-Object  { ( ConvertTo-Json $_) } | Foreach-Object {ConvertFrom-Json $_}
            }
        } 
        catch 
        {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: cmdlet for signin batch of user- This cmdlets converts the input from the csv file to required type to call the internal cmdlet

function New-CsSdgBulkSignInRequest
{
    [CmdletBinding(PositionalBinding=$false)]
    param(
        [Parameter(Mandatory=$true)]
        [System.String]
        $DeviceDetailsFilePath,
        [Parameter(Mandatory=$true)]
        [System.String]
        $Region
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try 
        {
           $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

           $deviceDetails = Import-Csv -Path $DeviceDetailsFilePath
           $deviceDetailsInput = @();
           $deviceDetails | ForEach-Object { $deviceDetailsInput += [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.SdgBulkSignInRequestItem]@{ Username=$_.Username;HardwareId=$_.HardwareId }}
           Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsSdgBulkSignInRequest -Body $deviceDetailsInput -TargetRegion $Region
                                    
        }
        catch
        {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Transfer $PolisyList from user's input from string[] to object[], enable inline input

function Get-CsTeamTemplateList {
    [OutputType([Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.ITeamTemplateSummary], [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.IErrorObject])]
    [CmdletBinding(DefaultParameterSetName='DefaultLocaleOverride', PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$false)]
        [System.String]
        # The language and country code of templates localization.
        ${PublicTemplateLocale},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            if ([string]::IsNullOrWhiteSpace($PublicTemplateLocale)) {
                $null = $PSBoundParameters.Add("PublicTemplateLocale", "en-US")
            }

            Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsTeamTemplateList @PSBoundParameters @httpPipelineArgs

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Validate team template payload contains General channel on create, add if not

function New-CsTeamTemplate {
    [OutputType([Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.ICreateTemplateResponse], [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.ITeamTemplateErrorResponse])]
    [CmdletBinding(DefaultParameterSetName='NewExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(ParameterSetName='New', Mandatory)]
        [Parameter(ParameterSetName='NewExpanded', Mandatory)]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Path')]
        [System.String]
        # Locale of template.
        ${Locale},

        [Parameter(ParameterSetName='NewViaIdentity', Mandatory, ValueFromPipeline)]
        [Parameter(ParameterSetName='NewViaIdentityExpanded', Mandatory, ValueFromPipeline)]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Path')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.IConfigApiBasedCmdletsIdentity]
        # Identity Parameter
        # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
        ${InputObject},

        [Parameter(ParameterSetName='New', Mandatory, ValueFromPipeline)]
        [Parameter(ParameterSetName='NewViaIdentity', Mandatory, ValueFromPipeline)]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.ITeamTemplate]
        # The client input for a request to create a template.
        # Only admins from Config Api can perform this request.
        # To construct, see NOTES section for BODY properties and create a hash table.
        ${Body},

        [Parameter(ParameterSetName='NewExpanded', Mandatory)]
        [Parameter(ParameterSetName='NewViaIdentityExpanded', Mandatory)]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [System.String]
        # Gets or sets the team's DisplayName.
        ${DisplayName},

        [Parameter(ParameterSetName='NewExpanded', Mandatory)]
        [Parameter(ParameterSetName='NewViaIdentityExpanded', Mandatory)]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [System.String]
        # Gets or sets template short description.
        ${ShortDescription},

        [Parameter(ParameterSetName='NewExpanded')]
        [Parameter(ParameterSetName='NewViaIdentityExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.ITeamsAppTemplate[]]
        # Gets or sets the set of applications that should be installed in teams created based on the template.The app catalog is the main directory for information about each app; this set is intended only as a reference.
        # To construct, see NOTES section for APP properties and create a hash table.
        ${App},

        [Parameter(ParameterSetName='NewExpanded')]
        [Parameter(ParameterSetName='NewViaIdentityExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [System.String[]]
        # Gets or sets list of categories.
        ${Category},

        [Parameter(ParameterSetName='NewExpanded')]
        [Parameter(ParameterSetName='NewViaIdentityExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.IChannelTemplate[]]
        # Gets or sets the set of channel templates included in the team template.
        # To construct, see NOTES section for CHANNEL properties and create a hash table.
        ${Channel},

        [Parameter(ParameterSetName='NewExpanded')]
        [Parameter(ParameterSetName='NewViaIdentityExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [System.String]
        # Gets or sets the team's classification.Tenant admins configure AAD with the set of possible values.
        ${Classification},

        [Parameter(ParameterSetName='NewExpanded')]
        [Parameter(ParameterSetName='NewViaIdentityExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [System.String]
        # Gets or sets the team's Description.
        ${Description},

        [Parameter(ParameterSetName='NewExpanded')]
        [Parameter(ParameterSetName='NewViaIdentityExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.ITeamDiscoverySettings]
        # Governs discoverability of a team.
        # To construct, see NOTES section for DISCOVERYSETTING properties and create a hash table.
        ${DiscoverySetting},

        [Parameter(ParameterSetName='NewExpanded')]
        [Parameter(ParameterSetName='NewViaIdentityExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.ITeamFunSettings]
        # Governs use of fun media like giphy and stickers in the team.
        # To construct, see NOTES section for FUNSETTING properties and create a hash table.
        ${FunSetting},

        [Parameter(ParameterSetName='NewExpanded')]
        [Parameter(ParameterSetName='NewViaIdentityExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.ITeamGuestSettings]
        # Guest role settings for the team.
        # To construct, see NOTES section for GUESTSETTING properties and create a hash table.
        ${GuestSetting},

        [Parameter(ParameterSetName='NewExpanded')]
        [Parameter(ParameterSetName='NewViaIdentityExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [System.String]
        # Gets or sets template icon.
        ${Icon},

        [Parameter(ParameterSetName='NewExpanded')]
        [Parameter(ParameterSetName='NewViaIdentityExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [System.Management.Automation.SwitchParameter]
        # Gets or sets whether to limit the membership of the team to owners in the AAD group until an owner "activates" the team.
        ${IsMembershipLimitedToOwner},

        [Parameter(ParameterSetName='NewExpanded')]
        [Parameter(ParameterSetName='NewViaIdentityExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.ITeamMemberSettings]
        # Member role settings for the team.
        # To construct, see NOTES section for MEMBERSETTING properties and create a hash table.
        ${MemberSetting},

        [Parameter(ParameterSetName='NewExpanded')]
        [Parameter(ParameterSetName='NewViaIdentityExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.ITeamMessagingSettings]
        # Governs use of messaging features within the teamThese are settings the team owner should be able to modify from UI after team creation.
        # To construct, see NOTES section for MESSAGINGSETTING properties and create a hash table.
        ${MessagingSetting},

        [Parameter(ParameterSetName='NewExpanded')]
        [Parameter(ParameterSetName='NewViaIdentityExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [System.String]
        # Gets or sets the AAD user object id of the user who should be set as the owner of the new team.Only to be used when an application or administrative user is making the request on behalf of the specified user.
        ${OwnerUserObjectId},

        [Parameter(ParameterSetName='NewExpanded')]
        [Parameter(ParameterSetName='NewViaIdentityExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [System.String]
        # Gets or sets published name.
        ${PublishedBy},

        [Parameter(ParameterSetName='NewExpanded')]
        [Parameter(ParameterSetName='NewViaIdentityExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [System.String]
        # The specialization or use case describing the team.Used for telemetry/BI, part of the team context exposed to app developers, and for legacy implementations of differentiated features for education.
        ${Specialization},

        [Parameter(ParameterSetName='NewExpanded')]
        [Parameter(ParameterSetName='NewViaIdentityExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [System.String]
        # Gets or sets the id of the base template for the team.Either a Microsoft base template or a custom template.
        ${TemplateId},

        [Parameter(ParameterSetName='NewExpanded')]
        [Parameter(ParameterSetName='NewViaIdentityExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [System.String]
        # Gets or sets uri to be used for GetTemplate api call.
        ${Uri},

        [Parameter(ParameterSetName='NewExpanded')]
        [Parameter(ParameterSetName='NewViaIdentityExpanded')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Body')]
        [System.String]
        # Used to control the scope of users who can view a group/team and its members, and ability to join.
        ${Visibility},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend},

        [Parameter(DontShow)]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Wait for .NET debugger to attach
        ${Break},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Runtime')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be appended to the front of the pipeline
        ${HttpPipelineAppend},

        [Parameter(DontShow)]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Runtime')]
        [System.Uri]
        # The URI for the proxy server to use
        ${Proxy},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Runtime')]
        [System.Management.Automation.PSCredential]
        # Credentials for a proxy server to use for the remote call
        ${ProxyCredential},

        [Parameter(DontShow)]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Use the default credentials for the proxy
        ${ProxyUseDefaultCredentials}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {
            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $generalChannel = @{
                DisplayName = "General";
                id= "General";
                isFavoriteByDefault= $true
            }

            if ($null -ne $Body) {
                $Channel = $Body.Channel
            }

            if ($null -eq $Channel) {
                if ($null -ne $Body) {
                    $Body.Channel = $generalChannel
                    $PSBoundParameters['Body'] = $Body
                } else {
                    $null = $PSBoundParameters.Add("Channel", $generalChannel)
                }
            } else {
                $hasGeneralChannel = $false
                foreach ($channel in $Channel){
                    if ($channel.displayName -eq "General") {
                        $hasGeneralChannel = $true
                    }
                }
                if ($hasGeneralChannel -eq $false) {
                    if ($null -ne $Body) {
                        $Body.Channel += $generalChannel
                        $PSBoundParameters['Body'] = $Body
                    } else {
                        $Channel += $generalChannel
                        $PSBoundParameters['Channel'] = $Channel
                    }
                }
            }
            
            Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsTeamTemplate @PSBoundParameters @httpPipelineArgs

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Integrate Get-CsMasVersionedSchemaData with Get-CsMasVersionedData

function Get-CsMasVersionedSchemaData {
    [CmdletBinding(PositionalBinding=$false)]
    param(
        [Parameter(Mandatory)]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Query')]
        [System.String]
        # Schema to get from MAS DB.
        ${SchemaName},

        [Parameter()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Query')]
        [System.String]
        # Identity.
        ${Identity},

        [Parameter()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Category('Query')]
        [System.String]
        # Last X versions to fetch from MAS DB.
        ${Version},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}

    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $obj = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsMasVersionedSchemaData @PSBoundParameters
            $allProperties = $obj | Select-Object -ExpandProperty AdditionalProperties                

            Write-Output $allProperties

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Integrate Get-CsTenant with Get-CsTenantObou

function Get-CsTenantPoint {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $defaultPropertySet = "Extended"
            $tenant = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsTenantObou -DefaultPropertySet $defaultPropertySet @httpPipelineArgs
            $allProperties = $tenant | Select-Object -Property * -ExcludeProperty LastProvisionTimeStamps, LastPublishTimeStamps 
            $allProperties | Add-Member -NotePropertyName LastProvisionTimeStamps -NotePropertyValue $tenant.LastProvisionTimeStamps.AdditionalProperties -passThru | Add-Member -NotePropertyName LastPublishTimeStamps -NotePropertyValue $tenant.LastPublishTimeStamps.AdditionalProperties 

            Write-Output $allProperties

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Integrate Move-CsTenantCrossRegion with New-CsTenantCrossMigration

function Move-CsTenantCrossRegion {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $output = Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsTenantCrossMigration @httpPipelineArgs

            Write-Output $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Integrate Move-CsTenantServiceInstance with New-CsTenantCrossMigration

function Move-CsTenantServiceInstance {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # Can take following values (PrepForMove, StartDualSync, Finalize)
        ${MoveOption},

        [Parameter(Mandatory=$false)]
        [System.String]
        # Service Instance where tenant is to be migrated
        ${TargetServiceInstance},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $output = Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsTenantCrossMigration -MoveOption $MoveOption -TargetServiceInstance $TargetServiceInstance @httpPipelineArgs

            Write-Output $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: map parameters to request body

function Set-CsOnlineSipDomainModern {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # Domain Name parameter.
        ${Domain},

        [Parameter(Mandatory=$true, Position=1)]
        [System.String]
        # Action decides enable or disable sip domain
        ${Action},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $Body = [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.TenantSipDomainRequest]::new()

            $Body.DomainName = $Domain
            $Body.Action = $Action

            $result = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsOnlineSipDomain -Body $Body @httpPipelineArgs
            Write-AdminServiceDiagnostic($result.Diagnostic)

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Integrate Get-CsOnlineUser with Get-CsUser and Search-CsUser

function Get-CsUserList {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$false, position=0)]
        [System.String]
        # Unique identifier for the user
        ${Identity},

        [Parameter(Mandatory=$false)]
        [System.Nullable[System.Int32]]
        # Number of users to be returned
        ${ResultSize},

        [Parameter(Mandatory=$false)]
        [System.Management.Automation.SwitchParameter]
        #To not display user policies in output
        ${SkipUserPolicies},

        [Parameter(Mandatory=$false)]
        [System.Management.Automation.SwitchParameter]
        # To only fetch soft-deleted users
        ${SoftDeletedUsers},

        [Parameter(Mandatory=$false)]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Models.AccountType]
        # To only fetch users with specified account type
        ${AccountType},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $defaultPropertySet = "Extended"
            $internalfilter = ""
            if ($AccountType)
            {
                if (![string]::IsNullOrWhiteSpace($Identity))
                {
                    Write-Error "AccountType parameter cannot be used with Identity parameter."
                    return
                }
                else
                {
                    $internalfilter = "AccountType -eq '$AccountType'"
                }
            }
            if (![string]::IsNullOrWhiteSpace($Identity))
            {
                $user = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsUser -Identity $Identity -SkipUserPolicy:$SkipUserPolicies -DefaultPropertySet $defaultPropertySet @httpPipelineArgs
                $allProperties = $user | Select-Object -Property * -ExcludeProperty Location, Number, DataCenter, PSTNconnectivity, SipDomain, LastProvisionTimeStamps, LastPublishTimeStamps 
                $allProperties | Add-Member -NotePropertyName LastProvisionTimeStamps -NotePropertyValue $user.LastProvisionTimeStamps.AdditionalProperties -passThru | Add-Member -NotePropertyName LastPublishTimeStamps -NotePropertyValue $user.LastPublishTimeStamps.AdditionalProperties 

                Write-Output $allProperties
            }
            else
            {
                if ($SoftDeletedUsers)
                {
                    if (![string]::IsNullOrWhiteSpace($internalfilter))
                    {
                        Microsoft.Teams.ConfigAPI.Cmdlets.internal\Search-CsUser -PSFilter $internalfilter -Top $ResultSize -SkipUserPolicy:$SkipUserPolicies -DefaultPropertySet $defaultPropertySet -Softdeleteduser:$true @httpPipelineArgs | Select-Object -Property * -ExcludeProperty Location, Number, DataCenter, PSTNconnectivity, SipDomain
                    }
                    else
                    {
                        Microsoft.Teams.ConfigAPI.Cmdlets.internal\Search-CsUser -Top $ResultSize -SkipUserPolicy:$SkipUserPolicies -DefaultPropertySet $defaultPropertySet -Softdeleteduser:$true @httpPipelineArgs | Select-Object -Property * -ExcludeProperty Location, Number, DataCenter, PSTNconnectivity, SipDomain
                    }
                }
                else
                {
                    if (![string]::IsNullOrWhiteSpace($internalfilter))
                    {
                        Microsoft.Teams.ConfigAPI.Cmdlets.internal\Search-CsUser -PSFilter $internalfilter -Top $ResultSize -SkipUserPolicy:$SkipUserPolicies -DefaultPropertySet $defaultPropertySet @httpPipelineArgs | Select-Object -Property * -ExcludeProperty Location, Number, DataCenter, PSTNconnectivity, SipDomain
                    }
                    else
                    {
                        Microsoft.Teams.ConfigAPI.Cmdlets.internal\Search-CsUser -Top $ResultSize -SkipUserPolicy:$SkipUserPolicies -DefaultPropertySet $defaultPropertySet @httpPipelineArgs | Select-Object -Property * -ExcludeProperty Location, Number, DataCenter, PSTNconnectivity, SipDomain
                    }            
                }
            }

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Integrate Get-CsOnlineUser with Get-CsUser

function Get-CsUserPoint {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # Unique identifier for the user
        ${Identity},

        [Parameter(Mandatory=$false)]
        [System.Management.Automation.SwitchParameter]
        #To not display user policies in output
        ${SkipUserPolicies},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            if (![string]::IsNullOrWhiteSpace($Identity))
            {
                $user = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsUser -Identity $Identity -SkipUserPolicy:$SkipUserPolicies -DefaultPropertySet "Extended" @httpPipelineArgs

                $allProperties = $user | Select-Object -Property * -ExcludeProperty Location, Number, DataCenter, PSTNconnectivity, SipDomain, LastProvisionTimeStamps, LastPublishTimeStamps 
                $allProperties | Add-Member -NotePropertyName LastProvisionTimeStamps -NotePropertyValue $user.LastProvisionTimeStamps.AdditionalProperties -passThru | Add-Member -NotePropertyName LastPublishTimeStamps -NotePropertyValue $user.LastPublishTimeStamps.AdditionalProperties 

                Write-Output $allProperties
            }

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Integrate Get-CsOnlineUser with Get-CsUser and Search-CsUser

function Get-CsUserSearch {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$false, position=0)]
        [System.String]
        # Unique identifier for the user
        ${Identity},

        [Parameter(Mandatory=$false, DontShow = $true)]
        [System.String[]]
        # List of user identifiers
        ${Identities},

        [Parameter(Mandatory=$false)]
        [System.String]
        # Filter to be applied to the list of users
        ${Filter},

        [Alias('Sort')]
        [Parameter(Mandatory=$false)]
        [System.String]
        # OrderBy to be applied to the list of users
        ${OrderBy},

        [Parameter(Mandatory=$false)]
        [System.Nullable[System.Int32]]
        # Number of users to be returned
        ${ResultSize},

        [Parameter(Mandatory=$false)]
        [System.Management.Automation.SwitchParameter]
        #To skip user policies in output
        ${SkipUserPolicies},

        [Parameter(Mandatory=$false)]
        [System.Management.Automation.SwitchParameter]
        # To only fetch soft-deleted users
        ${SoftDeletedUsers},

        [Parameter(Mandatory=$false)]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Models.AccountType]
        # To only fetch users with specified account type
        ${AccountType},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try 
        {
            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $defaultPropertySet = "Extended"
            if ($AccountType)
            {
                if (![string]::IsNullOrWhiteSpace($Identity))
                {
                    Write-Error "AccountType parameter cannot be used with Identity parameter."
                    return
                }
                if (![string]::IsNullOrWhiteSpace($Filter))
                {
                    $Filter += " -and AccountType -eq '$AccountType'"
                }
                else
                {
                    $Filter = "AccountType -eq '$AccountType'"
                }
            }
            if ($Identities -ne $null)
            {
                if (![string]::IsNullOrWhiteSpace($Filter))
                {
                    Write-Error "Filter parameter cannot be used along with Identity input."
                    return
                }
                $i = 0
                $count = $Identities.Count
                $filterstring = ""
                while ($i -lt $count)
                {
                    $id = $Identities[$i]
                    if (![string]::IsNullOrWhiteSpace($filterstring))
                    {
                        $filterstring += " or userprincipalname eq '$id'"
                    }
                    else
                    {
                        $filterstring = "userprincipalname eq '$id'"
                    }
                    $i = $i + 1
                }
            
                if (![string]::IsNullOrEmpty($filterstring))
                {
                    $users = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Search-CsUser -PSFilter $filterstring @httpPipelineArgs -OrderBy $OrderBy | Select-Object -Property * -ExcludeProperty Location, Number, DataCenter, PSTNconnectivity, SipDomain
                }    
                Write-Output $users
            }
        
            elseif (![string]::IsNullOrWhiteSpace($Identity))
            {
                $user = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsUser -Identity $Identity -SkipUserPolicy:$SkipUserPolicies -DefaultPropertySet $defaultPropertySet @httpPipelineArgs
                $allProperties = $user | Select-Object -Property * -ExcludeProperty Location, Number, DataCenter, PSTNconnectivity, SipDomain, LastProvisionTimeStamps, LastPublishTimeStamps 
                $allProperties | Add-Member -NotePropertyName LastProvisionTimeStamps -NotePropertyValue $user.LastProvisionTimeStamps.AdditionalProperties -passThru | Add-Member -NotePropertyName LastPublishTimeStamps -NotePropertyValue $user.LastPublishTimeStamps.AdditionalProperties 

                    Write-Output $allProperties
            }
            elseif (![string]::IsNullOrWhiteSpace($Filter))
            {
                if ($SoftDeletedUsers)
                {
                    Microsoft.Teams.ConfigAPI.Cmdlets.internal\Search-CsUser -PSFilter $Filter -Top $ResultSize -OrderBy $OrderBy -SkipUserPolicy:$SkipUserPolicies -DefaultPropertySet $defaultPropertySet -Softdeleteduser:$true @httpPipelineArgs| Select-Object -Property * -ExcludeProperty Location, Number, DataCenter, PSTNconnectivity, SipDomain
                }
                else
                {
                    Microsoft.Teams.ConfigAPI.Cmdlets.internal\Search-CsUser -PSFilter $Filter -Top $ResultSize -OrderBy $OrderBy -SkipUserPolicy:$SkipUserPolicies -DefaultPropertySet $defaultPropertySet @httpPipelineArgs | Select-Object -Property * -ExcludeProperty Location, Number, DataCenter, PSTNconnectivity, SipDomain
                }
            }
            else 
            {
                if ($SoftDeletedUsers)
                {
                    Microsoft.Teams.ConfigAPI.Cmdlets.internal\Search-CsUser -Top $ResultSize -OrderBy $OrderBy -SkipUserPolicy:$SkipUserPolicies -DefaultPropertySet $defaultPropertySet -Softdeleteduser:$true @httpPipelineArgs | Select-Object -Property * -ExcludeProperty Location, Number, DataCenter, PSTNconnectivity, SipDomain
                }
                else
                {
                    Microsoft.Teams.ConfigAPI.Cmdlets.internal\Search-CsUser  -Top $ResultSize -OrderBy $OrderBy -SkipUserPolicy:$SkipUserPolicies -DefaultPropertySet $defaultPropertySet @httpPipelineArgs | Select-Object -Property * -ExcludeProperty Location, Number, DataCenter, PSTNconnectivity, SipDomain
                }
            }
        }
        catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Integrate Get-CsOnlineVoiceUser with Get-CsUser 

function Get-CsVoiceUserList {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$false, position=0)]
        [System.String]
        # Unique identifier for the user
        ${Identity},

        [Parameter(Mandatory=$false, position=1)]
        [System.Management.Automation.SwitchParameter]
        #To fetch location field
        ${ExpandLocation},

        [Parameter(Mandatory=$false)]
        [System.Nullable[System.Int32]]
        # Number of users to be returned
        ${First},

        [Parameter(Mandatory=$false)]
        [System.Management.Automation.SwitchParameter]
        # To only fetch users which have a number assigned to them
        ${NumberAssigned},

        [Parameter(Mandatory=$false)]
        [System.Management.Automation.SwitchParameter]
        # To only fetch users which don't have a number assigned to them
        ${NumberNotAssigned},

        [Parameter(Mandatory=$false)]
        [System.Nullable[System.Guid]]
        # LocationId of users to be returned
        ${LocationId},

        [Parameter(Mandatory=$false)]
        [System.Nullable[System.Guid]]
        # CivicAddressId of users to be returned
        ${CivicAddressId},

        [Parameter(Mandatory=$false)]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Models.PSTNConnectivity]
        # PSTNConnectivity of the users to be returned
        ${PSTNConnectivity},

        [Parameter(Mandatory=$false)]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Models.EnterpriseVoiceStatus]
        # EnterpriseVoiceStatus of the users to be returned
        ${EnterpriseVoiceStatus},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process 
    {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            if (![string]::IsNullOrWhiteSpace($Identity))
            {
                if($ExpandLocation)
                {
                    Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsUser -Identity $Identity -Includedefaultproperty:$false -VoiceUserQuery:$true -Select "Objectid,EnterpriseVoiceEnabled,
                    DisplayName,Location,LineUri,TenantID,UsageLocation,DataCenter,PSTNconnectivity,SipDomain" @httpPipelineArgs | 
                    Select-Object -Property @{Name = 'Name' ; Expression = {$_.DisplayName}},
                    @{Name = 'Id' ; Expression = {$_.Identity}},
                    SipDomain,
                    DataCenter,
                    TenantID,
                    @{Name = 'Number' ; Expression = {$_.LineUri}},
                    Location,
                    PSTNconnectivity,
                    UsageLocation,
                    EnterpriseVoiceEnabled
                }
                else
                {
                    Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsUser -Identity $Identity -Includedefaultproperty:$false -VoiceUserQuery:$true -Select "Objectid,EnterpriseVoiceEnabled,
                    DisplayName,LineUri,TenantID,UsageLocation,DataCenter,PSTNconnectivity,SipDomain" @httpPipelineArgs | 
                    Select-Object -Property @{Name = 'Name' ; Expression = {$_.DisplayName}},
                    @{Name = 'Id' ; Expression = {$_.Identity}},
                    SipDomain,
                    DataCenter,
                    TenantID,
                    @{Name = 'Number' ; Expression = {$_.LineUri}},
                    @{Name = 'Location' ; Expression = {""}},
                    PSTNconnectivity,
                    UsageLocation,
                    EnterpriseVoiceEnabled
                }
            }
            else
            {
                if($NumberAssigned -and $NumberNotAssigned)
                {
                    Write-Error "You can only pass either NumberAssigned or NumberNotAssigned at a time."
                    return
                }

                if (($LocationId -and !$CivicAddressId) -or ($CivicAddressId -and !$LocationId))
                {
                    Write-Error "LocationId and CivicAddressId must be provided together."
                    return
                }    

                $filters = @()   #array of individual filters
                $addNumberInSelectProperties = $false
                if ($LocationId -and $CivicAddressId)
                {
                    $filters += "Number/LocationId eq '$LocationId' and Number/CivicAddressId eq '$CivicAddressId'"
                    $addNumberInSelectProperties = $true
                }
                
                if ($PSTNConnectivity)
                {
                    if ($PSTNConnectivity -eq 'OnPremises' -or $PSTNConnectivity -eq 'Online')
                    {
                        $filters += "PSTNConnectivity eq '$PSTNConnectivity'"
                    }
                }

                if ($EnterpriseVoiceStatus)
                {
                    if ($EnterpriseVoiceStatus -eq 'Enabled')
                    {
                        $filters += "EnterpriseVoiceEnabled eq true"
                    }
                    elseif ($EnterpriseVoiceStatus -eq 'Disabled')
                    {
                        $filters += "EnterpriseVoiceEnabled eq false"
                    }
                }

                if ($NumberAssigned)
                {
                    $filters += "LineUri ne '$null'"
                }
                elseif ($NumberNotAssigned)
                {
                    $filters += "LineUri eq '$null'"
                }

                $filterstring = $filters -join " and "
                $selectProperties = "Objectid,EnterpriseVoiceEnabled,DisplayName,LineUri,TenantID,UsageLocation,DataCenter,PSTNconnectivity,SipDomain"

                if ($addNumberInSelectProperties -eq $true)
                {
                    $selectProperties += ",Number"
                }
            
                if($ExpandLocation)
                {
                    $selectProperties += ",Location"
                    Microsoft.Teams.ConfigAPI.Cmdlets.internal\Search-CsUser  -Includedefaultproperty:$false -VoiceUserQuery:$true -Select $selectProperties -Filter $filterstring -Top $First @httpPipelineArgs | 
                    Select-Object -Property @{Name = 'Name' ; Expression = {$_.DisplayName}},
                    @{Name = 'Id' ; Expression = {$_.Identity}},
                    SipDomain,
                    DataCenter,
                    TenantID,
                    @{Name = 'Number' ; Expression = {$_.LineUri}},
                    Location,
                    PSTNconnectivity,
                    UsageLocation,
                    EnterpriseVoiceEnabled
                }
                else
                {
                    Microsoft.Teams.ConfigAPI.Cmdlets.internal\Search-CsUser  -Includedefaultproperty:$false -VoiceUserQuery:$true -Select $selectProperties -Filter $filterstring -Top $First @httpPipelineArgs | 
                    Select-Object -Property @{Name = 'Name' ; Expression = {$_.DisplayName}},
                    @{Name = 'Id' ; Expression = {$_.Identity}},
                    SipDomain,
                    DataCenter,
                    TenantID,
                    @{Name = 'Number' ; Expression = {$_.LineUri}},
                    @{Name = 'Location' ; Expression = {""}},
                    PSTNconnectivity,
                    UsageLocation,
                    EnterpriseVoiceEnabled
                }
            }

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Integrate Get-CsOnlineVoiceUser with Get-CsUser 

function Get-CsVoiceUserPoint {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # Unique identifier for the user
        ${Identity},

        [Parameter(Mandatory=$false, position=1)]
        [switch]
        #To fetch location field
        ${ExpandLocation},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            if (![string]::IsNullOrWhiteSpace($Identity))
            {
                if($ExpandLocation)
                {
                    Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsUser -Identity $Identity -Includedefaultproperty:$false -VoiceUserQuery:$true -Select "Objectid,EnterpriseVoiceEnabled,
                    DisplayName,Location,LineUri,TenantID,UsageLocation,DataCenter,PSTNconnectivity,SipDomain" @httpPipelineArgs | 
                    Select-Object -Property @{Name = 'Name' ; Expression = {$_.DisplayName}},
                    @{Name = 'Id' ; Expression = {$_.Identity}},
                    SipDomain,
                    DataCenter,
                    TenantID,
                    @{Name = 'Number' ; Expression = {$_.LineUri}},
                    Location,
                    PSTNconnectivity,
                    UsageLocation,
                    EnterpriseVoiceEnabled
                }
                else
                {
                    Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsUser -Identity $Identity -Includedefaultproperty:$false -VoiceUserQuery:$true -Select "Objectid,EnterpriseVoiceEnabled,
                    DisplayName,LineUri,TenantID,UsageLocation,DataCenter,PSTNconnectivity,SipDomain" @httpPipelineArgs | 
                    Select-Object -Property @{Name = 'Name' ; Expression = {$_.DisplayName}},
                    @{Name = 'Id' ; Expression = {$_.Identity}},
                    SipDomain,
                    DataCenter,
                    TenantID,
                    @{Name = 'Number' ; Expression = {$_.LineUri}},
                    @{Name = 'Location' ; Expression = {""}},
                    PSTNconnectivity,
                    UsageLocation,
                    EnterpriseVoiceEnabled
                }
            }

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
function Set-CsOnlineVoiceUserV2 {
[CmdletBinding(DefaultParameterSetName='Id', SupportsShouldProcess)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        ${Identity},

        [Parameter(Mandatory=$false)]
        [System.String][AllowNull()]
        ${TelephoneNumber},

        [Parameter(Mandatory=$false)]
        [System.String][AllowNull()]
        ${LocationId},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {
            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $Body = @{
                TelephoneNumber=$TelephoneNumber
                LocationId=$LocationId
            }
            $Payload = @{
                UserId = $Identity
                Body = $Body
            }
            Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsUserGenerated @Payload @httpPipelineArgs
        }
        catch
        {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
function Set-CsUserModern {
[CmdletBinding(DefaultParameterSetName='Id')]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        ${Identity},

        [Parameter(Mandatory=$false)]
        ${EnterpriseVoiceEnabled},
 
        [Parameter(Mandatory=$false)]
        ${HostedVoiceMail},

        [Parameter(Mandatory=$false)]
        [System.String][AllowNull()]
        ${LineURI},

        [Parameter(Mandatory=$false)]
        [System.String][AllowNull()]
        ${OnPremLineURI},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    ) 

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {
            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $PhoneNumber = $LineURI
            if ($PSBoundParameters.ContainsKey('OnPremLineURI')) {
                Write-Warning -Message "OnPremLineURI will be deprecated. Please use LineURI to update user's phone number."
                if (!$PSBoundParameters.ContainsKey('LineURI')){
                    $PhoneNumber = $OnPremLineURI
                }
                else{
                    Write-Error "Please specify either one parameter OnPremLineURI or LineURI to assign phone number."
                    return
                }
            }

            $Body = @{
                EnterpriseVoiceEnabled=$EnterpriseVoiceEnabled
                HostedVoiceMail=$HostedVoiceMail
            }

            if ($PSBoundParameters.ContainsKey('LineURI') -or $PSBoundParameters.ContainsKey('OnPremLineURI')) {
                $Body.LineUri = $PhoneNumber
            }

            $Payload = @{
                UserId = $Identity
                Body = $Body
            }
            Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsUserGenerated @Payload @httpPipelineArgs
        }
        catch
        {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

function New-CsUserCallingDelegate {
    [CmdletBinding(DefaultParameterSetName="Identity")]
    param(
        [Parameter(Mandatory=$true, ParameterSetName='Identity')]
        [System.String]
        ${Identity},
        
	    [Parameter(Mandatory=$true, ParameterSetName='Identity')]
        [System.String]
        ${Delegate},
        
        [Parameter(Mandatory=$true, ParameterSetName='Identity')]
        [System.Boolean]
        ${MakeCalls},
        
        [Parameter(Mandatory=$true, ParameterSetName='Identity')]
        [System.Boolean]     
        ${ManageSettings},
        
        [Parameter(Mandatory=$true, ParameterSetName='Identity')]
        [System.Boolean]
        ${ReceiveCalls},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

        $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

           Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsUserCallingDelegate @PSBoundParameters @httpPipelineArgs

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

function Remove-CsUserCallingDelegate {
    [CmdletBinding(DefaultParameterSetName="Identity")]
    param(
        [Parameter(Mandatory=$true, ParameterSetName='Identity')]
        [System.String]
        ${Identity},
        
	    [Parameter(Mandatory=$true, ParameterSetName='Identity')]
        [System.String]
        ${Delegate},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

               Microsoft.Teams.ConfigAPI.Cmdlets.internal\Remove-CsUserCallingDelegate @PSBoundParameters @httpPipelineArgs

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

function Set-CsUserCallingDelegate {
    [CmdletBinding(DefaultParameterSetName="Identity")]
    param(
        [Parameter(Mandatory=$true, ParameterSetName='Identity')]
        [System.String]
        ${Identity},
        
	    [Parameter(Mandatory=$true, ParameterSetName='Identity')]
        [System.String]
        ${Delegate},
        
        [Parameter(Mandatory=$false, ParameterSetName='Identity')]
        [System.Boolean]
        ${MakeCalls},
        
        [Parameter(Mandatory=$false, ParameterSetName='Identity')]
        [System.Boolean]     
        ${ManageSettings},
        
        [Parameter(Mandatory=$false, ParameterSetName='Identity')]
        [System.Boolean]
        ${ReceiveCalls},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

               Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsUserCallingDelegate @PSBoundParameters @httpPipelineArgs

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

function Set-CsUserCallingSettings {
    [CmdletBinding(DefaultParameterSetName="Identity")]
    param(
        [Parameter(Mandatory=$true, ParameterSetName='Forwarding')]
	    [Parameter(Mandatory=$true, ParameterSetName='ForwardingOnOff')]
        [Parameter(Mandatory=$true, ParameterSetName='Unanswered')]
	    [Parameter(Mandatory=$true, ParameterSetName='UnansweredOnOff')]
        [Parameter(Mandatory=$true, ParameterSetName='CallGroup')]
        [Parameter(Mandatory=$true, ParameterSetName='CallGroupMembership')]
	    [Parameter(Mandatory=$true, ParameterSetName='CallGroupNotification')]
        [Parameter(Mandatory=$true, ParameterSetName='Identity')]
        [System.String]
        ${Identity},
        
        [Parameter(Mandatory=$true, ParameterSetName='Forwarding')]
	    [Parameter(Mandatory=$true, ParameterSetName='ForwardingOnOff')]
        [System.Boolean]
        ${IsForwardingEnabled},
        
        [Parameter(Mandatory=$true, ParameterSetName='Forwarding')]
	    [ValidateSet('Immediate','Simultaneous')]
        [System.String]
        ${ForwardingType},
        
        [Parameter(Mandatory=$false, ParameterSetName='Forwarding')]
        [System.String]     
        [AllowNull()]
        ${ForwardingTarget},
        
        [Parameter(Mandatory=$true, ParameterSetName='Forwarding')]
	    [ValidateSet('SingleTarget','Voicemail','MyDelegates','Group')]
        [System.String]
        ${ForwardingTargetType},
		
        [Parameter(Mandatory=$true, ParameterSetName='Unanswered')]
	    [Parameter(Mandatory=$true, ParameterSetName='UnansweredOnOff')]
        [System.Boolean]
        ${IsUnansweredEnabled},
        
        [Parameter(Mandatory=$false, ParameterSetName='Unanswered')]
        [System.String]    
        [AllowNull()]
        ${UnansweredTarget},
        
        [Parameter(Mandatory=$false, ParameterSetName='Unanswered')]
	    [ValidateSet("", "SingleTarget","Voicemail","MyDelegates","Group")]
        [System.String]
        ${UnansweredTargetType},
		
        [Parameter(Mandatory=$true, ParameterSetName='Unanswered')]	    
        [System.String]    
        [AllowNull()]
        ${UnansweredDelay},
		
        [Parameter(Mandatory=$true, ParameterSetName='CallGroup')]
		[ValidateSet('Simultaneous','InOrder')]
        [System.String]
        ${CallGroupOrder},
        
        [Parameter(Mandatory=$true, ParameterSetName='CallGroup')]
        [System.Array]
        [AllowNull()]
        [AllowEmptyCollection()]
        ${CallGroupTargets},
        
        [Parameter(Mandatory=$true, ParameterSetName='CallGroupMembership')]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.ICallGroupMembershipDetails[]]
        [AllowEmptyCollection()]
        ${GroupMembershipDetails},
		
        [Parameter(Mandatory=$true, ParameterSetName='CallGroupNotification')]
	    [ValidateSet('Ring','Mute','Banner')]
        [System.String]
        ${GroupNotificationOverride},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

                if ($PSBoundParameters.ContainsKey('UnansweredDelay'))
                  {
                    if(($UnansweredDelay -as  [TimeSpan]) -and ($UnansweredDelay -le (New-TimeSpan -Hours 0 -Minutes 1 -Seconds 0)) -and ($UnansweredDelay -ge (New-TimeSpan -Hours 0 -Minutes 0 -Seconds 0)))            
                    {
                        $UnansweredDelay = $UnansweredDelay
                    }
                    else
                    {
                        write-warning "Unanswered delay is not in correct time range"
                        return
                    }
                }

               Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsUserCallingSettings @PSBoundParameters @httpPipelineArgs

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Transfer $PolisyList from user's input from string[] to object[], enable inline input

function New-CsCustomPolicyPackage {
    [OutputType([System.String])]
    [CmdletBinding(DefaultParameterSetName='RequiredPolicyList',
               PositionalBinding=$false,
               SupportsShouldProcess,
               ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true, position=0)]
        $Identity,

        [Parameter(Mandatory=$true, position=1)]
        [System.String[]]
        $PolicyList,

        [Parameter(position=2)]
        $Description,

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {
            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $Delimiters = ",", ".", ":", ";", " ", "`t"
            [psobject[]]$InternalPolicyList = @()
            foreach ($PolicyTypeAndName in $PolicyList)
            {
                $PolicyTypeAndNameArray = $PolicyTypeAndName -Split {$Delimiters -contains $_}, 2
                $PolicyTypeAndNameArray = $PolicyTypeAndNameArray.Trim()
                if ($PolicyTypeAndNameArray.Count -lt 2)
                {
                    throw "Invalid Policy Type and Name pair: $PolicyTypeAndName. Please use a proper delimeter"
                }
                $PolicyTypeAndNameObject = [psobject]@{
                    PolicyType = $PolicyTypeAndNameArray[0]
                    PolicyName = $PolicyTypeAndNameArray[1]
                }
                $InternalPolicyList += $PolicyTypeAndNameObject
            }
            $null = $PSBoundParameters.Remove("PolicyList")
            $null = $PSBoundParameters.Add("PolicyList", $InternalPolicyList)
            Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsCustomPolicyPackage @PSBoundParameters @httpPipelineArgs
        }
        catch
        {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Transfer $PolisyList from user's input from string[] to object[], enable inline input

function Update-CsCustomPolicyPackage {
    [OutputType([System.String])]
    [CmdletBinding(DefaultParameterSetName='RequiredPolicyList',
               PositionalBinding=$false,
               SupportsShouldProcess,
               ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true, position=0)]
        $Identity,

        [Parameter(Mandatory=$true, position=1)]
        [System.String[]]
        $PolicyList,

        [Parameter(position=2)]
        $Description,

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {
            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $Delimiters = ",", ".", ":", ";", " ", "`t"
            [psobject[]]$InternalPolicyList = @()
            foreach ($PolicyTypeAndName in $PolicyList)
            {
                $PolicyTypeAndNameArray = $PolicyTypeAndName -Split {$Delimiters -contains $_}, 2
                $PolicyTypeAndNameArray = $PolicyTypeAndNameArray.Trim()
                if ($PolicyTypeAndNameArray.Count -lt 2)
                {
                    throw "Invalid Policy Type and Name pair: $PolicyTypeAndName. Please use a proper delimeter"
                }
                $PolicyTypeAndNameObject = [psobject]@{
                    PolicyType = $PolicyTypeAndNameArray[0]
                    PolicyName = $PolicyTypeAndNameArray[1]
                }
                $InternalPolicyList += $PolicyTypeAndNameObject
            }
            $null = $PSBoundParameters.Remove("PolicyList")
            $null = $PSBoundParameters.Add("PolicyList", $InternalPolicyList)
            Microsoft.Teams.ConfigAPI.Cmdlets.internal\Update-CsCustomPolicyPackage @PSBoundParameters @httpPipelineArgs
        }
        catch
        {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Print error message in case of error

function Export-CsAutoAttendantHolidays {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The identity for the AA whose holiday schedules are to be exported..
        ${Identity},

        [Parameter(Mandatory=$false, position=1)]
        [Switch]
        # The Force parameter indicates if we force the action to be performed. (Deprecated)
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Remove("Force")

            # Use ResponseType 1 as binary output
            $PSBoundParameters.Add("ResponseType", 1)

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsAutoAttendantHolidays @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

            $internalOutput.ExportHolidayResultSerializedHolidayRecord

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Format output of Export-CsOnlineAudioFile

function Export-CsOnlineAudioFile {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The Identity parameter is the identifier for the audio file.
        ${Identity},

        [Parameter(Mandatory=$false, position=1)]
        [System.String]
        # The ApplicationId parameter is the identifier for the application which will use this audio file. 
        ${ApplicationId},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default Application ID to TenantGlobal and make it to the correct case
            if ($ApplicationId -eq "" -or $ApplicationId -like "TenantGlobal")
            {
                $ApplicationId = "TenantGlobal"
            }
            elseif ($ApplicationId -like "OrgAutoAttendant")
            {
                $ApplicationId = "OrgAutoAttendant"
            }
            elseif ($ApplicationId -like "HuntGroup")
            {
                $ApplicationId = "HuntGroup"
            }

            $null = $PSBoundParameters.Remove("ApplicationId")
            $PSBoundParameters.Add("ApplicationId", $ApplicationId)

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            $base64content = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Export-CsOnlineAudioFile @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($base64content -eq $null) {
                return $null
            }

            $output = [System.Convert]::FromBase64CharArray($base64content, 0, $base64content.Length)
            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Write diagnostic message back to console

function Find-CsGroup {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The SearchQuery parameter defines a search query to search the display name or the sip address or the GUID of groups.
        ${SearchQuery},

        [Parameter(Mandatory=$false, position=1)]
        [System.Nullable[System.UInt32]]
        # The MaxResults parameter identifies the maximum number of results to return.
        ${MaxResults},

        [Parameter(Mandatory=$false, position=2)]
        [System.Boolean]
        # The ExactMatchOnly parameter instructs the cmdlet to return exact matches only.
        ${ExactMatchOnly},

        [Parameter(Mandatory=$false, position=3)]
        [System.Boolean]
        # The MailEnabledOnly parameter instructs the cmdlet to return mail enabled only.
        ${MailEnabledOnly},

        [Parameter(Mandatory=$false, position=4)]
        [Switch]
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            # We want to flight our cmdlet if Force param is passed, but AutoRest doesn't support Force param.
            # Force param doesn't seem to do anything, so remove it if it's passed.
            if ($PSBoundParameters.ContainsKey('Force')) {
                $PSBoundParameters.Remove('Force') | Out-Null
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Find-CsGroup @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

            $output = @()
            foreach($internalGroup in $internalOutput.Group)
            {
                $group = [Microsoft.Rtc.Management.Hosted.Group.Models.GroupModel]::new()
                $group.ParseFrom($internalGroup)
                $output += $group
            }

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Put nested ApplicationInstance object as first layer object

function Find-CsOnlineApplicationInstance {
    [OutputType([Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.ApplicationInstance])]
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # A query for application instances by display name, telephone number, or GUID of the application instance
        ${SearchQuery},

        [Parameter(Mandatory=$false, position=1)]
        [System.Nullable[System.UInt32]]
        # The maximum number of results to return
        ${MaxResults},

        [Parameter(Mandatory=$false, position=2)]
        [Switch]
        # Instruct the cmdlet to return exact matches only
        ${ExactMatchOnly},

        [Parameter(Mandatory=$false, position=3)]
        [Switch]
        # Instruct the cmdlet to return only application instances that are associated to a configuration
        ${AssociatedOnly},

        [Parameter(Mandatory=$false, position=4)]
        [Switch]
        # instructs the cmdlet to return only application instances that are not associated to any configuration
        ${UnAssociatedOnly},

        [Parameter(Mandatory=$false, position=5)]
        [Switch]
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            # We want to flight our cmdlet if Force param is passed, but AutoRest doesn't support Force param.
            # Force param doesn't seem to do anything, so remove it if it's passed.
            if ($PSBoundParameters.ContainsKey('Force')) {
                $PSBoundParameters.Remove('Force') | Out-Null
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Find-CsOnlineApplicationInstance @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

            $output = @()
            foreach($internalOutputApplicationInstance in $internalOutput.ApplicationInstance)
            {
                $applicationInstance = [Microsoft.Rtc.Management.Hosted.Online.Models.FindApplicationInstanceResult]::new()
                $applicationInstance.ParseFrom($internalOutputApplicationInstance)
                $output += $applicationInstance
            }

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Format output of the cmdlet

function Get-CsAutoAttendant {
    [CmdletBinding(DefaultParameterSetName='GetAllParamSet', PositionalBinding=$false)]
    param(
        [Parameter(Mandatory=$true, position=0, ParameterSetName='GetSpecificParamSet')]
        [System.String]
        # The identity for the AA to be retrieved.
        ${Identity},

        [Parameter(Mandatory=$false, position=1, ParameterSetName='GetAllParamSet')]
        [Switch]
        # If specified, the status records for each auto attendant in the result set are also retrieved.
        ${IncludeStatus},

        [Parameter(Mandatory=$false, position=2, ParameterSetName='GetAllParamSet')]
        [Int]
        # The First parameter indicates the maximum number of auto attendants to retrieve as the result.
        ${First},

        [Parameter(Mandatory=$false, position=3, ParameterSetName='GetAllParamSet')]
        [Int]
        # The Skip parameter indicates the number of initial auto attendants to skip in the result.
        ${Skip},

        [Parameter(Mandatory=$false, position=4, ParameterSetName='GetAllParamSet')]
        [Switch]
        # If specified, only auto attendants' names, identities and associated application instances will be retrieved.
        ${ExcludeContent},

        [Parameter(Mandatory=$false, position=5, ParameterSetName='GetAllParamSet')]
        [System.String]
        # If specified, only auto attendants whose names match that value would be returned.
        ${NameFilter},

        [Parameter(Mandatory=$false, position=6, ParameterSetName='GetAllParamSet')]
        [System.String]
        # If specified, the retrieved auto attendants would be sorted by the specified property.
        ${SortBy},

        [Parameter(Mandatory=$false, position=7, ParameterSetName='GetAllParamSet')]
        [Switch]
        # If specified, the retrieved auto attendants would be sorted in descending order.
        ${Descending},

        [Parameter(Mandatory=$false, position=8)]
        [Switch]
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {
            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            # We want to flight our cmdlet if Force param is passed, but AutoRest doesn't support Force param.
            # Force param doesn't seem to do anything, so remove it if it's passed.
            if ($PSBoundParameters.ContainsKey('Force')) {
                $PSBoundParameters.Remove('Force') | Out-Null
            }

            # Get common parameters
            $PSBoundCommonParameters = @{}
            foreach($p in $PSBoundParameters.GetEnumerator())
            {
                $PSBoundCommonParameters += @{$p.Key = $p.Value}
            }
            $null = $PSBoundCommonParameters.Remove("Identity")
            $null = $PSBoundCommonParameters.Remove("First")
            $null = $PSBoundCommonParameters.Remove("Skip")
            $null = $PSBoundCommonParameters.Remove("ExcludeContent")
            $null = $PSBoundCommonParameters.Remove("NameFilter")
            $null = $PSBoundCommonParameters.Remove("SortBy")
            $null = $PSBoundCommonParameters.Remove("Descending")

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsAutoAttendant @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

            $output = @()
            foreach($internalOutputAutoAttendant in $internalOutput.AutoAttendant)
            {
                $autoAttendant = [Microsoft.Rtc.Management.Hosted.OAA.Models.AutoAttendant]::new()
                $autoAttendant.ParseFrom($internalOutputAutoAttendant, $ExcludeContent)

            if ($Identity)
            {
                # Append common parameter here
                $getCsAutoAttendantStatusParameters = @{Identity = $autoAttendant.Identity}
                foreach($p in $PSBoundCommonParameters.GetEnumerator())
                {
                    $getCsAutoAttendantStatusParameters += @{$p.Key = $p.Value}
                }

                    $internalStatus = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsAutoAttendantStatus @getCsAutoAttendantStatusParameters @httpPipelineArgs

                    $autoAttendant.AmendStatus($internalStatus)
                }

                $output += $autoAttendant
            }

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Print error message in case of error

function Get-CsAutoAttendantHolidays {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The identity for the AA whose holiday schedules are to be exported..
        ${Identity},

        [Parameter(Mandatory=$false, position=1)]
        [System.String[]]
        # The identity for the AA to be retrieved.
        ${Years},

        [Parameter(Mandatory=$false, position=2)]
        [System.String[]]
        # If specified, the status records for each auto attendant in the result set are also retrieved.
        ${Names},

        [Parameter(Mandatory=$false, position=3)]
        [Switch]
        # The Force parameter indicates if we force the action to be performed. (Deprecated)
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Remove("Force")

            if ($PSBoundParameters.ContainsKey("Years")) {
                $null = $PSBoundParameters.Remove("Years")
                $PSBoundParameters.Add("Year", $Years)
            }

            if ($PSBoundParameters.ContainsKey("Names")) {
                $null = $PSBoundParameters.Remove("Names")
                $PSBoundParameters.Add("Name", $Names)
            }

            # Use ResponseType 0 as visualization record
            $PSBoundParameters.Add("ResponseType", 0)

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsAutoAttendantHolidays @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

            $output = @()
            foreach($internalHolidayVisualizationRecord in $internalOutput.HolidayVisualizationRecord)
            {
                $holidayVisualizationRecord = [Microsoft.Rtc.Management.Hosted.OAA.Models.HolidayVisRecord]::new()
                $holidayVisualizationRecord.ParseFrom($internalHolidayVisualizationRecord)
                $output += $holidayVisualizationRecord
            }

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Format output of the cmdlet

function Get-CsAutoAttendantStatus {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The identity for the AA to be retrieved.
        ${Identity},

        [Parameter(Mandatory=$false, position=1)]
        [System.String[]]
        ${IncludeResources},

        [Parameter(Mandatory=$false, position=2)]
        [Switch]
        # The Force parameter indicates if we force the action to be performed. (Deprecated)
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Remove("Force")

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsAutoAttendantStatus @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

            $output = [Microsoft.Rtc.Management.Hosted.OAA.Models.StatusRecord]::new()
            $output.ParseFrom($internalOutput)

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Print error message in case of error

function Get-CsAutoAttendantSupportedLanguage {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$false, position=0)]
        [System.String]
        # The Identity parameter designates a specific language to be retrieved.
        ${Identity},

        [Parameter(Mandatory=$false, position=1)]
        [Switch]
        # The Force parameter indicates if we force the action to be performed. (Deprecated)
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Remove("Force")

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            # Use ResponseType 1 as binary output
            if ($PSBoundParameters.ContainsKey('Identity')) {
                $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsAutoAttendantSupportedLanguage @PSBoundParameters @httpPipelineArgs

                # Stop execution if internal cmdlet is failing
                if ($internalOutput -eq $null) {
                    return $null
                }

                Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

                $output = [Microsoft.Rtc.Management.Hosted.OAA.Models.Language]::new()
                $output.ParseFrom($internalOutput)

                $output
            } else {
                $tenantInfoOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsAutoAttendantTenantInformation @PSBoundParameters @httpPipelineArgs

                # Stop execution if internal cmdlet is failing
                if ($tenantInfoOutput -eq $null) {
                    return $null
                }

                Write-AdminServiceDiagnostic($tenantInfoOutput.Diagnostic)

                $supportedLanguagesOutput = @()
                foreach ($supportedLanguage in $tenantInfoOutput.TenantInformationSupportedLanguage) {
                    $languageOutput = [Microsoft.Rtc.Management.Hosted.OAA.Models.Language]::new()
                    $languageOutput.ParseFrom($supportedLanguage)
                    $supportedLanguagesOutput += $languageOutput
                }

                $supportedLanguagesOutput
            }

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Print error message in case of error

function Get-CsAutoAttendantSupportedTimeZone {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$false, position=0)]
        [System.String]
        # The Identity parameter specifies a time zone to be retrieved.
        ${Identity},

        [Parameter(Mandatory=$false, position=1)]
        [Switch]
        # The Force parameter indicates if we force the action to be performed. (Deprecated)
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Remove("Force")

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            # Use ResponseType 1 as binary output
            if ($PSBoundParameters.ContainsKey('Identity')) {
                $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsAutoAttendantSupportedTimeZone @PSBoundParameters @httpPipelineArgs

                # Stop execution if internal cmdlet is failing
                if ($internalOutput -eq $null) {
                    return $null
                }

                Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

                $output = [Microsoft.Rtc.Management.Hosted.OAA.Models.TimeZone]::new()
                $output.ParseFrom($internalOutput)

                $output
            } else {
                $tenantInfoOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsAutoAttendantTenantInformation @PSBoundParameters @httpPipelineArgs

                # Stop execution if internal cmdlet is failing
                if ($tenantInfoOutput -eq $null) {
                    return $null
                }

                Write-AdminServiceDiagnostic($tenantInfoOutput.Diagnostic)

                $supportedTimezonesOutput = @()
                foreach ($supportedTimezone in $tenantInfoOutput.TenantInformationSupportedTimeZone) {
                    $timezoneOutput = [Microsoft.Rtc.Management.Hosted.OAA.Models.TimeZone]::new()
                    $timezoneOutput.ParseFrom($supportedTimezone)
                    $supportedTimezonesOutput += $timezoneOutput
                }

                $supportedTimezonesOutput
            }

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Print error message in case of error

function Get-CsAutoAttendantTenantInformation {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$false, position=0)]
        [Switch]
        # The Force parameter indicates if we force the action to be performed. (Deprecated)
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Remove("Force")

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsAutoAttendantTenantInformation @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

            $output = [Microsoft.Rtc.Management.Hosted.OAA.Models.TenantInformation]::new()
            $output.ParseFrom($internalOutput)

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: transforming the results to the custom objects

function Get-CsCallQueue {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [System.String]
        # The identity of the call queue which is retrieved.
        ${Identity},

        [Parameter(Mandatory=$false)]
        [int]
        # The First parameter gets the first N Call Queues.
        ${First},

        [Parameter(Mandatory=$false)]
        [int]
        # The Skip parameter skips the first N Call Queues. It is intended to be used for pagination purposes.
        ${Skip},

        [Parameter(Mandatory=$false)]
        [switch]
        # The ExcludeContent parameter only displays the Name and Id of the Call Queues.
        ${ExcludeContent},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The Sort parameter specifies the property used to sort.
        ${Sort},

        [Parameter(Mandatory=$false)]
        [switch]
        # The Descending parameter is used to sort descending.
        ${Descending},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NameFilter parameter returns Call Queues where name contains specified string
        ${NameFilter},

        [Parameter(Mandatory=$false)]
        [Switch]
        # Allow the cmdlet to run anyway
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            if (${Identity} -and (${First} -or ${Skip} -or ${Sort} -or ${Descending} -or ${NameFilter})) {
                throw "Identity parameter cannot be used with any other parameter."
            }

            # Set the 'FilterInvalidObos' query parameter value to false.
            $PSBoundParameters.Add('FilterInvalidObos', $false)

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            if ($PSBoundParameters.ContainsKey('Force')) {
                $PSBoundParameters.Remove('Force') | Out-Null
            }

            # Endpoint to get single entity does not support content exclusion, so we will filter content when displaying
            if ($PSBoundParameters.ContainsKey('Identity') -and $PSBoundParameters.ContainsKey('ExcludeContent')) {
                $PSBoundParameters.Remove("ExcludeContent")
            }

            $result = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsCallQueue @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($result -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($result.Diagnostic)

            if (${Identity} -ne '') {
                $callQueue = [Microsoft.Rtc.Management.Hosted.CallQueue.Models.CallQueue]::new()
                $callQueue.ParseFrom($result.CallQueue, $ExcludeContent)
            } else {
                $callQueues = @()
                foreach ($model in $result.CallQueue) {
                    $callQueue = [Microsoft.Rtc.Management.Hosted.CallQueue.Models.CallQueue]::new()
                    $callQueues += $callQueue.ParseFrom($model, $ExcludeContent)
                }
                $callQueues
            }

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Print error message in case of error

function Get-CsOnlineApplicationInstanceAssociation {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The identity for the application instance whose association is to be retrieved.
        ${Identity},

        [Parameter(Mandatory=$false, position=1)]
        [Switch]
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            # We want to flight our cmdlet if Force param is passed, but AutoRest doesn't support Force param.
            # Force param doesn't seem to do anything, so remove it if it's passed.
            if ($PSBoundParameters.ContainsKey('Force')) {
                $PSBoundParameters.Remove('Force') | Out-Null
            }

            # Encode the given "Identity" if it is a SIP URI (aka User Principle Name (UPN))
            $PSBoundParameters['Identity']  = EncodeSipUri($PSBoundParameters['Identity'])

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsOnlineApplicationInstanceAssociation @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

            $output = [Microsoft.Rtc.Management.Hosted.Online.Models.ApplicationInstanceAssociation]::new()
            $output.ParseFrom($internalOutput)

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Format output of the cmdlet

function Get-CsOnlineApplicationInstanceAssociationStatus {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The identity for the application instance whose association provisioning status is to be retrieved.
        ${Identity},

        [Parameter(Mandatory=$false, position=1)]
        [Switch]
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            # We want to flight our cmdlet if Force param is passed, but AutoRest doesn't support Force param.
            # Force param doesn't seem to do anything, so remove it if it's passed.
            if ($PSBoundParameters.ContainsKey('Force')) {
                $PSBoundParameters.Remove('Force') | Out-Null
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsOnlineApplicationInstanceAssociationStatus @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)
        
            $output = [Microsoft.Rtc.Management.Hosted.Online.Models.StatusRecord]::new()
            $output.ParseFrom($internalOutput)

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Format output of Get-CsOnlineAudioFile

function Get-CsOnlineAudioFile {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$false, position=0)]
        [System.String]
        # The Identity parameter is the identifier for the audio file.
        ${Identity},

        [Parameter(Mandatory=$false, position=1)]
        [System.String]
        # The ApplicationId parameter is the identifier for the application which will use this audio file. 
        ${ApplicationId},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default Application ID to TenantGlobal and make it to the correct case
            if ($ApplicationId -eq "" -or $ApplicationId -like "TenantGlobal")
            {
                $ApplicationId = "TenantGlobal"
            }
            elseif ($ApplicationId -like "OrgAutoAttendant")
            {
                $ApplicationId = "OrgAutoAttendant"
            }
            elseif ($ApplicationId -like "HuntGroup")
            {
                $ApplicationId = "HuntGroup"
            }

            $null = $PSBoundParameters.Remove("ApplicationId")
            $PSBoundParameters.Add("ApplicationId", $ApplicationId)

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            if ($Identity -ne "") {
                $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsOnlineAudioFile @PSBoundParameters @httpPipelineArgs

                # Stop execution if internal cmdlet is failing
                if ($internalOutput -eq $null) {
                    return $null
                }

                $output = [Microsoft.Rtc.Management.Hosted.Online.Models.AudioFile]::new()
                $output.ParseFrom($internalOutput)
            }
            else {
                $internalOutputs = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsOnlineAudioFile @PSBoundParameters @httpPipelineArgs

                # Stop execution if internal cmdlet is failing
                if ($internalOutputs -eq $null) {
                    return $null
                }

                $output = New-Object Collections.Generic.List[Microsoft.Rtc.Management.Hosted.Online.Models.AudioFile]
                foreach($internalOutput in $internalOutputs) {
                    $audioFile = [Microsoft.Rtc.Management.Hosted.Online.Models.AudioFile]::new()
                    $audioFile.ParseFrom($internalOutput)
                    $output.Add($audioFile)
                }
            }

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: transforming the results to the custom objects

function Get-CsOnlineSchedule {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [System.String]
        # The identity of the schedule which is retrieved.
        ${Id},
        
        [Parameter(Mandatory=$false)]
        [Switch]
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }
        
            if ($PSBoundParameters.ContainsKey("Force")) {
                $PSBoundParameters.Remove("Force") | Out-Null
            }

            $result = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsOnlineSchedule @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($result -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($result.Diagnostic)

            if (${Id} -ne '') {
                $schedule = [Microsoft.Rtc.Management.Hosted.Online.Models.Schedule]::new()
                $schedule.ParseFrom($result)
            } else {
                $schedules = @()
                foreach ($model in $result.Schedule) {
                    $schedule = [Microsoft.Rtc.Management.Hosted.Online.Models.Schedule]::new()
                    $schedules += $schedule.ParseFrom($model)
                }
                $schedules
            }

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Print error message in case of error

function Get-CsOnlineVoicemailUserSettings {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The identity for the user for the voice mail settings
        ${Identity},

        [Parameter(Mandatory=$false, position=1)]
        [Switch]
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            if ($PSBoundParameters.ContainsKey("Force")) {
                $PSBoundParameters.Remove("Force") | Out-Null
            }

            $result = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsOnlineVMUserSetting @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($result -eq $null) {
                return $null
            }

            $result
            
        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Print error message in case of error

function Import-CsAutoAttendantHolidays {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The identity for the AA whose holiday schedules are to be imported.
        ${Identity},

        [Alias('Input')]
        [Parameter(Mandatory=$true, position=1)]
        [System.Byte[]]
        ${InputBytes},

        [Parameter(Mandatory=$false, position=2)]
        [Switch]
        # The Force parameter indicates if we force the action to be performed. (Deprecated)
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Remove("Force")

            $base64input = [System.Convert]::ToBase64String($InputBytes)
            $PSBoundParameters.Add("SerializedHolidayRecord", $base64input)
            $null = $PSBoundParameters.Remove("InputBytes")

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Import-CsAutoAttendantHolidays @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

            $output = @()
            foreach($internalImportHolidayStatus in $internalOutput.ImportAutoAttendantHolidayResultImportHolidayStatusRecord)
            {
                $importHolidayStatus = [Microsoft.Rtc.Management.Hosted.OAA.Models.HolidayImportResult]::new()
                $importHolidayStatus.ParseFrom($internalImportHolidayStatus)
                $output += $importHolidayStatus
            }

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Base64 encode the content for the audio file

function Import-CsOnlineAudioFile {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$false, position=0)]
        [System.String]
        # The ApplicationId parameter is the identifier for the application which will use this audio file. 
        ${ApplicationId},

        [Parameter(Mandatory=$true, position=1)]
        [System.String]
        # The FileName parameter is the name of the audio file.
        ${FileName},

        [Parameter(Mandatory=$true, position=2)]
        [System.Byte[]]
        # The Content parameter represents the content of the audio file.
        ${Content},

        [Parameter(Mandatory=$false, position=3)]
        [Switch]
        # The Force parameter indicates if we force the action to be performed. (Deprecated)
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Remove("Force")

            $base64content = [System.Convert]::ToBase64String($Content)
            $null = $PSBoundParameters.Remove("Content")
            $PSBoundParameters.Add("Content", $base64content)

            # Default Application ID to TenantGlobal and make it to the correct case
            if ($ApplicationId -eq "" -or $ApplicationId -like "TenantGlobal")
            {
                $ApplicationId = "TenantGlobal"
            }
            elseif ($ApplicationId -like "OrgAutoAttendant")
            {
                $ApplicationId = "OrgAutoAttendant"
            }
            elseif ($ApplicationId -like "HuntGroup")
            {
                $ApplicationId = "HuntGroup"
            }
            $null = $PSBoundParameters.Remove("ApplicationId")
            $PSBoundParameters.Add("ApplicationId", $ApplicationId)

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Import-CsOnlineAudioFile @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            $output = [Microsoft.Rtc.Management.Hosted.Online.Models.AudioFile]::new()
            $output.ParseFrom($internalOutput)

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Format output of cmdlet

function New-CsAutoAttendant {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The Name parameter is a friendly name that is assigned to the AA.
        ${Name},

        [Parameter(Mandatory=$true, position=1)]
        [System.String]
        # The LanguageId parameter is the language that is used to read text-to-speech (TTS) prompts.
        ${LanguageId},

        [Parameter(Mandatory=$false, position=2)]
        [System.String]
        # The VoiceId parameter represents the voice that is used to read text-to-speech (TTS) prompts.
        ${VoiceId},

        [Parameter(Mandatory=$true, position=3)]
        [Microsoft.Rtc.Management.Hosted.OAA.Models.CallFlow]
        # The DefaultCallFlow parameter is the flow to be executed when no other call flow is in effect (for example, during business hours).
        ${DefaultCallFlow},

        [Parameter(Mandatory=$false, position=4)]
        [Microsoft.Rtc.Management.Hosted.OAA.Models.CallableEntity]
        # The Operator parameter represents the address or PSTN number of the operator.
        ${Operator},

        [Parameter(Mandatory=$false, position=5)]
        [Switch]
        # The EnableVoiceResponse parameter indicates whether voice response for AA is enabled.
        ${EnableVoiceResponse},

        [Parameter(Mandatory=$true, position=6)]
        [System.String]
        # The TimeZoneId parameter represents the AA time zone.
        ${TimeZoneId},

        [Parameter(Mandatory=$false, position=7)]
        [Microsoft.Rtc.Management.Hosted.OAA.Models.CallFlow[]]
        # The CallFlows parameter represents call flows, which are required if they are referenced in the CallHandlingAssociations parameter.
        ${CallFlows},

        [Parameter(Mandatory=$false, position=8)]
        [Microsoft.Rtc.Management.Hosted.OAA.Models.CallHandlingAssociation[]]
        # The CallHandlingAssociations parameter represents the call handling associations.
        ${CallHandlingAssociations},

        [Parameter(Mandatory=$false, position=9)]
        [Microsoft.Rtc.Management.Hosted.OAA.Models.DialScope]
        # Specifies the users to which call transfers are allowed through directory lookup feature.
        ${InclusionScope},

        [Parameter(Mandatory=$false, position=10)]
        [Microsoft.Rtc.Management.Hosted.OAA.Models.DialScope]
        # Specifies the users to which call transfers are not allowed through directory lookup feature.
        ${ExclusionScope},

        [Parameter(Mandatory=$false, position=11)]
        [System.Guid[]]
        # The list of authorized users.
        ${AuthorizedUsers},

        [Parameter(Mandatory=$false, position=12)]
        [System.Guid[]]
        # The list of hidden authorized users.
        ${HideAuthorizedUsers},

        [Parameter(Mandatory=$false, position=13)]
        [Switch]
        # The Force parameter indicates if we force the action to be performed. (Deprecated)
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Remove("Force")

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            # Get common parameters
            $PSBoundCommonParameters = @{}
            foreach($p in $PSBoundParameters.GetEnumerator())
            {
                $PSBoundCommonParameters += @{$p.Key = $p.Value}
            }
            $null = $PSBoundCommonParameters.Remove("Name")
            $null = $PSBoundCommonParameters.Remove("LanguageId")
            $null = $PSBoundCommonParameters.Remove("VoiceId")
            $null = $PSBoundCommonParameters.Remove("DefaultCallFlow")
            $null = $PSBoundCommonParameters.Remove("Operator")
            $null = $PSBoundCommonParameters.Remove("EnableVoiceResponse")
            $null = $PSBoundCommonParameters.Remove("TimeZoneId")
            $null = $PSBoundCommonParameters.Remove("CallFlows")
            $null = $PSBoundCommonParameters.Remove("CallHandlingAssociations")
            $null = $PSBoundCommonParameters.Remove("InclusionScope")
            $null = $PSBoundCommonParameters.Remove("ExclusionScope")
            $null = $PSBoundCommonParameters.Remove("AuthorizedUsers")
            $null = $PSBoundCommonParameters.Remove("HideAuthorizedUsers")

            if ($DefaultCallFlow -ne $null) {
                $null = $PSBoundParameters.Remove('DefaultCallFlow')
                if ($DefaultCallFlow.Id -ne $null) {
                    $PSBoundParameters.Add('DefaultCallFlowId', $DefaultCallFlow.Id)
                }
                if ($DefaultCallFlow.Greetings -ne $null) {
                    $defaultCallFlowGreetings = @()
                    foreach ($defaultCallFlowGreeting in $DefaultCallFlow.Greetings) {
                        $defaultCallFlowGreetings += $defaultCallFlowGreeting.ParseToAutoGeneratedModel()
                    }
                    $PSBoundParameters.Add('DefaultCallFlowGreeting', $defaultCallFlowGreetings)
                }
                if ($DefaultCallFlow.Name -ne $null) {
                    $PSBoundParameters.Add('DefaultCallFlowName', $DefaultCallFlow.Name)
                }
                if ($DefaultCallFlow.ForceListenMenuEnabled -eq $true) {
                    $PSBoundParameters.Add('ForceListenMenuEnabled', $true)
                }
                if ($DefaultCallFlow.Menu -ne $null) {
                    if ($DefaultCallFlow.Menu.DialByNameEnabled) {
                        $PSBoundParameters.Add('MenuDialByNameEnabled', $true)
                    }
                    $PSBoundParameters.Add('MenuDirectorySearchMethod', $DefaultCallFlow.Menu.DirectorySearchMethod.ToString())
                    if ($DefaultCallFlow.Menu.Name -ne $null) {
                        $PSBoundParameters.Add('MenuName', $DefaultCallFlow.Menu.Name)
                    }
                    if ($DefaultCallFlow.Menu.MenuOptions -ne $null) {
                        $defaultCallFlowMenuOptions = @()
                        foreach ($defaultCallFlowMenuOption in $DefaultCallFlow.Menu.MenuOptions) {
                            $defaultCallFlowMenuOptions += $defaultCallFlowMenuOption.ParseToAutoGeneratedModel()
                        }
                        $PSBoundParameters.Add('MenuOption', $defaultCallFlowMenuOptions)
                    }
                    if ($DefaultCallFlow.Menu.Prompts -ne $null) {
                        $defaultCallFlowMenuPrompts = @()
                        foreach ($defaultCallFlowMenuPrompt in $DefaultCallFlow.Menu.Prompts) {
                            $defaultCallFlowMenuPrompts += $defaultCallFlowMenuPrompt.ParseToAutoGeneratedModel()
                        }
                        $PSBoundParameters.Add('MenuPrompt', $defaultCallFlowMenuPrompts)
                    }
                }
            }
            if ($CallFlows -ne $null) {
                $null = $PSBoundParameters.Remove('CallFlows')
                $inputCallFlows = @()
                foreach ($callFlow in $CallFlows) {
                    $inputCallFlows += $callFlow.ParseToAutoGeneratedModel()
                }
                $PSBoundParameters.Add('CallFlow', $inputCallFlows)
            }
            if ($CallHandlingAssociations -ne $null) {
                $null = $PSBoundParameters.Remove('CallHandlingAssociations')
                $inputCallHandlingAssociations = @()
                foreach ($callHandlingAssociation in $CallHandlingAssociations) {
                    $inputCallHandlingAssociations += $callHandlingAssociation.ParseToAutoGeneratedModel()
                }
                $PSBoundParameters.Add('CallHandlingAssociation', $inputCallHandlingAssociations)
            }
            if ($Operator -ne $null) {
                $null = $PSBoundParameters.Remove('Operator')
                $PSBoundParameters.Add('OperatorEnableTranscription', $Operator.EnableTranscription)
                $PSBoundParameters.Add('OperatorId', $Operator.Id)
                $PSBoundParameters.Add('OperatorType', $Operator.Type.ToString())
            }
            if ($InclusionScope -ne $null) {
                $null = $PSBoundParameters.Remove('InclusionScope')
                $PSBoundParameters.Add('InclusionScopeType', $InclusionScope.Type.ToString())
                $PSBoundParameters.Add('InclusionScopeGroupDialScopeGroupId', $InclusionScope.GroupScope.GroupIds)
            }
            if ($ExclusionScope -ne $null) {
                $null = $PSBoundParameters.Remove('ExclusionScope')
                $PSBoundParameters.Add('ExclusionScopeType', $ExclusionScope.Type.ToString())
                $PSBoundParameters.Add('ExclusionScopeGroupDialScopeGroupId', $ExclusionScope.GroupScope.GroupIds)
            }
            if ($AuthorizedUsers -ne $null) {
                $null = $PSBoundParameters.Remove('AuthorizedUsers')
                $inputAuthorizedUsers = @()
                foreach ($authorizedUser in $AuthorizedUsers) {
                    $inputAuthorizedUsers += $authorizedUser.ToString()
                }
                $PSBoundParameters.Add('AuthorizedUser', $inputAuthorizedUsers)
            }
            if ($HideAuthorizedUsers -ne $null) {
                $null = $PSBoundParameters.Remove('HideAuthorizedUsers')
                $inputHideAuthorizedUsers = @()
                foreach ($hiddenAuthorizedUser in $HideAuthorizedUsers) {
                    $inputHideAuthorizedUsers += $hiddenAuthorizedUser.ToString()
                }
                $PSBoundParameters.Add('HideAuthorizedUser', $inputHideAuthorizedUsers)
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsAutoAttendant @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

            $output = [Microsoft.Rtc.Management.Hosted.OAA.Models.AutoAttendant]::new()
            $output.ParseFrom($internalOutput.AutoAttendant)

            $getCsAutoAttendantStatusParameters = @{Identity = $output.Identity}
            foreach($p in $PSBoundCommonParameters.GetEnumerator())
            {
                $getCsAutoAttendantStatusParameters += @{$p.Key = $p.Value}
            }

            $internalStatus = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsAutoAttendantStatus @getCsAutoAttendantStatusParameters @httpPipelineArgs
            $output.AmendStatus($internalStatus)

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Format output of cmdlet

function New-CsAutoAttendantCallableEntity {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The Identity parameter represents the ID of the callable entity
        ${Identity},

        [Parameter(Mandatory=$true, position=1)]
        [Microsoft.Rtc.Management.Hosted.OAA.Models.CallableEntityType]
        # The Type parameter represents the type of the callable entity
        ${Type},

        [Parameter(Mandatory=$false, position=2)]
        [Switch]
        # Enables the email transcription of voicemail, this is only supported with shared voicemail callable entities.
        ${EnableTranscription},

        [Parameter(Mandatory=$false, position=3)]
        [Switch]
        # Suppresses the "Please leave a message after the tone" system prompt when transferring to shared voicemail.
        ${EnableSharedVoicemailSystemPromptSuppression},

        [Parameter(Mandatory=$false, position=4)]
        [Switch]
        # The Force parameter indicates if we force the action to be performed. (Deprecated)
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Remove("Force")

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsAutoAttendantCallableEntity @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

            $output = [Microsoft.Rtc.Management.Hosted.OAA.Models.CallableEntity]::new()
            $output.ParseFrom($internalOutput)

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Put nested ApplicationInstance object as first layer object

function New-CsAutoAttendantCallFlow {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The Name parameter represents a unique friendly name for the call flow.
        ${Name},

        [Parameter(Mandatory=$false, position=1)]
        [PSObject[]]
        # If present, the prompts specified by the Greetings parameter (either TTS or Audio) are played before the call flow's menu is rendered.
        ${Greetings},

        [Parameter(Mandatory=$true, position=2)]
        [PSObject]
        # The Menu parameter identifies the menu to render when the call flow is executed.
        ${Menu},

        [Parameter(Mandatory=$false, position=3)]
        [Switch]
        # The ForceListenMenuEnabled parameter indicates whether the caller will be forced to listen to the menu.
        ${ForceListenMenuEnabled},

        [Parameter(Mandatory=$false, position=4)]
        [Switch]
        # The Force parameter indicates if we force the action to be performed. (Deprecated)
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Remove("Force")

            If ($ForceListenMenuEnabled -ne $null){
                $null = $PSBoundParameters.Remove("ForceListenMenuEnabled")
                $PSBoundParameters.Add('ForceListenMenuEnabled', $ForceListenMenuEnabled)
            }
            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            if ($Greetings -ne $null) {
                $null = $PSBoundParameters.Remove('Greetings')
                $inputGreetings = @()
                foreach ($greeting in $Greetings) {
                    $inputGreetings += [Microsoft.Rtc.Management.Hosted.OAA.Models.Prompt]::CreateAutoGeneratedFromObject($greeting)
                }
                $PSBoundParameters.Add('Greeting', $inputGreetings)
            }

            if ($Menu -ne $null) {
                $null = $PSBoundParameters.Remove('Menu')
                if ($Menu.DialByNameEnabled) {
                    $PSBoundParameters.Add('MenuDialByNameEnabled', $true)
                }
                $PSBoundParameters.Add('MenuDirectorySearchMethod', $Menu.DirectorySearchMethod)
                $PSBoundParameters.Add('MenuName', $Menu.Name)
                $inputMenuOptions = @()
                foreach ($menuOption in $Menu.MenuOptions) {
                    $inputMenuOptions += [Microsoft.Rtc.Management.Hosted.OAA.Models.MenuOption]::CreateAutoGeneratedFromObject($menuOption)
                }
                $PSBoundParameters.Add('MenuOption', $inputMenuOptions)
                $inputMenuPrompts = @()
                foreach ($menuPrompt in $Menu.Prompts) {
                    $inputMenuPrompts += [Microsoft.Rtc.Management.Hosted.OAA.Models.Prompt]::CreateAutoGeneratedFromObject($menuPrompt)
                }
                $PSBoundParameters.Add('MenuPrompt', $inputMenuPrompts)
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsAutoAttendantCallFlow @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

            $output = [Microsoft.Rtc.Management.Hosted.OAA.Models.CallFlow]::new()
            $output.ParseFrom($internalOutput)

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Print diagnostic message from service

function New-CsAutoAttendantCallHandlingAssociation {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [Microsoft.Rtc.Management.Hosted.OAA.Models.CallHandlingAssociationType]
        # The Type parameter represents the type of the call handling association.
        ${Type},

        [Parameter(Mandatory=$true, position=1)]
        [System.String]
        # The ScheduleId parameter represents the schedule to be associated with the call flow.
        ${ScheduleId},

        [Parameter(Mandatory=$true, position=2)]
        [System.String]
        # The CallFlowId parameter represents the call flow to be associated with the schedule.
        ${CallFlowId},

        [Parameter(Mandatory=$false, position=3)]
        [Switch]
        # The Disable parameter, if set, establishes that the call handling association is created as disabled.
        ${Disable},

        [Parameter(Mandatory=$false, position=4)]
        [Switch]
        # The Force parameter indicates if we force the action to be performed. (Deprecated)
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Remove("Force")

            if ($Disable -eq $true) {
                $null = $PSBoundParameters.Remove('Disable')
            } else {
                $PSBoundParameters.Add('Enable', $true)
            }

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsAutoAttendantCallHandlingAssociation @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

            $output = [Microsoft.Rtc.Management.Hosted.OAA.Models.CallHandlingAssociation]::new()
            $output.ParseFrom($internalOutput)

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Print diagnostic message from server respond

function New-CsAutoAttendantDialScope {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [Switch]
        # Indicates that a dial-scope based on groups (distribution lists, security groups) is to be created.
        ${GroupScope},

        [Parameter(Mandatory=$true, position=1)]
        [System.String[]]
        # Refers to the IDs of the groups that are to be included in the dial-scope.
        ${GroupIds},

        [Parameter(Mandatory=$false, position=2)]
        [Switch]
        # The Force parameter indicates if we force the action to be performed. (Deprecated)
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Remove("Force")

            if ($GroupScope -eq $true) {
                $null = $PSBoundParameters.Remove('GroupScope')
            }

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsAutoAttendantDialScope @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

            $output = [Microsoft.Rtc.Management.Hosted.OAA.Models.DialScope]::new()
            $output.ParseFrom($internalOutput)

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Format input of the cmdlet

function New-CsAutoAttendantMenu {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The Name parameter represents a friendly name for the menu.
        ${Name},

        [Parameter(Mandatory=$false, position=1)]
        [PSObject[]]
        # The Prompts parameter reflects the prompts to play when the menu is activated.
        ${Prompts},

        [Parameter(Mandatory=$false, position=2)]
        [PSObject[]]
        # The MenuOptions parameter is a list of menu options for this menu.
        ${MenuOptions},

        [Parameter(Mandatory=$false, position=3)]
        [Switch]
        # The EnableDialByName parameter lets users do a directory search by recipient name and get transferred to the party.
        ${EnableDialByName},

        [Parameter(Mandatory=$false, position=4)]
        [Microsoft.Rtc.Management.Hosted.OAA.Models.DirectorySearchMethod]
        # The DirectorySearchMethod parameter lets you define the type of Directory Search Method for the Auto Attendant menu.
        ${DirectorySearchMethod},

        [Parameter(Mandatory=$false, position=5)]
        [Switch]
        # The Force parameter indicates if we force the action to be performed. (Deprecated)
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Remove("Force")

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            if ($Prompts -ne $null) {
                $null = $PSBoundParameters.Remove('Prompts')
                $inputPrompts = @()
                foreach ($prompt in $Prompts) {
                    $inputPrompts += [Microsoft.Rtc.Management.Hosted.OAA.Models.Prompt]::CreateAutoGeneratedFromObject($prompt)
                }
                $PSBoundParameters.Add('Prompt', $inputPrompts)
            }

            if ($MenuOptions -ne $null) {
                $null = $PSBoundParameters.Remove('MenuOptions')
                $inputMenuOptions = @()
                foreach ($menuOption in $MenuOptions) {
                    $inputMenuOptions += [Microsoft.Rtc.Management.Hosted.OAA.Models.MenuOption]::CreateAutoGeneratedFromObject($menuOption)
                }
                $PSBoundParameters.Add('MenuOption', $inputMenuOptions)
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsAutoAttendantMenu @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

            $output = [Microsoft.Rtc.Management.Hosted.OAA.Models.Menu]::new()
            $output.ParseFrom($internalOutput)

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Format input of the cmdlet

function New-CsAutoAttendantMenuOption {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [Microsoft.Rtc.Management.Hosted.OAA.Models.ActionType]
        # The Action parameter represents the action to be taken when the menu option is activated. 
        ${Action},

        [Parameter(Mandatory=$true, position=1)]
        [Microsoft.Rtc.Management.Hosted.OAA.Models.DtmfTone]
        # The DtmfResponse parameter indicates the key on the telephone keypad to be pressed to activate the menu option. 
        ${DtmfResponse},

        [Parameter(Mandatory=$false, position=2)]
        [System.String[]]
        # The VoiceResponses parameter represents the voice responses to select a menu option when Voice Responses are enabled for the auto attendant.
        ${VoiceResponses},

        [Parameter(Mandatory=$false, position=3)]
        [Microsoft.Rtc.Management.Hosted.OAA.Models.CallableEntity]
        # The CallTarget parameter represents the target for call transfer after the menu option is selected.
        ${CallTarget},

        [Parameter(Mandatory=$false, position=4)]
        [PSObject]
        # The Prompt parameter represents the announcement prompt.
        ${Prompt},

        [Parameter(Mandatory=$false, position=5)]
        [Switch]
        # The Force parameter indicates if we force the action to be performed. (Deprecated)
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Remove("Force")

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            if ($CallTarget -ne $null) {
                $null = $PSBoundParameters.Remove('CallTarget')
                $PSBoundParameters.Add('CallTargetId', $CallTarget.Id)
                $PSBoundParameters.Add('CallTargetType', $CallTarget.Type)
                if ($CallTarget.EnableTranscription) {
                    $PSBoundParameters.Add('CallTargetEnableTranscription', $True)
                }
                if ($CallTarget.EnableSharedVoicemailSystemPromptSuppression) {
                    $PSBoundParameters.Add('CallTargetEnableSharedVoicemailSystemPromptSuppression', $True)
                }
            }

            if ($Prompt -ne $null) {
                $typeNames = $Prompt.PSObject.TypeNames
                if ($typeNames -NotContains "Microsoft.Rtc.Management.Hosted.OAA.Models.Prompt" -and $typeNames -NotContains "Deserialized.Microsoft.Rtc.Management.Hosted.OAA.Models.Prompt") {
                    throw "PSObject must be type of Microsoft.Rtc.Management.Hosted.OAA.Models.Prompt or Deserialized.Microsoft.Rtc.Management.Hosted.OAA.Models.Prompt"
                }
            
                $null = $PSBoundParameters.Remove('Prompt')
                $PSBoundParameters.Add('PromptActiveType', $Prompt.ActiveType)
                $PSBoundParameters.Add('PromptTextToSpeechPrompt', $Prompt.TextToSpeechPrompt)
                if ($Prompt.AudioFilePrompt -ne $null -and $Prompt.AudioFilePrompt.Id -ne $null) {
                    $PSBoundParameters.Add('AudioFilePromptId', $Prompt.AudioFilePrompt.Id)
                    $PSBoundParameters.Add('AudioFilePromptFileName', $Prompt.AudioFilePrompt.FileName)
                    $PSBoundParameters.Add('AudioFilePromptDownloadUri', $Prompt.AudioFilePrompt.DownloadUri)
                }
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsAutoAttendantMenuOption @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

            $output = [Microsoft.Rtc.Management.Hosted.OAA.Models.MenuOption]::new()
            $output.ParseFrom($internalOutput)

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Base64 encode the content for the audio file

function New-CsAutoAttendantPrompt {
    [CmdletBinding(PositionalBinding=$true, DefaultParameterSetName='TextToSpeechParamSet')]
    param(
        [Parameter(Mandatory=$true, position=0, ParameterSetName="DualParamSet")]
        [System.String]
        # The ActiveType parameter identifies the active type (modality) of the AA prompt. 
        ${ActiveType},

        [Parameter(Mandatory=$true, position=0, ParameterSetName="AudioFileParamSet")]
        [Parameter(Mandatory=$false, position=1, ParameterSetName="DualParamSet")]
        [Microsoft.Rtc.Management.Hosted.Online.Models.AudioFile]
        # The AudioFilePrompt parameter represents the audio to play when the prompt is activated (rendered).
        ${AudioFilePrompt},

        [Parameter(Mandatory=$true, position=0, ParameterSetName="TextToSpeechParamSet")]
        [Parameter(Mandatory=$false, position=2, ParameterSetName="DualParamSet")]
        [System.String]
        # The TextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt that is to be read when the prompt is activated.
        ${TextToSpeechPrompt},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            if ($ActiveType -eq "") {
                $PSBoundParameters.Remove("ActiveType") | Out-Null
                if ($TextToSpeechPrompt -ne "") {
                    $PSBoundParameters.Add("ActiveType", "TextToSpeech")
                } elseif ($AudioFilePrompt -ne $null) {
                    $PSBoundParameters.Add("ActiveType", "AudioFile")
                } else {
                    $PSBoundParameters.Add("ActiveType", "None")
                }
            }

            $ActiveType = "TextToSpeech"

            if ($AudioFilePrompt -ne $null) {
                $PSBoundParameters.Add('AudioFilePromptId', $AudioFilePrompt.Id)
                $PSBoundParameters.Add('AudioFilePromptFileName', $AudioFilePrompt.FileName)
                $PSBoundParameters.Add('AudioFilePromptDownloadUri', $AudioFilePrompt.DownloadUri)
                $PSBoundParameters.Remove('AudioFilePrompt') | Out-Null
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsAutoAttendantPrompt @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

            $output = [Microsoft.Rtc.Management.Hosted.OAA.Models.Prompt]::new()
            $output.ParseFrom($internalOutput)

            return $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: parsing the return result to the CallQueue object type.

function New-CsCallQueue {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The Name of the call queue to be created.
        ${Name},

        [Parameter(Mandatory=$false)]
        [System.Int16]
        # The AgentAlertTime parameter represents the time (in seconds) that a call can remain unanswered before it is automatically routed to the next agent.
        ${AgentAlertTime},

        [Parameter(Mandatory=$false)]
        [bool]
        # The AllowOptOut parameter indicates whether or not agents can opt in or opt out from taking calls from a Call Queue.
        ${AllowOptOut},

        [Parameter(Mandatory=$false)]
        [System.Guid[]]
        # The DistributionLists parameter lets you add all the members of the distribution lists to the Call Queue. This is a list of distribution list GUIDs.
        ${DistributionLists},

        [Parameter(Mandatory=$false)]
        [bool]
        # The UseDefaultMusicOnHold parameter indicates that this Call Queue uses the default music on hold.
        ${UseDefaultMusicOnHold},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The WelcomeMusicAudioFileId parameter represents the audio file to play when callers are connected with the Call Queue.
        ${WelcomeMusicAudioFileId},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The WelcomeTextToSpeechPrompt parameter represents the text to speech content to play when callers are connected with the Call Queue.
        ${WelcomeTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The MusicOnHoldAudioFileId parameter represents music to play when callers are placed on hold.
        ${MusicOnHoldAudioFileId},

        [Parameter(Mandatory=$false)]
        [Microsoft.Rtc.Management.Hosted.HuntGroup.Models.OverflowAction]
        # The OverflowAction parameter designates the action to take if the overflow threshold is reached.
        ${OverflowAction},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowActionTarget parameter represents the target of the overflow action.
        ${OverflowActionTarget},

        [Parameter(Mandatory=$false)]
        [System.Int16]
        # The OverflowThreshold parameter defines the number of calls that can be in the queue at any one time before the overflow action is triggered.
        ${OverflowThreshold},

        [Parameter(Mandatory=$false)]
        [Microsoft.Rtc.Management.Hosted.HuntGroup.Models.TimeoutAction]
        # The TimeoutAction parameter defines the action to take if the timeout threshold is reached.
        ${TimeoutAction},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutActionTarget represents the target of the timeout action.
        ${TimeoutActionTarget},

        [Parameter(Mandatory=$false)]
        [System.Int16]
        # The TimeoutThreshold parameter defines the time (in seconds) that a call can be in the queue before that call times out.
        ${TimeoutThreshold},

        [Parameter(Mandatory=$false)]
        [Microsoft.Rtc.Management.Hosted.HuntGroup.Models.RoutingMethod]
        # The RoutingMethod defines how agents will be called in a Call Queue.
        ${RoutingMethod},

        [Parameter(Mandatory=$false)]
        [bool]
        # The PresenceBasedRouting parameter indicates whether or not presence based routing will be applied while call being routed to Call Queue agents.
        ${PresenceBasedRouting} = $true,

        [Parameter(Mandatory=$false)]
        [bool]
        # The ConferenceMode parameter indicates whether or not Conference mode will be applied on calls for current call queue.
        ${ConferenceMode} = $true,

        [Parameter(Mandatory=$false)]
        [System.Guid[]]
        # The Users parameter lets you add agents to the Call Queue.
        ${Users},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The LanguageId parameter indicates the language that is used to play shared voicemail prompts.
        ${LanguageId},

        [Parameter(Mandatory=$false)]
        [System.String]
        # This parameter is reserved for Microsoft internal use only.
        ${LineUri},

        [Parameter(Mandatory=$false)]
        [System.Guid[]]
        # The OboResourceAccountIds parameter lets you add resource account with phone number to the Call Queue.
        ${OboResourceAccountIds},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowSharedVoicemailTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when transferred to shared voicemail on overflow.
        ${OverflowSharedVoicemailTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowSharedVoicemailAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when transferred to shared voicemail on overflow.
        ${OverflowSharedVoicemailAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [bool]
        # The EnableOverflowSharedVoicemailTranscription parameter is used to turn on transcription for voicemails left by a caller on overflow.
        ${EnableOverflowSharedVoicemailTranscription},

        [Parameter(Mandatory=$false)]
        [bool]
        # The EnableOverflowSharedVoicemailSystemPromptSuppression parameter is used to disable voicemail system message on overflow.
        ${EnableOverflowSharedVoicemailSystemPromptSuppression},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowDisconnectAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is disconnected due to overflow.
        ${OverflowDisconnectAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowDisconnectTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is disconnected due to overflow.
        ${OverflowDisconnectTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowRedirectPersonAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to person on overflow.
        ${OverflowRedirectPersonAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowRedirectPersonTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to person on overflow.
        ${OverflowRedirectPersonTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowRedirectVoiceAppAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to VoiceApp on overflow.
        ${OverflowRedirectVoiceAppAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowRedirectVoiceAppTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to VoiceApp on overflow.
        ${OverflowRedirectVoiceAppTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowRedirectPhoneNumberAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to PhoneNumber on overflow.
        ${OverflowRedirectPhoneNumberAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowRedirectPhoneNumberTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to PhoneNumber on overflow.
        ${OverflowRedirectPhoneNumberTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowRedirectVoicemailAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to Voicemail on overflow.
        ${OverflowRedirectVoicemailAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowRedirectVoicemailTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to Voicemail on overflow.
        ${OverflowRedirectVoicemailTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutSharedVoicemailTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when transferred to shared voicemail on timeout.
        ${TimeoutSharedVoicemailTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutSharedVoicemailAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when transferred to shared voicemail on timeout.
        ${TimeoutSharedVoicemailAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [bool]
        # The EnableTimeoutSharedVoicemailTranscription parameter is used to turn on transcription for voicemails left by a caller on timeout.
        ${EnableTimeoutSharedVoicemailTranscription},

        [Parameter(Mandatory=$false)]
        [bool]
        # The EnableTimeoutSharedVoicemailSystemPromptSuppression parameter is used to disable voicemail system message on timeout.
        ${EnableTimeoutSharedVoicemailSystemPromptSuppression},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutDisconnectAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is disconnected due to Timeout.
        ${TimeoutDisconnectAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutDisconnectTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is disconnected due to Timeout.
        ${TimeoutDisconnectTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutRedirectPersonAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to person on Timeout.
        ${TimeoutRedirectPersonAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutRedirectPersonTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to person on Timeout.
        ${TimeoutRedirectPersonTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutRedirectVoiceAppAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to VoiceApp on Timeout.
        ${TimeoutRedirectVoiceAppAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutRedirectVoiceAppTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to VoiceApp on Timeout.
        ${TimeoutRedirectVoiceAppTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutRedirectPhoneNumberAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to PhoneNumber on Timeout.
        ${TimeoutRedirectPhoneNumberAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutRedirectPhoneNumberTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to PhoneNumber on Timeout.
        ${TimeoutRedirectPhoneNumberTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutRedirectVoicemailAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to Voicemail on Timeout.
        ${TimeoutRedirectVoicemailAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutRedirectVoicemailTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to Voicemail on Timeout.
        ${TimeoutRedirectVoicemailTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentDisconnectAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is disconnected due to NoAgent.
        ${NoAgentDisconnectAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentDisconnectTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is disconnected due to NoAgent.
        ${NoAgentDisconnectTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentRedirectPersonAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to person on NoAgent.
        ${NoAgentRedirectPersonAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentRedirectPersonTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to person on NoAgent.
        ${NoAgentRedirectPersonTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentRedirectVoiceAppAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to VoiceApp on NoAgent.
        ${NoAgentRedirectVoiceAppAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentRedirectVoiceAppTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to VoiceApp on NoAgent.
        ${NoAgentRedirectVoiceAppTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentRedirectPhoneNumberAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to PhoneNumber on NoAgent.
        ${NoAgentRedirectPhoneNumberAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentRedirectPhoneNumberTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to PhoneNumber on NoAgent.
        ${NoAgentRedirectPhoneNumberTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentRedirectVoicemailAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to Voicemail on NoAgent.
        ${NoAgentRedirectVoicemailAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentRedirectVoicemailTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to Voicemail on NoAgent.
        ${NoAgentRedirectVoicemailTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # Id of the channel to connect a call queue to.
        ${ChannelId},

        [Parameter(Mandatory=$false)]
        [System.Guid]
        # Guid should contain 32 digits with 4 dashes (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx).
        ${ChannelUserObjectId},

        [Parameter(Mandatory=$false)]
        [bool]
        # The ShouldOverwriteCallableChannelProperty indicates user intention to whether overwirte the current callableChannel property value on chat service or not.
        ${ShouldOverwriteCallableChannelProperty},

        [Parameter(Mandatory=$false)]
        [System.Guid[]]
        # The list of authorized users.
        ${AuthorizedUsers},

        [Parameter(Mandatory=$false)]
        [System.Guid[]]
        # The list of hidden authorized users.
        ${HideAuthorizedUsers},

        [Parameter(Mandatory=$false)]
        [Switch]
        # Allow the cmdlet to run anyway
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            if ($PSBoundParameters.ContainsKey('Force')) {
                $PSBoundParameters.Remove('Force') | Out-Null
            }

            if ($PSBoundParameters.ContainsKey('LineUri')) {
                # Stick with the current TRPS cmdlet policy of silently ignoring the LineUri. Later, we need to remove this param from
                # TRPS and ConfigAPI based cmdlets. Public facing document must be updated as well.
                $PSBoundParameters.Remove('LineUri') | Out-Null
            }

            #Setting PresenceAwareRouting to $false when LongestIdle is enabled as RoutingMethod
            #Since having both conditions enabled is not supported in backend service.
            if($RoutingMethod -eq 'LongestIdle') {
                $PresenceBasedRouting = $false
                $PSBoundParameters.Add('PresenceAwareRouting', $PresenceBasedRouting)
                $PSBoundParameters.Remove('PresenceBasedRouting') | Out-Null
            }
            elseif ( $PSBoundParameters.ContainsKey('PresenceBasedRouting')) {
                    $PSBoundParameters.Add('PresenceAwareRouting', $PresenceBasedRouting)
                    $PSBoundParameters.Remove('PresenceBasedRouting') | Out-Null
            }

            if ($ChannelId -ne '') {
                $PSBoundParameters.Add('ThreadId', $ChannelId)
                $PSBoundParameters.Remove('ChannelId') | Out-Null
            }

            $result = Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsCallQueue @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($result -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($result.Diagnostic)

            $output = [Microsoft.Rtc.Management.Hosted.CallQueue.Models.CallQueue]::new()
            $output.ParseFrom($result.CallQueue)

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Format output of the cmdlet

function New-CsOnlineApplicationInstanceAssociation {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String[]]
        # The Identities parameter is the identities of application instances to be associated with the provided configuration ID.
        ${Identities},

        [Parameter(Mandatory=$true, position=1)]
        [System.String]
        # The ConfigurationId parameter is the identity of the configuration that would be associatied with the provided application instances.
        ${ConfigurationId},

        [Parameter(Mandatory=$true, position=2)]
        [System.String]
        # The ConfigurationType parameter denotes the type of the configuration that would be associated with the provided application instances.
        ${ConfigurationType},

        [Parameter(Mandatory=$false, position=3)]
        [Switch]
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            # We want to flight our cmdlet if Force param is passed, but AutoRest doesn't support Force param.
            # Force param doesn't seem to do anything, so remove it if it's passed.
            if ($PSBoundParameters.ContainsKey('Force')) {
                $PSBoundParameters.Remove('Force') | Out-Null
            }

            $internalOutputs = Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsOnlineApplicationInstanceAssociation @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutputs -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutputs.Diagnostic)
        
            $output = [Microsoft.Rtc.Management.Hosted.Online.Models.AssociationOperationOutput]::new()
            $output.ParseFrom($internalOutputs)

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: transforming the return result to the custom object

function New-CsOnlineDateTimeRange {
    [CmdletBinding(PositionalBinding=$true, SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The Start parameter represents the start bound of the date-time range.
        ${Start},

        [Parameter(Mandatory=$false, position=1)]
        [System.String]
        # The End parameter represents the end bound of the date-time range.
        ${End},

        [Parameter(Mandatory=$false, position=2)]
        [Switch]
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            if ($PSBoundParameters.ContainsKey("Force")) {
                $PSBoundParameters.Remove("Force") | Out-Null
            }

            $result = Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsOnlineDateTimeRange @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($result -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($result.Diagnostic)
            $output = [Microsoft.Rtc.Management.Hosted.Online.Models.DateTimeRange]::new()
            $output.ParseFrom($result)

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: assign parameters' values and customize output

function New-CsOnlineSchedule {
    [CmdletBinding(DefaultParameterSetName="UnresolvedParamSet", SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [System.String]
        # The name of the schedule which is created.
        ${Name},

        [Parameter(Mandatory=$true, ParameterSetName = "FixedScheduleParamSet")]
        [switch]
        # The FixedSchedule parameter indicates that a fixed schedule is to be created.
        ${FixedSchedule},

        [Parameter(Mandatory=$false, ParameterSetName = "FixedScheduleParamSet")]
        # List of date-time ranges for a fixed schedule.
        ${DateTimeRanges},

        [Parameter(Mandatory=$true, ParameterSetName = "WeeklyRecurrentScheduleParamSet")]
        [switch]
        # The WeeklyRecurrentSchedule parameter indicates that a weekly recurrent schedule is to be created.
        ${WeeklyRecurrentSchedule},

        [Parameter(Mandatory=$false, ParameterSetName = "WeeklyRecurrentScheduleParamSet")]
        # List of time ranges for Monday.
        ${MondayHours},

        [Parameter(Mandatory=$false, ParameterSetName = "WeeklyRecurrentScheduleParamSet")]
        # List of time ranges for Tuesday.
        ${TuesdayHours},

        [Parameter(Mandatory=$false, ParameterSetName = "WeeklyRecurrentScheduleParamSet")]
        # List of time ranges for Wednesday.
        ${WednesdayHours},

        [Parameter(Mandatory=$false, ParameterSetName = "WeeklyRecurrentScheduleParamSet")]
        # List of time ranges for Thursday.
        ${ThursdayHours},

        [Parameter(Mandatory=$false, ParameterSetName = "WeeklyRecurrentScheduleParamSet")]
        # List of time ranges for Friday.
        ${FridayHours},

        [Parameter(Mandatory=$false, ParameterSetName = "WeeklyRecurrentScheduleParamSet")]
        # List of time ranges for Saturday.
        ${SaturdayHours},

        [Parameter(Mandatory=$false, ParameterSetName = "WeeklyRecurrentScheduleParamSet")]
        # List of time ranges for Sunday.
        ${SundayHours},

        [Parameter(Mandatory=$false, ParameterSetName = "WeeklyRecurrentScheduleParamSet")]
        [switch]
        # The flag for Complement enabled or not
        ${Complement},

        [Parameter(Mandatory=$false)]
        [Switch]
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            if ($PSBoundParameters.ContainsKey("Force")) {
                $PSBoundParameters.Remove("Force") | Out-Null
            }

            $dateTimeRangeStandardFormat = 'yyyy-MM-ddTHH:mm:ss';

            # Get common parameters
            $params = @{}
            foreach($p in $PSBoundParameters.GetEnumerator())
            {
                $params += @{$p.Key = $p.Value}
            }
            $null = $params.Remove("FixedSchedule")
            $null = $params.Remove("DateTimeRanges")
            $null = $params.Remove("WeeklyRecurrentSchedule")
            $null = $params.Remove("MondayHours")
            $null = $params.Remove("TuesdayHours")
            $null = $params.Remove("WednesdayHours")
            $null = $params.Remove("ThursdayHours")
            $null = $params.Remove("FridayHours")
            $null = $params.Remove("SaturdayHours")
            $null = $params.Remove("SundayHours")
            $null = $params.Remove("Complement")


            if ($PsCmdlet.ParameterSetName -eq "UnresolvedParamSet") {
                throw "A schedule type must be specified. Please use -WeeklyRecurrentSchedule or -FixedSchedule parameters to create the appropriate type of schedule."
            }

            if ($PsCmdlet.ParameterSetName -eq "FixedScheduleParamSet") {
                $fixedScheduleDateTimeRanges = @()
                foreach ($dateTimeRange in $DateTimeRanges) {
                    $fixedScheduleDateTimeRanges += @{
                        Start = $dateTimeRange.Start.ToString($dateTimeRangeStandardFormat, [System.Globalization.CultureInfo]::InvariantCulture)
                        End = $dateTimeRange.End.ToString($dateTimeRangeStandardFormat, [System.Globalization.CultureInfo]::InvariantCulture)
                    }
                }
                $params['FixedScheduleDateTimeRange'] = $fixedScheduleDateTimeRanges
            }

            if ($PsCmdlet.ParameterSetName -eq "WeeklyRecurrentScheduleParamSet") {
                if ($MondayHours -ne $null -and $MondayHours.Length -gt 0) {
                    $params['WeeklyRecurrentScheduleMondayHour'] = @()
                    foreach ($mondayHour in $MondayHours){
                        $params['WeeklyRecurrentScheduleMondayHour'] += @{
                            Start = $mondayHour.Start
                            End = $mondayHour.End
                        }
                    }
                }
                if ($TuesdayHours -ne $null -and $TuesdayHours.Length -gt 0) {
                    $params['WeeklyRecurrentScheduleTuesdayHour'] = @()
                    foreach ($tuesdayHour in $TuesdayHours){
                        $params['WeeklyRecurrentScheduleTuesdayHour'] += @{
                            Start = $tuesdayHour.Start
                            End = $tuesdayHour.End
                        }
                    }
                }
                if ($WednesdayHours -ne $null -and $WednesdayHours.Length -gt 0) {
                    $params['WeeklyRecurrentScheduleWednesdayHour'] = @()
                    foreach ($wednesdayHour in $WednesdayHours){
                        $params['WeeklyRecurrentScheduleWednesdayHour'] += @{
                            Start = $wednesdayHour.Start
                            End = $wednesdayHour.End
                        }
                    }    
                }
                if ($ThursdayHours -ne $null -and $ThursdayHours.Length -gt 0) {
                    $params['WeeklyRecurrentScheduleThursdayHour'] = @()
                        foreach ($thursdayHour in $ThursdayHours){
                            $params['WeeklyRecurrentScheduleThursdayHour'] += @{
                                Start = $thursdayHour.Start
                                End = $thursdayHour.End
                        }
                    }
                }
                if ($FridayHours -ne $null -and $FridayHours.Length -gt 0) {
                    $params['WeeklyRecurrentScheduleFridayHour'] = @()
                    foreach ($fridayHour in $FridayHours){
                        $params['WeeklyRecurrentScheduleFridayHour'] += @{
                            Start = $fridayHour.Start
                            End = $fridayHour.End
                        }
                    }
                }
                if ($SaturdayHours -ne $null -and $SaturdayHours.Length -gt 0) {
                    $params['WeeklyRecurrentScheduleSaturdayHour'] = @()
                    foreach ($saturdayHour in $SaturdayHours){
                        $params['WeeklyRecurrentScheduleSaturdayHour'] += @{
                            Start = $saturdayHour.Start
                            End = $saturdayHour.End
                        }
                    }
                }
                if ($SundayHours -ne $null -and $SundayHours.Length -gt 0) {
                    $params['WeeklyRecurrentScheduleSundayHour'] = @()
                    foreach ($sundayHour in $SundayHours){
                        $params['WeeklyRecurrentScheduleSundayHour'] += @{
                            Start = $sundayHour.Start
                            End = $sundayHour.End
                        }
                    }
                }
                if ($Complement) { $params['WeeklyRecurrentScheduleIsComplemented'] = $true }
            }

            $result = Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsOnlineSchedule @params @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($result -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($result.Diagnostic)

            $schedule = [Microsoft.Rtc.Management.Hosted.Online.Models.Schedule]::new()
            $schedule.ParseFrom($result)

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: transforming the return result to the custom object

function New-CsOnlineTimeRange {
    [CmdletBinding(PositionalBinding=$true, SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The Start parameter represents the start bound of the time range.
        ${Start},

        [Parameter(Mandatory=$true, position=1)]
        [System.String]
        # The End parameter represents the end bound of the time range.
        ${End},

        [Parameter(Mandatory=$false, position=2)]
        [Switch]
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            if ($PSBoundParameters.ContainsKey("Force")) {
                $PSBoundParameters.Remove("Force") | Out-Null
            }

            $result = Microsoft.Teams.ConfigAPI.Cmdlets.internal\New-CsOnlineTimeRange @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($result -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($result.Diagnostic)
            $output = [Microsoft.Rtc.Management.Hosted.Online.Models.TimeRange]::new()
            $output.ParseFrom($result)

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Display the diagnostic if any

function Remove-CsAutoAttendant {
    [CmdletBinding(PositionalBinding=$true, SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The identity for the AA to be removed.
        ${Identity},

        [Parameter(Mandatory=$false, position=1)]
        [Switch]
        # The Force parameter indicates if we force the action to be performed. (Deprecated)
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Remove("Force")

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Remove-CsAutoAttendant @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: print out the diagnostics

function Remove-CsCallQueue {
    [CmdletBinding(PositionalBinding=$true, SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The identifier of the call queue to be removed.
        ${Identity},

        [Parameter(Mandatory=$false)]
        [Switch]
        # Allow the cmdlet to run anyway
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to Stop
            if (!$PSBoundParameters.ContainsKey('ErrorAction')) {
                $PSBoundParameters.Add('ErrorAction', 'Stop')
            }

            if ($PSBoundParameters.ContainsKey('Force')) {
                $PSBoundParameters.Remove('Force') | Out-Null
            }

            # Get the CallQueue to be deleted by Identity.
            $getParams = @{Identity = $Identity; FilterInvalidObos = $false}
            $getResult = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsCallQueue @getParams -ErrorAction Stop @httpPipelineArgs

            $result = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Remove-CsCallQueue @PSBoundParameters @httpPipelineArgs
            Write-AdminServiceDiagnostic($result.Diagnostics)

            # Convert the fecthed CallQueue DTO to domain model and print.
            $deletedCallQueue= [Microsoft.Rtc.Management.Hosted.CallQueue.Models.CallQueue]::new()
            $deletedCallQueue.ParseFrom($getResult.CallQueue)

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Format output of the cmdlet

function Remove-CsOnlineApplicationInstanceAssociation {
    [CmdletBinding(PositionalBinding=$true, SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String[]]
        # The Identity parameter is the identity of application instances to be associated with the provided configuration ID.
        ${Identities},

        [Parameter(Mandatory=$false, position=1)]
        [Switch]
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            # We want to flight our cmdlet if Force param is passed, but AutoRest doesn't support Force param.
            # Force param doesn't seem to do anything, so remove it if it's passed.
            if ($PSBoundParameters.ContainsKey('Force')) {
                $PSBoundParameters.Remove('Force') | Out-Null
            }

            # Get the array of Identities, and remove parameter 'Identities',
            # since api internal\Remove-CsOnlineApplicationInstanceAssociation takes only param 'Identity' as a string,
            # so need send a request for each identity (endpointId) by looping through all Identities.
            $endpointIdArr = @()

            if ($PSBoundParameters.ContainsKey('Identities')) {
                $endpointIdArr = $PSBoundParameters['Identities']
                $PSBoundParameters.Remove('Identities') | Out-Null
            }

            # Sends request for each identity (endpointId)
            foreach ($endpointId in $endpointIdArr) {
                # Encode the "endpointID" if it is a SIP URI (aka User Principle Name (UPN))
                $identity  = EncodeSipUri($endpointId)
                $PSBoundParameters.Add('Identity', $identity)

                $internalOutputs = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Remove-CsOnlineApplicationInstanceAssociation @PSBoundParameters @httpPipelineArgs
                $PSBoundParameters.Remove('Identity') | Out-Null

                # Stop execution if internal cmdlet is failing
                if ($internalOutputs -eq $null) {
                    return $null
                }

                Write-AdminServiceDiagnostic($internalOutputs.Diagnostic)

                $output = [Microsoft.Rtc.Management.Hosted.Online.Models.AssociationOperationOutput]::new()
                $output.ParseFrom($internalOutputs)

                $output
            }

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Add default App ID for Remove-CsOnlineAudioFile

function Remove-CsOnlineAudioFile {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The Identity parameter is the identifier for the audio file.
        ${Identity},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Remove("ApplicationId")
            $PSBoundParameters.Add("ApplicationId", "TenantGlobal")

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Remove-CsOnlineAudioFile @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            $internalOutput

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: print out the diagnostic

function Remove-CsOnlineSchedule {
    [CmdletBinding(PositionalBinding=$true, SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The identifier of the schedule to be removed.
        ${Id},

        [Parameter(Mandatory=$false, position=1)]
        [Switch]
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            if ($PSBoundParameters.ContainsKey("Force")) {
                $PSBoundParameters.Remove("Force") | Out-Null
            }

            $result = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Remove-CsOnlineSchedule @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($result -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($result.Diagnostic)
            $result

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Format output of cmdlet

function Set-CsAutoAttendant {
    [CmdletBinding(PositionalBinding=$true, SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [PSObject]
        # The Instance parameter is the object reference to the AA to be modified.
        ${Instance},

        [Parameter(Mandatory=$false, position=1)]
        [Switch]
        # The Force parameter indicates if we force the action to be performed. (Deprecated)
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Remove("Force")

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            # Get common parameters
            $PSBoundCommonParameters = @{}
            foreach($p in $PSBoundParameters.GetEnumerator())
            {
                $PSBoundCommonParameters += @{$p.Key = $p.Value}
            }
            $null = $PSBoundCommonParameters.Remove("Instance")
            $null = $PSBoundCommonParameters.Remove("WhatIf")
            $null = $PSBoundCommonParameters.Remove("Confirm")

            $null = $PSBoundParameters.Remove('Instance')
            if ($Instance.Identity -ne $null) {
                $PSBoundParameters.Add('Identity', $Instance.Identity)
            }
            if ($Instance.Id -ne $null) {
                $PSBoundParameters.Add('Id', $Instance.Id)
            }
            if ($Instance.Name -ne $null) {
                $PSBoundParameters.Add('Name', $Instance.Name)
            }
            if ($Instance.LanguageId -ne $null) {
                $PSBoundParameters.Add('LanguageId', $Instance.LanguageId)
            }
            if ($Instance.TimeZoneId -ne $null) {
                $PSBoundParameters.Add('TimeZoneId', $Instance.TimeZoneId)
            }
            if ($Instance.TenantId -ne $null) {
                $PSBoundParameters.Add('TenantId', $Instance.TenantId.ToString())
            }
            if ($Instance.VoiceId -ne $null) {
                $PSBoundParameters.Add('VoiceId', $Instance.VoiceId)
            }
            if ($Instance.DialByNameResourceId -ne $null) {
                $PSBoundParameters.Add('DialByNameResourceId', $Instance.DialByNameResourceId)
            }
            if ($Instance.ApplicationInstances -ne $null) {
                $PSBoundParameters.Add('ApplicationInstance', $Instance.ApplicationInstances)
            }
            if ($Instance.VoiceResponseEnabled -eq $true) {
                $PSBoundParameters.Add('VoiceResponseEnabled', $true)
            }
            if ($Instance.DefaultCallFlow -ne $null) {
                $PSBoundParameters.Add('DefaultCallFlowId', $Instance.DefaultCallFlow.Id)
                $PSBoundParameters.Add('DefaultCallFlowName', $Instance.DefaultCallFlow.Name)
                $defaultCallFlowGreetings = @()
                if ($Instance.DefaultCallFlow.Greetings -ne $null) {
                    foreach ($defaultCallFlowGreeting in $Instance.DefaultCallFlow.Greetings) {
                        $defaultCallFlowGreetings += [Microsoft.Rtc.Management.Hosted.OAA.Models.Prompt]::CreateAutoGeneratedFromObject($defaultCallFlowGreeting)
                    }
                    $PSBoundParameters.Add('DefaultCallFlowGreeting', $defaultCallFlowGreetings)
                }
                if ($Instance.DefaultCallFlow.ForceListenMenuEnabled -eq $true) {
                    $PSBoundParameters.Add('ForceListenMenuEnabled', $true)
                }
                if ($Instance.DefaultCallFlow.Menu -ne $null) {
                    $PSBoundParameters.Add('MenuDialByNameEnabled', $Instance.DefaultCallFlow.Menu.DialByNameEnabled)
                    $PSBoundParameters.Add('MenuDirectorySearchMethod', $Instance.DefaultCallFlow.Menu.DirectorySearchMethod.ToString())
                    $PSBoundParameters.Add('MenuName', $Instance.DefaultCallFlow.Menu.Name)
                    if ($Instance.DefaultCallFlow.Menu.MenuOptions -ne $null) {
                        $defaultCallFlowMenuOptions = @()
                        foreach($defaultCallFlowMenuOption in $Instance.DefaultCallFlow.Menu.MenuOptions) {
                            $defaultCallFlowMenuOptions += [Microsoft.Rtc.Management.Hosted.OAA.Models.MenuOption]::CreateAutoGeneratedFromObject($defaultCallFlowMenuOption)
                        }
                        $PSBoundParameters.Add('MenuOption', $defaultCallFlowMenuOptions)
                    }
                    if ($Instance.DefaultCallFlow.Menu.Prompts -ne $null) {
                        $defaultCallFlowMenuPrompts = @()
                        foreach($defaultCallFlowMenuPrompt in $Instance.DefaultCallFlow.Menu.Prompts) {
                            $defaultCallFlowMenuPrompts += [Microsoft.Rtc.Management.Hosted.OAA.Models.Prompt]::CreateAutoGeneratedFromObject($defaultCallFlowMenuPrompt)
                        }
                        $PSBoundParameters.Add('MenuPrompt', $defaultCallFlowMenuPrompts)
                    }
                }
            }
            if ($Instance.DirectoryLookupScope -ne $null) {
                if ($Instance.DirectoryLookupScope.InclusionScope -ne $null) {
                    $PSBoundParameters.Add('InclusionScopeType', $Instance.DirectoryLookupScope.InclusionScope.Type.ToString())
                    if ($Instance.DirectoryLookupScope.InclusionScope.GroupScope -ne $null) {
                        $PSBoundParameters.Add('InclusionScopeGroupDialScopeGroupId', $Instance.DirectoryLookupScope.InclusionScope.GroupScope.GroupIds)
                    }
                } else {
                    $PSBoundParameters.Add('InclusionScopeType', "Default")
                }
                if ($Instance.DirectoryLookupScope.ExclusionScope -ne $null) {
                    $PSBoundParameters.Add('ExclusionScopeType', $Instance.DirectoryLookupScope.ExclusionScope.Type.ToString())
                    if ($Instance.DirectoryLookupScope.ExclusionScope.GroupScope -ne $null) {
                        $PSBoundParameters.Add('ExclusionScopeGroupDialScopeGroupId', $Instance.DirectoryLookupScope.ExclusionScope.GroupScope.GroupIds)
                    }
                } else {
                    $PSBoundParameters.Add('ExclusionScopeType', "Default")
                }
            }
            if ($Instance.Operator -ne $null) {
                if ($Instance.Operator.EnableTranscription -eq $true) {
                    $PSBoundParameters.Add('OperatorEnableTranscription', $true)
                }
                $PSBoundParameters.Add('OperatorId', $Instance.Operator.Id)
                $PSBoundParameters.Add('OperatorType', $Instance.Operator.Type.ToString())
            }
            if ($Instance.CallFlows -ne $null) {
                $callFlows = @()
                foreach ($callFlow in $Instance.CallFlows) {
                    $generatedCallFlow = [Microsoft.Rtc.Management.Hosted.OAA.Models.CallFlow]::CreateAutoGeneratedFromObject($callFlow)

                    if ($callFlow.Greetings -ne $null) {
                        $inputGreetings = @()
                        foreach ($greeting in $callFlow.Greetings) {
                            $inputGreetings += [Microsoft.Rtc.Management.Hosted.OAA.Models.Prompt]::CreateAutoGeneratedFromObject($greeting)
                        }
                        $generatedCallFlow.Greeting = $inputGreetings
                    }
                    if ($callFlow.Menu.MenuOptions -ne $null) {
                        $menuOptions = @()
                        foreach ($menuOption in $callFlow.Menu.MenuOptions) {
                            $menuOptions += [Microsoft.Rtc.Management.Hosted.OAA.Models.MenuOption]::CreateAutoGeneratedFromObject($menuOption)
                        }
                        $generatedCallFlow.MenuOption = $menuOptions
                    }
                    if ($callFlow.Menu.Prompts -ne $null) {
                        $menuPrompts = @()
                        foreach ($menuPrompt in $callFlow.Menu.Prompts) {
                            $menuPrompts += [Microsoft.Rtc.Management.Hosted.OAA.Models.Prompt]::CreateAutoGeneratedFromObject($menuPrompt)
                        }
                        $generatedCallFlow.MenuPrompt = $menuPrompts
                    }

                    $callFlows += $generatedCallFlow
                }
                $PSBoundParameters.Add('CallFlow', $callFlows)
            }
            if ($Instance.CallHandlingAssociations -ne $null) {
                $callHandlingAssociations = @()
                foreach($callHandlingAssociation in $Instance.CallHandlingAssociations) {
                    $callHandlingAssociations += [Microsoft.Rtc.Management.Hosted.OAA.Models.CallHandlingAssociation]::CreateAutoGeneratedFromObject($callHandlingAssociation)
                }
                $PSBoundParameters.Add('CallHandlingAssociation', $callHandlingAssociations)
            }

            $PSBoundParameters.Add('AuthorizedUser', $Instance.AuthorizedUsers)
            $PSBoundParameters.Add('HideAuthorizedUser', $Instance.HideAuthorizedUsers)
        
            if ($Instance.Schedules -ne $null) {
                $schedules = @()
                foreach($schedule in $Instance.Schedules) {
                    $schedules += [Microsoft.Rtc.Management.Hosted.Online.Models.Schedule]::CreateAutoGeneratedFromObject($schedule)
                }
                $PSBoundParameters.Add('Schedule', $schedules)
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsAutoAttendant @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

            $output = [Microsoft.Rtc.Management.Hosted.OAA.Models.AutoAttendant]::new()
            $output.ParseFrom($internalOutput.AutoAttendant)

            $getCsAutoAttendantStatusParameters = @{Identity = $output.Identity}
            foreach($p in $PSBoundCommonParameters.GetEnumerator())
            {
                $getCsAutoAttendantStatusParameters += @{$p.Key = $p.Value}
            }

            $internalStatus = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsAutoAttendantStatus @getCsAutoAttendantStatusParameters @httpPipelineArgs
            $output.AmendStatus($internalStatus)

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: replacing the parameters' names.

function Set-CsCallQueue {
    [CmdletBinding(PositionalBinding=$true, SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The identity of the call queue to be updated.
        ${Identity},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The Name of the call queue to be updated.
        ${Name},

        [Parameter(Mandatory=$false)]
        [System.Int16]
        # The AgentAlertTime parameter represents the time (in seconds) that a call can remain unanswered before it is automatically routed to the next agent.
        ${AgentAlertTime},

        [Parameter(Mandatory=$false)]
        [bool]
        # The AllowOptOut parameter indicates whether or not agents can opt in or opt out from taking calls from a Call Queue.
        ${AllowOptOut},

        [Parameter(Mandatory=$false)]
        [System.Guid[]]
        # The DistributionLists parameter lets you add all the members of the distribution lists to the Call Queue. This is a list of distribution list GUIDs.
        ${DistributionLists},

        [Parameter(Mandatory=$false)]
        [bool]
        # The UseDefaultMusicOnHold parameter indicates that this Call Queue uses the default music on hold.
        ${UseDefaultMusicOnHold},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The WelcomeMusicAudioFileId parameter represents the audio file to play when callers are connected with the Call Queue.
        ${WelcomeMusicAudioFileId},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The WelcomeTextToSpeechPrompt parameter represents the text to speech content to play when callers are connected with the Call Queue.
        ${WelcomeTextToSpeechPrompt},
        
        [Parameter(Mandatory=$false)]
        [System.String]
        # The MusicOnHoldAudioFileId parameter represents music to play when callers are placed on hold.
        ${MusicOnHoldAudioFileId},

        [Parameter(Mandatory=$false)]
        [Microsoft.Rtc.Management.Hosted.HuntGroup.Models.OverflowAction]
        # The OverflowAction parameter designates the action to take if the overflow threshold is reached.
        ${OverflowAction},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowActionTarget parameter represents the target of the overflow action.
        ${OverflowActionTarget},

        [Parameter(Mandatory=$false)]
        [System.Int16]
        # The OverflowThreshold parameter defines the number of calls that can be in the queue at any one time before the overflow action is triggered.
        ${OverflowThreshold},

        [Parameter(Mandatory=$false)]
        [Microsoft.Rtc.Management.Hosted.HuntGroup.Models.TimeoutAction]
        # The TimeoutAction parameter defines the action to take if the timeout threshold is reached.
        ${TimeoutAction},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutActionTarget represents the target of the timeout action.
        ${TimeoutActionTarget},

        [Parameter(Mandatory=$false)]
        [System.Int16]
        # The TimeoutThreshold parameter defines the time (in seconds) that a call can be in the queue before that call times out.
        ${TimeoutThreshold},

        [Parameter(Mandatory=$false)]
        [Microsoft.Rtc.Management.Hosted.HuntGroup.Models.RoutingMethod]
        # The RoutingMethod defines how agents will be called in a Call Queue.
        ${RoutingMethod},

        [Parameter(Mandatory=$false)]
        [bool]
        # The PresenceBasedRouting parameter indicates whether or not presence based routing will be applied while call being routed to Call Queue agents.
        ${PresenceBasedRouting},

        [Parameter(Mandatory=$false)]
        [bool]
        # The ConferenceMode parameter indicates whether or not Conference mode will be applied on calls for current call queue.
        ${ConferenceMode},

        [Parameter(Mandatory=$false)]
        [System.Guid[]]
        # The Users parameter lets you add agents to the Call Queue.
        ${Users},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The LanguageId parameter indicates the language that is used to play shared voicemail prompts.
        ${LanguageId},

        [Parameter(Mandatory=$false)]
        [System.String]
        # This parameter is reserved for Microsoft internal use only.
        ${LineUri},

        [Parameter(Mandatory=$false)]
        [System.Guid[]]
        # The OboResourceAccountIds parameter lets you add resource account with phone number to the Call Queue.
        ${OboResourceAccountIds},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowSharedVoicemailTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when transferred to shared voicemail on overflow.
        ${OverflowSharedVoicemailTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowSharedVoicemailAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when transferred to shared voicemail on overflow.
        ${OverflowSharedVoicemailAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [bool]
        # The EnableOverflowSharedVoicemailTranscription parameter is used to turn on transcription for voicemails left by a caller on overflow.
        ${EnableOverflowSharedVoicemailTranscription},

        [Parameter(Mandatory=$false)]
        [bool]
        # The EnableOverflowSharedVoicemailSystemPromptSuppression parameter is used to disable voicemail system message on overflow.
        ${EnableOverflowSharedVoicemailSystemPromptSuppression},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowDisconnectAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is disconnected due to overflow.
        ${OverflowDisconnectAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowDisconnectTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is disconnected due to overflow.
        ${OverflowDisconnectTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowRedirectPersonAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to person on overflow.
        ${OverflowRedirectPersonAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowRedirectPersonTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to person on overflow.
        ${OverflowRedirectPersonTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowRedirectVoiceAppAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to VoiceApp on overflow.
        ${OverflowRedirectVoiceAppAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowRedirectVoiceAppTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to VoiceApp on overflow.
        ${OverflowRedirectVoiceAppTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowRedirectPhoneNumberAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to PhoneNumber on overflow.
        ${OverflowRedirectPhoneNumberAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowRedirectPhoneNumberTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to PhoneNumber on overflow.
        ${OverflowRedirectPhoneNumberTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowRedirectVoicemailAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to Voicemail on overflow.
        ${OverflowRedirectVoicemailAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The OverflowRedirectVoicemailTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to Voicemail on overflow.
        ${OverflowRedirectVoicemailTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutSharedVoicemailTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when transferred to shared voicemail on timeout.
        ${TimeoutSharedVoicemailTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutSharedVoicemailAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when transferred to shared voicemail on timeout.
        ${TimeoutSharedVoicemailAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [bool]
        # The EnableTimeoutSharedVoicemailTranscription parameter is used to turn on transcription for voicemails left by a caller on timeout.
        ${EnableTimeoutSharedVoicemailTranscription},

        [Parameter(Mandatory=$false)]
        [bool]
        # The EnableTimeoutSharedVoicemailSystemPromptSuppression parameter is used to disable voicemail system message on timeout.
        ${EnableTimeoutSharedVoicemailSystemPromptSuppression},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutDisconnectAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is disconnected due to Timeout.
        ${TimeoutDisconnectAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutDisconnectTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is disconnected due to Timeout.
        ${TimeoutDisconnectTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutRedirectPersonAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to person on Timeout.
        ${TimeoutRedirectPersonAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutRedirectPersonTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to person on Timeout.
        ${TimeoutRedirectPersonTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutRedirectVoiceAppAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to VoiceApp on Timeout.
        ${TimeoutRedirectVoiceAppAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutRedirectVoiceAppTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to VoiceApp on Timeout.
        ${TimeoutRedirectVoiceAppTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutRedirectPhoneNumberAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to PhoneNumber on Timeout.
        ${TimeoutRedirectPhoneNumberAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutRedirectPhoneNumberTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to PhoneNumber on Timeout.
        ${TimeoutRedirectPhoneNumberTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutRedirectVoicemailAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to Voicemail on Timeout.
        ${TimeoutRedirectVoicemailAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The TimeoutRedirectVoicemailTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to Voicemail on Timeout.
        ${TimeoutRedirectVoicemailTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentDisconnectAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is disconnected due to NoAgent.
        ${NoAgentDisconnectAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentDisconnectTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is disconnected due to NoAgent.
        ${NoAgentDisconnectTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentRedirectPersonAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to person on NoAgent.
        ${NoAgentRedirectPersonAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentRedirectPersonTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to person on NoAgent.
        ${NoAgentRedirectPersonTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentRedirectVoiceAppAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to VoiceApp on NoAgent.
        ${NoAgentRedirectVoiceAppAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentRedirectVoiceAppTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to VoiceApp on NoAgent.
        ${NoAgentRedirectVoiceAppTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentRedirectPhoneNumberAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to PhoneNumber on NoAgent.
        ${NoAgentRedirectPhoneNumberAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentRedirectPhoneNumberTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to PhoneNumber on NoAgent.
        ${NoAgentRedirectPhoneNumberTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentRedirectVoicemailAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when call is redirected to Voicemail on NoAgent.
        ${NoAgentRedirectVoicemailAudioFilePrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # The NoAgentRedirectVoicemailTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when call is redirected to Voicemail on NoAgent.
        ${NoAgentRedirectVoicemailTextToSpeechPrompt},

        [Parameter(Mandatory=$false)]
        [System.String]
        # Id of the channel to connect a call queue to.
        ${ChannelId},

        [Parameter(Mandatory=$false)]
        [System.Guid]
        # Guid should contain 32 digits with 4 dashes (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx).
        ${ChannelUserObjectId},

        [Parameter(Mandatory=$false)]
        [bool]
        # The ShouldOverwriteCallableChannelProperty indicates user intention to whether overwirte the current callableChannel property value on chat service or not.
        ${ShouldOverwriteCallableChannelProperty},

        [Parameter(Mandatory=$false)]
        [System.Guid[]]
        # The list of authorized users.
        ${AuthorizedUsers},

        [Parameter(Mandatory=$false)]
        [System.Guid[]]
        # The list of hidden authorized users.
        ${HideAuthorizedUsers},

        [Parameter(Mandatory=$false)]
        [Switch]
        # Allow the cmdlet to run anyway
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to Stop
            if (!$PSBoundParameters.ContainsKey('ErrorAction')) {
                $PSBoundParameters.Add('ErrorAction', 'Stop')
            }

            if ($PSBoundParameters.ContainsKey('Force')) {
                $PSBoundParameters.Remove('Force') | Out-Null
            }

            # Get the existing CallQueue by Identity.
            $getParams = @{Identity = $Identity; FilterInvalidObos = $false}
            $getResult = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsCallQueue @getParams -ErrorAction Stop @httpPipelineArgs

            # Convert the existing CallQueue DTO to domain model.
            $existingCallQueue= [Microsoft.Rtc.Management.Hosted.CallQueue.Models.CallQueue]::new()
            $existingCallQueue.ParseFrom($getResult.CallQueue) | Out-Null

            # Take the delta from the existing CallQueue and apply it to the param hasthable to form
            # an appropriate DTO model for the CallQueue PUT API. FYI, CallQueue PUT API is very much
            # different from its AA counterpart which accepts params/properties to be updated only.

            # Param hashtable modification begins.
            if ($PSBoundParameters.ContainsKey('LineUri')) {
                # Stick with the current TRPS cmdlet policy of silently ignoring the LineUri. Later, we
                # need to remove this param from TRPS and ConfigAPI based cmdlets. Public facing document
                # must be updated as well.
                $PSBoundParameters.Remove('LineUri') | Out-Null
            }

            if (!$PSBoundParameters.ContainsKey('Name')) {
                $PSBoundParameters.Add('Name', $existingCallQueue.Name)
            }

            if (!$PSBoundParameters.ContainsKey('AgentAlertTime')) {
                $PSBoundParameters.Add('AgentAlertTime', $existingCallQueue.AgentAlertTime)
            }

            if ([string]::IsNullOrWhiteSpace($LanguageId) -and ![string]::IsNullOrWhiteSpace($existingCallQueue.LanguageId)) {
                $PSBoundParameters.Add('LanguageId', $existingCallQueue.LanguageId)
            }

            if (!$PSBoundParameters.ContainsKey('OverflowThreshold')) {
                $PSBoundParameters.Add('OverflowThreshold', $existingCallQueue.OverflowThreshold)
            }

            if (!$PSBoundParameters.ContainsKey('TimeoutThreshold')) {
                $PSBoundParameters.Add('TimeoutThreshold', $existingCallQueue.TimeoutThreshold)
            }

            if (!$PSBoundParameters.ContainsKey('RoutingMethod')) {
                $PSBoundParameters.Add('RoutingMethod', $existingCallQueue.RoutingMethod)
            }

            if (!$PSBoundParameters.ContainsKey('AllowOptOut') ) {
                $PSBoundParameters.Add('AllowOptOut', $existingCallQueue.AllowOptOut)
            }

            if (!$PSBoundParameters.ContainsKey('ConferenceMode')) {
                $PSBoundParameters.Add('ConferenceMode', $existingCallQueue.ConferenceMode)
            }

            if (!$PSBoundParameters.ContainsKey('PresenceBasedRouting')) {
                $PSBoundParameters.Add('PresenceAwareRouting', $existingCallQueue.PresenceBasedRouting)
            }
            else {
                $PSBoundParameters.Add('PresenceAwareRouting', $PresenceBasedRouting)
                $PSBoundParameters.Remove('PresenceBasedRouting') | Out-Null
            }

            if (!$PSBoundParameters.ContainsKey('ChannelId')) {
                if (![string]::IsNullOrWhiteSpace($existingCallQueue.ChannelId)) {
                    $PSBoundParameters.Add('ThreadId', $existingCallQueue.ChannelId)
                }
            }
            else {
                $PSBoundParameters.Add('ThreadId', $ChannelId)
                $PSBoundParameters.Remove('ChannelId') | Out-Null
            }

            if (!$PSBoundParameters.ContainsKey('OboResourceAccountIds')) {
                if ($null -ne $existingCallQueue.OboResourceAccountIds -and $existingCallQueue.OboResourceAccountIds.Length -gt 0) {
                    $PSBoundParameters.Add('OboResourceAccountIds', $existingCallQueue.OboResourceAccountIds)
                }
            }

            if (!$PSBoundParameters.ContainsKey('WelcomeMusicAudioFileId') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.WelcomeMusicResourceId)) {
                $PSBoundParameters.Add('WelcomeMusicAudioFileId', $existingCallQueue.WelcomeMusicResourceId)
            }

            if (!$PSBoundParameters.ContainsKey('MusicOnHoldAudioFileId') -and !$PSBoundParameters.ContainsKey('UseDefaultMusicOnHold')) {
                # The already persiting values cannot be conflicting as those were validated by admin service.
                if (![string]::IsNullOrWhiteSpace($existingCallQueue.MusicOnHoldResourceId)) {
                    $PSBoundParameters.Add('MusicOnHoldAudioFileId', $existingCallQueue.MusicOnHoldResourceId)
                }
                if ($null -ne $existingCallQueue.UseDefaultMusicOnHold) {
                    $PSBoundParameters.Add('UseDefaultMusicOnHold', $existingCallQueue.UseDefaultMusicOnHold)
                }
            }
            elseif ($UseDefaultMusicOnHold -eq $false -and !$PSBoundParameters.ContainsKey('MusicOnHoldAudioFileId')) {
                if (![string]::IsNullOrWhiteSpace($existingCallQueue.MusicOnHoldResourceId)) {
                    $PSBoundParameters.Add('MusicOnHoldAudioFileId', $existingCallQueue.MusicOnHoldResourceId)
                }
            }

            if (!$PSBoundParameters.ContainsKey('DistributionLists')) {
                if ($null -ne $existingCallQueue.DistributionLists -and $existingCallQueue.DistributionLists.Length -gt 0) {
                    $PSBoundParameters.Add('DistributionLists', $existingCallQueue.DistributionLists)
                }
            }

            if (!$PSBoundParameters.ContainsKey('Users')) {
                if ($null -ne $existingCallQueue.Users -and $existingCallQueue.Users.Length -gt 0) {
                    $PSBoundParameters.Add('Users', $existingCallQueue.Users)
                }
            }

            if (!$PSBoundParameters.ContainsKey('OverflowSharedVoicemailTextToSpeechPrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.OverflowSharedVoicemailTextToSpeechPrompt)) {
                $PSBoundParameters.Add('OverflowSharedVoicemailTextToSpeechPrompt', $existingCallQueue.OverflowSharedVoicemailTextToSpeechPrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('OverflowSharedVoicemailTextToSpeechPrompt') -and [string]::IsNullOrWhiteSpace($OverflowSharedVoicemailTextToSpeechPrompt)) {
                $null = $PSBoundParameters.Remove('OverflowSharedVoicemailTextToSpeechPrompt')
            }

            if (!$PSBoundParameters.ContainsKey('OverflowSharedVoicemailAudioFilePrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.OverflowSharedVoicemailAudioFilePrompt)) {
                $PSBoundParameters.Add('OverflowSharedVoicemailAudioFilePrompt', $existingCallQueue.OverflowSharedVoicemailAudioFilePrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('OverflowSharedVoicemailAudioFilePrompt') -and [string]::IsNullOrWhiteSpace($OverflowSharedVoicemailAudioFilePrompt)) {
                $null = $PSBoundParameters.Remove('OverflowSharedVoicemailAudioFilePrompt')
            }

            if (!$PSBoundParameters.ContainsKey('EnableOverflowSharedVoicemailTranscription')) {
                if ($existingCallQueue.EnableOverflowSharedVoicemailTranscription -ne $null) {
                    $PSBoundParameters.Add('EnableOverflowSharedVoicemailTranscription', $existingCallQueue.EnableOverflowSharedVoicemailTranscription)
                }
            }

            if (!$PSBoundParameters.ContainsKey('EnableOverflowSharedVoicemailSystemPromptSuppression') -and $null -ne $existingCallQueue.EnableOverflowSharedVoicemailSystemPromptSuppression) {
                $PSBoundParameters.Add('EnableOverflowSharedVoicemailSystemPromptSuppression',  $existingCallQueue.EnableOverflowSharedVoicemailSystemPromptSuppression)
            }

            if (!$PSBoundParameters.ContainsKey('OverflowActionTarget') -and !($OverflowAction -eq 'Disconnect') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.OverflowActionTargetId)) {
                $PSBoundParameters.Add('OverflowActionTarget', $existingCallQueue.OverflowActionTargetId)
            }

            if (!$PSBoundParameters.ContainsKey('OverflowAction')) {
                $PSBoundParameters.Add('OverflowAction', $existingCallQueue.OverflowAction)
            }

            if (!$PSBoundParameters.ContainsKey('OverflowDisconnectAudioFilePrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.OverflowDisconnectAudioFilePrompt)) {
                $PSBoundParameters.Add('OverflowDisconnectAudioFilePrompt', $existingCallQueue.OverflowDisconnectAudioFilePrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('OverflowDisconnectAudioFilePrompt') -and [string]::IsNullOrWhiteSpace($OverflowDisconnectAudioFilePrompt)) {
                $null = $PSBoundParameters.Remove('OverflowDisconnectAudioFilePrompt')
            }

            if (!$PSBoundParameters.ContainsKey('OverflowDisconnectTextToSpeechPrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.OverflowDisconnectTextToSpeechPrompt)) {
                $PSBoundParameters.Add('OverflowDisconnectTextToSpeechPrompt', $existingCallQueue.OverflowDisconnectTextToSpeechPrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('OverflowDisconnectTextToSpeechPrompt') -and [string]::IsNullOrWhiteSpace($OverflowDisconnectTextToSpeechPrompt)) {
                $null = $PSBoundParameters.Remove('OverflowDisconnectTextToSpeechPrompt')
            }

            if (!$PSBoundParameters.ContainsKey('OverflowRedirectPersonAudioFilePrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.OverflowRedirectPersonAudioFilePrompt)) {
                $PSBoundParameters.Add('OverflowRedirectPersonAudioFilePrompt', $existingCallQueue.OverflowRedirectPersonAudioFilePrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('OverflowRedirectPersonAudioFilePrompt') -and [string]::IsNullOrWhiteSpace($OverflowRedirectPersonAudioFilePrompt)) {
                $null = $PSBoundParameters.Remove('OverflowRedirectPersonAudioFilePrompt')
            }

            if (!$PSBoundParameters.ContainsKey('OverflowRedirectPersonTextToSpeechPrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.OverflowRedirectPersonTextToSpeechPrompt)) {
                $PSBoundParameters.Add('OverflowRedirectPersonTextToSpeechPrompt', $existingCallQueue.OverflowRedirectPersonTextToSpeechPrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('OverflowRedirectPersonTextToSpeechPrompt') -and [string]::IsNullOrWhiteSpace($OverflowRedirectPersonTextToSpeechPrompt)) {
                $null = $PSBoundParameters.Remove('OverflowRedirectPersonTextToSpeechPrompt')
            }

            if (!$PSBoundParameters.ContainsKey('OverflowRedirectVoiceAppAudioFilePrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.OverflowRedirectVoiceAppAudioFilePrompt)) {
                $PSBoundParameters.Add('OverflowRedirectVoiceAppAudioFilePrompt', $existingCallQueue.OverflowRedirectVoiceAppAudioFilePrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('OverflowRedirectVoiceAppAudioFilePrompt') -and [string]::IsNullOrWhiteSpace($OverflowRedirectVoiceAppAudioFilePrompt)) {
                $null = $PSBoundParameters.Remove('OverflowRedirectVoiceAppAudioFilePrompt')
            }

            if (!$PSBoundParameters.ContainsKey('OverflowRedirectVoiceAppTextToSpeechPrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.OverflowRedirectVoiceAppTextToSpeechPrompt)) {
                $PSBoundParameters.Add('OverflowRedirectVoiceAppTextToSpeechPrompt', $existingCallQueue.OverflowRedirectVoiceAppTextToSpeechPrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('OverflowRedirectVoiceAppTextToSpeechPrompt') -and [string]::IsNullOrWhiteSpace($OverflowRedirectVoiceAppTextToSpeechPrompt)) {
                $null = $PSBoundParameters.Remove('OverflowRedirectVoiceAppTextToSpeechPrompt')
            }

            if (!$PSBoundParameters.ContainsKey('OverflowRedirectPhoneNumberAudioFilePrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.OverflowRedirectPhoneNumberAudioFilePrompt)) {
                $PSBoundParameters.Add('OverflowRedirectPhoneNumberAudioFilePrompt', $existingCallQueue.OverflowRedirectPhoneNumberAudioFilePrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('OverflowRedirectPhoneNumberAudioFilePrompt') -and [string]::IsNullOrWhiteSpace($OverflowRedirectPhoneNumberAudioFilePrompt)) {
                $null = $PSBoundParameters.Remove('OverflowRedirectPhoneNumberAudioFilePrompt')
            }

            if (!$PSBoundParameters.ContainsKey('OverflowRedirectPhoneNumberTextToSpeechPrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.OverflowRedirectPhoneNumberTextToSpeechPrompt)) {
                $PSBoundParameters.Add('OverflowRedirectPhoneNumberTextToSpeechPrompt', $existingCallQueue.OverflowRedirectPhoneNumberTextToSpeechPrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('OverflowRedirectPhoneNumberTextToSpeechPrompt') -and [string]::IsNullOrWhiteSpace($OverflowRedirectPhoneNumberTextToSpeechPrompt)) {
                $null = $PSBoundParameters.Remove('OverflowRedirectPhoneNumberTextToSpeechPrompt')
            }

            if (!$PSBoundParameters.ContainsKey('OverflowRedirectVoicemailAudioFilePrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.OverflowRedirectVoicemailAudioFilePrompt)) {
                $PSBoundParameters.Add('OverflowRedirectVoicemailAudioFilePrompt', $existingCallQueue.OverflowRedirectVoicemailAudioFilePrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('OverflowRedirectVoicemailAudioFilePrompt') -and [string]::IsNullOrWhiteSpace($OverflowRedirectVoicemailAudioFilePrompt)) {
                $null = $PSBoundParameters.Remove('OverflowRedirectVoicemailAudioFilePrompt')
            }

            if (!$PSBoundParameters.ContainsKey('OverflowRedirectVoicemailTextToSpeechPrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.OverflowRedirectVoicemailTextToSpeechPrompt)) {
                $PSBoundParameters.Add('OverflowRedirectVoicemailTextToSpeechPrompt', $existingCallQueue.OverflowRedirectVoicemailTextToSpeechPrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('OverflowRedirectVoicemailTextToSpeechPrompt') -and [string]::IsNullOrWhiteSpace($OverflowRedirectVoicemailTextToSpeechPrompt)) {
                $null = $PSBoundParameters.Remove('OverflowRedirectVoicemailTextToSpeechPrompt')
            }

            if (!$PSBoundParameters.ContainsKey('TimeoutSharedVoicemailTextToSpeechPrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.TimeoutSharedVoicemailTextToSpeechPrompt) ) {
                $PSBoundParameters.Add('TimeoutSharedVoicemailTextToSpeechPrompt', $existingCallQueue.TimeoutSharedVoicemailTextToSpeechPrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('TimeoutSharedVoicemailTextToSpeechPrompt') -and [string]::IsNullOrWhiteSpace($TimeoutSharedVoicemailTextToSpeechPrompt)) {
                $null = $PSBoundParameters.Remove('TimeoutSharedVoicemailTextToSpeechPrompt')
            }

            if (!$PSBoundParameters.ContainsKey('TimeoutSharedVoicemailAudioFilePrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.TimeoutSharedVoicemailAudioFilePrompt)) {
                $PSBoundParameters.Add('TimeoutSharedVoicemailAudioFilePrompt', $existingCallQueue.TimeoutSharedVoicemailAudioFilePrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('TimeoutSharedVoicemailAudioFilePrompt') -and [string]::IsNullOrWhiteSpace($TimeoutSharedVoicemailAudioFilePrompt)) {
                $null = $PSBoundParameters.Remove('TimeoutSharedVoicemailAudioFilePrompt')
            }

            if (!$PSBoundParameters.ContainsKey('EnableTimeoutSharedVoicemailTranscription')) {
                if ($existingCallQueue.EnableTimeoutSharedVoicemailTranscription -ne $null) {
                    $PSBoundParameters.Add('EnableTimeoutSharedVoicemailTranscription', $existingCallQueue.EnableTimeoutSharedVoicemailTranscription)
                }
            }

            if (!$PSBoundParameters.ContainsKey('EnableTimeoutSharedVoicemailSystemPromptSuppression') -and $null -ne $existingCallQueue.EnableTimeoutSharedVoicemailSystemPromptSuppression) {
                $PSBoundParameters.Add('EnableTimeoutSharedVoicemailSystemPromptSuppression',  $existingCallQueue.EnableTimeoutSharedVoicemailSystemPromptSuppression)
            }

            if (!$PSBoundParameters.ContainsKey('TimeoutActionTarget') -and !($TimeoutAction -eq 'Disconnect') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.TimeoutActionTargetId)) {
                $PSBoundParameters.Add('TimeoutActionTarget', $existingCallQueue.TimeoutActionTargetId)
            }

            if (!$PSBoundParameters.ContainsKey('TimeoutAction')) {
                $PSBoundParameters.Add('TimeoutAction', $existingCallQueue.TimeoutAction)
            }

            if (!$PSBoundParameters.ContainsKey('TimeoutDisconnectAudioFilePrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.TimeoutDisconnectAudioFilePrompt)) {
                $PSBoundParameters.Add('TimeoutDisconnectAudioFilePrompt', $existingCallQueue.TimeoutDisconnectAudioFilePrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('TimeoutDisconnectAudioFilePrompt') -and [string]::IsNullOrWhiteSpace($TimeoutDisconnectAudioFilePrompt)) {
                $null = $PSBoundParameters.Remove('TimeoutDisconnectAudioFilePrompt')
            }

            if (!$PSBoundParameters.ContainsKey('TimeoutDisconnectTextToSpeechPrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.TimeoutDisconnectTextToSpeechPrompt)) {
                $PSBoundParameters.Add('TimeoutDisconnectTextToSpeechPrompt', $existingCallQueue.TimeoutDisconnectTextToSpeechPrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('TimeoutDisconnectTextToSpeechPrompt') -and [string]::IsNullOrWhiteSpace($TimeoutDisconnectTextToSpeechPrompt)) {
                $null = $PSBoundParameters.Remove('TimeoutDisconnectTextToSpeechPrompt')
            }

            if (!$PSBoundParameters.ContainsKey('TimeoutRedirectPersonAudioFilePrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.TimeoutRedirectPersonAudioFilePrompt)) {
                $PSBoundParameters.Add('TimeoutRedirectPersonAudioFilePrompt', $existingCallQueue.TimeoutRedirectPersonAudioFilePrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('TimeoutRedirectPersonAudioFilePrompt') -and [string]::IsNullOrWhiteSpace($TimeoutRedirectPersonAudioFilePrompt)) {
                $null = $PSBoundParameters.Remove('TimeoutRedirectPersonAudioFilePrompt')
            }

            if (!$PSBoundParameters.ContainsKey('TimeoutRedirectPersonTextToSpeechPrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.TimeoutRedirectPersonTextToSpeechPrompt)) {
                $PSBoundParameters.Add('TimeoutRedirectPersonTextToSpeechPrompt', $existingCallQueue.TimeoutRedirectPersonTextToSpeechPrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('TimeoutRedirectPersonTextToSpeechPrompt') -and [string]::IsNullOrWhiteSpace($TimeoutRedirectPersonTextToSpeechPrompt)) {
                $null = $PSBoundParameters.Remove('TimeoutRedirectPersonTextToSpeechPrompt')
            }

            if (!$PSBoundParameters.ContainsKey('TimeoutRedirectVoiceAppAudioFilePrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.TimeoutRedirectVoiceAppAudioFilePrompt)) {
                $PSBoundParameters.Add('TimeoutRedirectVoiceAppAudioFilePrompt', $existingCallQueue.TimeoutRedirectVoiceAppAudioFilePrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('TimeoutRedirectVoiceAppAudioFilePrompt') -and [string]::IsNullOrWhiteSpace($TimeoutRedirectVoiceAppAudioFilePrompt)) {
                $null = $PSBoundParameters.Remove('TimeoutRedirectVoiceAppAudioFilePrompt')
            }

            if (!$PSBoundParameters.ContainsKey('TimeoutRedirectVoiceAppTextToSpeechPrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.TimeoutRedirectVoiceAppTextToSpeechPrompt)) {
                $PSBoundParameters.Add('TimeoutRedirectVoiceAppTextToSpeechPrompt', $existingCallQueue.TimeoutRedirectVoiceAppTextToSpeechPrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('TimeoutRedirectVoiceAppTextToSpeechPrompt') -and [string]::IsNullOrWhiteSpace($TimeoutRedirectVoiceAppTextToSpeechPrompt)) {
                $null = $PSBoundParameters.Remove('TimeoutRedirectVoiceAppTextToSpeechPrompt')
            }

            if (!$PSBoundParameters.ContainsKey('TimeoutRedirectPhoneNumberAudioFilePrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.TimeoutRedirectPhoneNumberAudioFilePrompt)) {
                $PSBoundParameters.Add('TimeoutRedirectPhoneNumberAudioFilePrompt', $existingCallQueue.TimeoutRedirectPhoneNumberAudioFilePrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('TimeoutRedirectPhoneNumberAudioFilePrompt') -and [string]::IsNullOrWhiteSpace($TimeoutRedirectPhoneNumberAudioFilePrompt)) {
                $null = $PSBoundParameters.Remove('TimeoutRedirectPhoneNumberAudioFilePrompt')
            }

            if (!$PSBoundParameters.ContainsKey('TimeoutRedirectPhoneNumberTextToSpeechPrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.TimeoutRedirectPhoneNumberTextToSpeechPrompt)) {
                $PSBoundParameters.Add('TimeoutRedirectPhoneNumberTextToSpeechPrompt', $existingCallQueue.TimeoutRedirectPhoneNumberTextToSpeechPrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('TimeoutRedirectPhoneNumberTextToSpeechPrompt') -and [string]::IsNullOrWhiteSpace($TimeoutRedirectPhoneNumberTextToSpeechPrompt)) {
                $null = $PSBoundParameters.Remove('TimeoutRedirectPhoneNumberTextToSpeechPrompt')
            }

            if (!$PSBoundParameters.ContainsKey('TimeoutRedirectVoicemailAudioFilePrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.TimeoutRedirectVoicemailAudioFilePrompt)) {
                $PSBoundParameters.Add('TimeoutRedirectVoicemailAudioFilePrompt', $existingCallQueue.TimeoutRedirectVoicemailAudioFilePrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('TimeoutRedirectVoicemailAudioFilePrompt') -and [string]::IsNullOrWhiteSpace($TimeoutRedirectVoicemailAudioFilePrompt)) {
                $null = $PSBoundParameters.Remove('TimeoutRedirectVoicemailAudioFilePrompt')
            }

            if (!$PSBoundParameters.ContainsKey('TimeoutRedirectVoicemailTextToSpeechPrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.TimeoutRedirectVoicemailTextToSpeechPrompt)) {
                $PSBoundParameters.Add('TimeoutRedirectVoicemailTextToSpeechPrompt', $existingCallQueue.TimeoutRedirectVoicemailTextToSpeechPrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('TimeoutRedirectVoicemailTextToSpeechPrompt') -and [string]::IsNullOrWhiteSpace($TimeoutRedirectVoicemailTextToSpeechPrompt)) {
                $null = $PSBoundParameters.Remove('TimeoutRedirectVoicemailTextToSpeechPrompt')
            }

            if (!$PSBoundParameters.ContainsKey('NoAgentDisconnectAudioFilePrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.NoAgentDisconnectAudioFilePrompt)) {
                $PSBoundParameters.Add('NoAgentDisconnectAudioFilePrompt', $existingCallQueue.NoAgentDisconnectAudioFilePrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('NoAgentDisconnectAudioFilePrompt') -and [string]::IsNullOrWhiteSpace($NoAgentDisconnectAudioFilePrompt)) {
                $null = $PSBoundParameters.Remove('NoAgentDisconnectAudioFilePrompt')
            }

            if (!$PSBoundParameters.ContainsKey('NoAgentDisconnectTextToSpeechPrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.NoAgentDisconnectTextToSpeechPrompt)) {
                $PSBoundParameters.Add('NoAgentDisconnectTextToSpeechPrompt', $existingCallQueue.NoAgentDisconnectTextToSpeechPrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('NoAgentDisconnectTextToSpeechPrompt') -and [string]::IsNullOrWhiteSpace($NoAgentDisconnectTextToSpeechPrompt)) {
                $null = $PSBoundParameters.Remove('NoAgentDisconnectTextToSpeechPrompt')
            }

            if (!$PSBoundParameters.ContainsKey('NoAgentRedirectPersonAudioFilePrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.NoAgentRedirectPersonAudioFilePrompt)) {
                $PSBoundParameters.Add('NoAgentRedirectPersonAudioFilePrompt', $existingCallQueue.NoAgentRedirectPersonAudioFilePrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('NoAgentRedirectPersonAudioFilePrompt') -and [string]::IsNullOrWhiteSpace($NoAgentRedirectPersonAudioFilePrompt)) {
                $null = $PSBoundParameters.Remove('NoAgentRedirectPersonAudioFilePrompt')
            }

            if (!$PSBoundParameters.ContainsKey('NoAgentRedirectPersonTextToSpeechPrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.NoAgentRedirectPersonTextToSpeechPrompt)) {
                $PSBoundParameters.Add('NoAgentRedirectPersonTextToSpeechPrompt', $existingCallQueue.NoAgentRedirectPersonTextToSpeechPrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('NoAgentRedirectPersonTextToSpeechPrompt') -and [string]::IsNullOrWhiteSpace($NoAgentRedirectPersonTextToSpeechPrompt)) {
                $null = $PSBoundParameters.Remove('NoAgentRedirectPersonTextToSpeechPrompt')
            }

            if (!$PSBoundParameters.ContainsKey('NoAgentRedirectVoiceAppAudioFilePrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.NoAgentRedirectVoiceAppAudioFilePrompt)) {
                $PSBoundParameters.Add('NoAgentRedirectVoiceAppAudioFilePrompt', $existingCallQueue.NoAgentRedirectVoiceAppAudioFilePrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('NoAgentRedirectVoiceAppAudioFilePrompt') -and [string]::IsNullOrWhiteSpace($NoAgentRedirectVoiceAppAudioFilePrompt)) {
                $null = $PSBoundParameters.Remove('NoAgentRedirectVoiceAppAudioFilePrompt')
            }

            if (!$PSBoundParameters.ContainsKey('NoAgentRedirectVoiceAppTextToSpeechPrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.NoAgentRedirectVoiceAppTextToSpeechPrompt)) {
                $PSBoundParameters.Add('NoAgentRedirectVoiceAppTextToSpeechPrompt', $existingCallQueue.NoAgentRedirectVoiceAppTextToSpeechPrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('NoAgentRedirectVoiceAppTextToSpeechPrompt') -and [string]::IsNullOrWhiteSpace($NoAgentRedirectVoiceAppTextToSpeechPrompt)) {
                $null = $PSBoundParameters.Remove('NoAgentRedirectVoiceAppTextToSpeechPrompt')
            }

            if (!$PSBoundParameters.ContainsKey('NoAgentRedirectPhoneNumberAudioFilePrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.NoAgentRedirectPhoneNumberAudioFilePrompt)) {
                $PSBoundParameters.Add('NoAgentRedirectPhoneNumberAudioFilePrompt', $existingCallQueue.NoAgentRedirectPhoneNumberAudioFilePrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('NoAgentRedirectPhoneNumberAudioFilePrompt') -and [string]::IsNullOrWhiteSpace($NoAgentRedirectPhoneNumberAudioFilePrompt)) {
                $null = $PSBoundParameters.Remove('NoAgentRedirectPhoneNumberAudioFilePrompt')
            }

            if (!$PSBoundParameters.ContainsKey('NoAgentRedirectPhoneNumberTextToSpeechPrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.NoAgentRedirectPhoneNumberTextToSpeechPrompt)) {
                $PSBoundParameters.Add('NoAgentRedirectPhoneNumberTextToSpeechPrompt', $existingCallQueue.NoAgentRedirectPhoneNumberTextToSpeechPrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('NoAgentRedirectPhoneNumberTextToSpeechPrompt') -and [string]::IsNullOrWhiteSpace($NoAgentRedirectPhoneNumberTextToSpeechPrompt)) {
                $null = $PSBoundParameters.Remove('NoAgentRedirectPhoneNumberTextToSpeechPrompt')
            }

            if (!$PSBoundParameters.ContainsKey('NoAgentRedirectVoicemailAudioFilePrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.NoAgentRedirectVoicemailAudioFilePrompt)) {
                $PSBoundParameters.Add('NoAgentRedirectVoicemailAudioFilePrompt', $existingCallQueue.NoAgentRedirectVoicemailAudioFilePrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('NoAgentRedirectVoicemailAudioFilePrompt') -and [string]::IsNullOrWhiteSpace($NoAgentRedirectVoicemailAudioFilePrompt)) {
                $null = $PSBoundParameters.Remove('NoAgentRedirectVoicemailAudioFilePrompt')
            }

            if (!$PSBoundParameters.ContainsKey('NoAgentRedirectVoicemailTextToSpeechPrompt') -and ![string]::IsNullOrWhiteSpace($existingCallQueue.NoAgentRedirectVoicemailTextToSpeechPrompt)) {
                $PSBoundParameters.Add('NoAgentRedirectVoicemailTextToSpeechPrompt', $existingCallQueue.NoAgentRedirectVoicemailTextToSpeechPrompt)
            }
            elseif ($PSBoundParameters.ContainsKey('NoAgentRedirectVoicemailTextToSpeechPrompt') -and [string]::IsNullOrWhiteSpace($NoAgentRedirectVoicemailTextToSpeechPrompt)) {
                $null = $PSBoundParameters.Remove('NoAgentRedirectVoicemailTextToSpeechPrompt')
            }

            if (!$PSBoundParameters.ContainsKey('AuthorizedUsers')) {
                $PSBoundParameters.Add('AuthorizedUsers', $existingCallQueue.AuthorizedUsers)
            }

            if (!$PSBoundParameters.ContainsKey('HideAuthorizedUsers')) {
                $PSBoundParameters.Add('HideAuthorizedUsers', $existingCallQueue.HideAuthorizedUsers)
            }

            # End of param hashtable modification

            # Update the CallQueue.
            $updateResult = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsCallQueue @PSBoundParameters @httpPipelineArgs
            # The response of the Update API is only the list of `Diagnostics` which can be directly used in
            # the following method instead of accessing the `Diagnostic` like we do for other CMDLets.
            Write-AdminServiceDiagnostic($updateResult)

            # Unfortunately, CallQueue PUT API does not return a CallQueue DTO model. We need to GET the CallQueue again
            # to print the updated model.
            $getResult = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Get-CsCallQueue @getParams @httpPipelineArgs

            $updatedCallQueue = [Microsoft.Rtc.Management.Hosted.CallQueue.Models.CallQueue]::new()
            $updatedCallQueue.ParseFrom($getResult.CallQueue)

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Format output of Set-CsOdcServiceNumber

function Set-CsOdcServiceNumber {
    [CmdletBinding(PositionalBinding=$false)]
    param(
    [string]
    ${Identity},

    [string]
    ${PrimaryLanguage},

    [string[]]
    ${SecondaryLanguages},

    [switch]
    ${RestoreDefaultLanguages},

    [Alias('DC')]
    ${DomainController},

    [switch]
    ${Force},

    [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.ConferencingServiceNumber]
    [Parameter(ValueFromPipeline)]
    ${Instance},
    
    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
    ${HttpPipelinePrepend})

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            if ($Identity -ne ""){
                $output = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsOdcServiceNumber @PSBoundParameters @httpPipelineArgs
            }
            elseif ($Instance -ne $null) {
                $Body = [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.ServiceNumberUpdateRequest]::new()

                if ($PrimaryLanguage -ne "" ){
                    $Body.PrimaryLanguage = $PrimaryLanguage
                }
                else {
                    $Body.PrimaryLanguage = $Instance.PrimaryLanguage
                }

                if ($SecondaryLanguages -ne "") {
                    $Body.SecondaryLanguage = $SecondaryLanguages
                }
                else {
                    $Body.SecondaryLanguage = $Instance.SecondaryLanguages
                }

                if ($RestoreDefaultLanguages -eq $true) {
                    $Body.RestoreDefaultLanguage = $RestoreDefaultLanguages
                }

                $output = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsOdcServiceNumber -Identity $Instance.Number -Body $Body @httpPipelineArgs
            }

            $output

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: assign parameters' values and customize output

function Set-CsOnlineSchedule {
    [CmdletBinding(PositionalBinding=$true, SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [Object]
        # The instance of the schedule which is updated.
        ${Instance},

        [Parameter(Mandatory=$false, position=1)]
        [Switch]
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }
            if ($PSBoundParameters.ContainsKey("Force")) {
                $PSBoundParameters.Remove("Force") | Out-Null
            }
            $params = @{
                Identity = ${Instance}.Id
                Name = ${Instance}.Name
                Type = ${Instance}.Type
                AssociatedConfigurationId = ${Instance}.AssociatedConfigurationId
            }
            # Get common parameters
            foreach($p in $PSBoundParameters.GetEnumerator())
            {
                $params += @{$p.Key = $p.Value}
            }
            $null = $params.Remove("Instance")

            if (${Instance}.Type -eq [Microsoft.Rtc.Management.Hosted.Online.Models.ScheduleType]::Fixed) {
                $DateTimeRanges = ${Instance}.FixedSchedule.DateTimeRanges
                $dateTimeRangeStandardFormat = 'yyyy-MM-ddTHH:mm:ss';
                $fixedScheduleDateTimeRanges = @()
                foreach ($dateTimeRange in $DateTimeRanges) {
                    $fixedScheduleDateTimeRanges += @{
                        Start = $dateTimeRange.Start.ToString($dateTimeRangeStandardFormat, [System.Globalization.CultureInfo]::InvariantCulture)
                        End = $dateTimeRange.End.ToString($dateTimeRangeStandardFormat, [System.Globalization.CultureInfo]::InvariantCulture)
                    }
                }
                $params['FixedScheduleDateTimeRange'] = $fixedScheduleDateTimeRanges
            }

            if (${Instance}.Type -eq [Microsoft.Rtc.Management.Hosted.Online.Models.ScheduleType]::WeeklyRecurrence) {
                $MondayHours = ${Instance}.WeeklyRecurrentSchedule.MondayHours
                $TuesdayHours = ${Instance}.WeeklyRecurrentSchedule.TuesdayHours
                $WednesdayHours = ${Instance}.WeeklyRecurrentSchedule.WednesdayHours
                $ThursdayHours = ${Instance}.WeeklyRecurrentSchedule.ThursdayHours
                $FridayHours = ${Instance}.WeeklyRecurrentSchedule.FridayHours
                $SaturdayHours = ${Instance}.WeeklyRecurrentSchedule.SaturdayHours
                $SundayHours = ${Instance}.WeeklyRecurrentSchedule.SundayHours

                if ($MondayHours -ne $null -and $MondayHours.Length -gt 0) {
                    $params['WeeklyRecurrentScheduleMondayHour'] = @()
                    foreach ($mondayHour in $MondayHours){
                        $params['WeeklyRecurrentScheduleMondayHour'] += @{
                            Start = $mondayHour.Start
                            End = $mondayHour.End
                        }
                    }
                }
                if ($TuesdayHours -ne $null -and $TuesdayHours.Length -gt 0) {
                    $params['WeeklyRecurrentScheduleTuesdayHour'] = @()
                    foreach ($tuesdayHour in $TuesdayHours){
                        $params['WeeklyRecurrentScheduleTuesdayHour'] += @{
                            Start = $tuesdayHour.Start
                            End = $tuesdayHour.End
                        }
                    }
                }
                if ($WednesdayHours -ne $null -and $WednesdayHours.Length -gt 0) {
                    $params['WeeklyRecurrentScheduleWednesdayHour'] = @()
                    foreach ($wednesdayHour in $WednesdayHours){
                        $params['WeeklyRecurrentScheduleWednesdayHour'] += @{
                            Start = $wednesdayHour.Start
                            End = $wednesdayHour.End
                        }
                    }    
                }
                if ($ThursdayHours -ne $null -and $ThursdayHours.Length -gt 0) {
                    $params['WeeklyRecurrentScheduleThursdayHour'] = @()
                        foreach ($thursdayHour in $ThursdayHours){
                            $params['WeeklyRecurrentScheduleThursdayHour'] += @{
                                Start = $thursdayHour.Start
                                End = $thursdayHour.End
                        }
                    }
                }
                if ($FridayHours -ne $null -and $FridayHours.Length -gt 0) {
                    $params['WeeklyRecurrentScheduleFridayHour'] = @()
                    foreach ($fridayHour in $FridayHours){
                        $params['WeeklyRecurrentScheduleFridayHour'] += @{
                            Start = $fridayHour.Start
                            End = $fridayHour.End
                        }
                    }
                }
                if ($SaturdayHours -ne $null -and $SaturdayHours.Length -gt 0) {
                    $params['WeeklyRecurrentScheduleSaturdayHour'] = @()
                    foreach ($saturdayHour in $SaturdayHours){
                        $params['WeeklyRecurrentScheduleSaturdayHour'] += @{
                            Start = $saturdayHour.Start
                            End = $saturdayHour.End
                        }
                    }
                }
                if ($SundayHours -ne $null -and $SundayHours.Length -gt 0) {
                    $params['WeeklyRecurrentScheduleSundayHour'] = @()
                    foreach ($sundayHour in $SundayHours){
                        $params['WeeklyRecurrentScheduleSundayHour'] += @{
                            Start = $sundayHour.Start
                            End = $sundayHour.End
                        }
                    }
                }

                $params['WeeklyRecurrentScheduleIsComplemented'] = ${Instance}.WeeklyRecurrentSchedule.ComplementEnabled
            
                if (${Instance}.WeeklyRecurrentSchedule.RecurrenceRange -ne $null) {
                    if (${Instance}.WeeklyRecurrentSchedule.RecurrenceRange.Start -ne $null) { $params['RecurrenceRangeStart'] = ${Instance}.WeeklyRecurrentSchedule.RecurrenceRange.Start }
                    if (${Instance}.WeeklyRecurrentSchedule.RecurrenceRange.End -ne $null) { $params['RecurrenceRangeEnd'] = ${Instance}.WeeklyRecurrentSchedule.RecurrenceRange.End }
                    if (${Instance}.WeeklyRecurrentSchedule.RecurrenceRange.Type -ne $null) { $params['RecurrenceRangeType'] = ${Instance}.WeeklyRecurrentSchedule.RecurrenceRange.Type }
                }
            }

            $result = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsOnlineSchedule @params @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($result -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($result.Diagnostic)

            $schedule = [Microsoft.Rtc.Management.Hosted.Online.Models.Schedule]::new()
            $schedule.ParseFrom($result)

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Print error message in case of error

function Set-CsOnlineVoicemailUserSettings {
    [CmdletBinding(PositionalBinding=$true, SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
    [Parameter(Position=0, Mandatory)]
    [System.String]
    ${Identity},

    [Parameter()]
    [Microsoft.Rtc.Management.Hosted.Voicemail.Models.CallAnswerRules]
    ${CallAnswerRule},

    [Parameter()]
    [System.String]
    ${DefaultGreetingPromptOverwrite},

    [Parameter()]
    [System.String]
    ${DefaultOofGreetingPromptOverwrite},

    [Parameter()]
    [System.Nullable[System.Boolean]]
    ${OofGreetingEnabled},

    [Parameter()]
    [System.Nullable[System.Boolean]]
    ${OofGreetingFollowAutomaticRepliesEnabled},

    [Parameter()]
    [System.Nullable[System.Boolean]]
    ${OofGreetingFollowCalendarEnabled},

    [Parameter()]
    [System.String]
    ${PromptLanguage},

    [Parameter()]
    [System.Nullable[System.Boolean]]
    ${ShareData},

    [Parameter()]
    [System.String]
    ${TransferTarget},

    [Parameter()]
    [System.Nullable[System.Boolean]]
    ${VoicemailEnabled},

    [Parameter(Mandatory=$false)]
    [Switch]
    ${Force},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
    ${HttpPipelinePrepend}

    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            if ($PSBoundParameters.ContainsKey("Force")) {
                $PSBoundParameters.Remove("Force") | Out-Null
            }
        
            $result = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Set-CsOnlineVMUserSetting @PSBoundParameters @httpPipelineArgs
            # Stop execution if internal cmdlet is failing
            if ($result -eq $null) {
                return $null
            }

            # If none of the above parameters are set (except Identity and Force), 
            # We should display the Warning message to user.
            if ($PSBoundParameters["CallAnswerRule"] -eq $null -and
                $PSBoundParameters["DefaultGreetingPromptOverwrite"] -eq $null -and
                $PSBoundParameters["DefaultOofGreetingPromptOverwrite"] -eq $null -and 
                $PSBoundParameters["OofGreetingEnabled"] -eq $null -and
                $PSBoundParameters["OofGreetingFollowAutomaticRepliesEnabled"] -eq $null -and
                $PSBoundParameters["OofGreetingFollowCalendarEnabled"] -eq $null -and
                $PSBoundParameters["PromptLanguage"] -eq $null -and
                $PSBoundParameters["ShareData"] -eq $null -and
                $PSBoundParameters["TransferTarget"] -eq $null -and 
                $PSBoundParameters["VoicemailEnabled"] -eq $null) {
                    Write-Warning("To set online voicemail user settings for user {0}, at least one optional parameter should be provided." -f $Identity)
            }

            $result

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Format output of the cmdlet

function Update-CsAutoAttendant {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$true, position=0)]
        [System.String]
        # The identity for the AA to be updated.
        ${Identity},

        [Parameter(Mandatory=$false, position=1)]
        [Switch]
        # The Force parameter indicates if we force the action to be performed. (Deprecated)
        ${Force},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend}
    )

    begin {
        $customCmdletUtils = [Microsoft.Teams.ConfigAPI.Cmdlets.Telemetry.CustomCmdletUtils]::new($MyInvocation)
    }

    process {
        try {

            $httpPipelineArgs = $customCmdletUtils.ProcessArgs()

            $null = $PSBoundParameters.Remove("Force")

            # Default ErrorAction to $ErrorActionPreference
            if (!$PSBoundParameters.ContainsKey("ErrorAction")) {
                $PSBoundParameters.Add("ErrorAction", $ErrorActionPreference)
            }

            $internalOutput = Microsoft.Teams.ConfigAPI.Cmdlets.internal\Update-CsAutoAttendant @PSBoundParameters @httpPipelineArgs

            # Stop execution if internal cmdlet is failing
            if ($internalOutput -eq $null) {
                return $null
            }

            Write-AdminServiceDiagnostic($internalOutput.Diagnostic)

        } catch {
            $customCmdletUtils.SendTelemetry()
            throw
        }
    }

    end {
        $customCmdletUtils.SendTelemetry()
    }
}
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Objective of this custom file: Provide common functions for voice app team cmdlets

function Write-AdminServiceDiagnostic {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$false, position=0)]
        [Microsoft.Teams.ConfigAPI.Cmdlets.Generated.Models.IDiagnosticRecord[]]
        # The diagnostic object
        ${Diagnostics}
    )
    process {
        if ($Diagnostics -eq $null)
        {
            return
        }

        foreach($diagnostic in $Diagnostics)
        {
            if ($diagnostic.Level -eq $null)
            {
                Write-Output $diagnostic.Message
            }
            else
            {
                switch($diagnostic.Level)
                {
                    "Warning" { Write-Warning $diagnostic.Message }
                    "Info" { Write-Output $diagnostic.Message }
                    "Verbose" { Write-Verbose $diagnostic.Message }
                    default { Write-Output $diagnostic.Message }
                }
            }
        }
    }
}

function Get-StatusRecordStatusString {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$false, position=0)]
        [Int]
        # The int status from status record
        ${StatusRecordStatus}
    )
    process {
        if ($StatusRecordStatus -eq $null)
        {
            return
        }

        $status = ''

        switch ($StatusRecordStatus)
        {
            0 {$status = 'Error'}
            1 {$status = 'Pending'}
            2 {$status = 'Unknown'}
            3 {$status = 'Success'}
        }

        $status
    }
}

function Get-StatusRecordStatusCodeString {
    [CmdletBinding(PositionalBinding=$true)]
    param(
        [Parameter(Mandatory=$false, position=0)]
        [Int]
        # The int status from status record
        ${StatusRecordErrorCode}
    )
    process {
        if ($StatusRecordErrorCode -eq $null)
        {
            return
        }

        $statusCode = ''

        switch ($StatusRecordErrorCode)
        {
            'ApplicationInstanceAssociationProvider_AppEndpointNotFound' {$statusCode = 'AppEndpointNotFound'}
            'ApplicationInstanceAssociationStatusProvider_AppEndpointNotFound' {$statusCode = 'AppEndpointNotFound'}
            'ApplicationInstanceAssociationStatusProvider_AcsAssociationNotFound' {$statusCode = 'AcsAssociationNotFound'}
            'ApplicationInstanceAssociationStatusProvider_ApsAssociationNotFound' {$statusCode = 'ApsAppEndpointNotFound'}
            'AudioFile_FileNameNullOrWhitespace' {$statusCode = 'AudioFileNameNullOrWhitespace'}
            'AudioFile_FileNameTooShort' {$statusCode = 'AudioFileNameTooShort'}
            'AudioFile_FileNameTooLong' {$statusCode = 'AudioFileNameTooLong'}
            'AudioFile_InvalidAudioFileExtension' {$statusCode = 'InvalidAudioFileExtension'}
            'AudioFile_InvalidFileName' {$statusCode = 'InvalidAudioFileName'}
            'AudioFile_UnsupportedAudioFileExtension' {$statusCode = 'UnsupportedAudioFileExtension'}
            'CreateApplicationEndpoint_ApsAppEndpointInvalid' {$statusCode = 'ApsAppEndpointInvalid'}
            'CreateApplicationInstanceAssociation_AppEndpointAlreadyAssociated' {$statusCode = 'AcsAssociationAlreadyExists'}
            'CreateApplicationInstanceAssociation_AppEndpointNotFound' {$statusCode = 'AppEndpointNotFound'}
            'CreateApplicationInstanceAssociation_AppEndpointMissingProvisioning' {$statusCode = 'AppEndpointMissingProvisioning'}
            'DateTimeRange_InvalidDateTimeRangeBound' {$statusCode = 'InvalidDateTimeRangeFormat'}
            'DateTimeRange_InvalidDateTimeRangeKind' {$statusCode = 'InvalidDateTimeRangeKind'}
            'DateTimeRange_NonPositiveDateTimeRange' {$statusCode = 'InvalidDateTimeRange'}
            'DeserializeScheduleOperation_InvalidModelVersion' {$statusCode = 'InvalidSerializedModelVersion'}
            'EnvironmentContextMapper_ForestNameNullOrWhiteSpace' {$statusCode = 'ForestNameNullOrWhiteSpace'}
            'FixedSchedule_DuplicateDateTimeRangeStartBoundaries' {$statusCode = 'DuplicateDateTimeRangeStartBoundaries'}
            'FixedSchedule_InvalidDateTimeRangeBoundariesAlignment' {$statusCode = 'InvalidDateTimeRangeBoundariesAlignment'}
            'ModelId_InvalidScheduleId' {$statusCode = 'InvalidScheduleId'}
            'ModifyScheduleOperation_ScheduleConflictInExistingAutoAttendant' {$statusCode = 'ScheduleConflictInExistingAutoAttendant'}
            'RemoveApplicationInstanceAssociation_AppEndpointNotFound' {$statusCode = 'AppEndpointNotFound'}
            'RemoveApplicationInstanceAssociation_AssociationNotFound' {$statusCode = 'AcsAssociationNotFound'}
            'RemoveScheduleOperation_ScheduleInUse' {$statusCode = 'ScheduleInUse'}
            'Schedule_NameNullOrWhitespace' {$statusCode = 'ScheduleNameNullOrWhitespace'}
            'Schedule_NameTooLong' {$statusCode = 'ScheduleNameTooLong'}
            'Schedule_FixedScheduleNull' {$statusCode = 'ScheduleTypeMismatch'}
            'Schedule_FixedScheduleNonNull' {$statusCode = 'ScheduleTypeMismatch'}
            'Schedule_WeeklyRecurrentScheduleNull' {$statusCode = 'ScheduleTypeMismatch'}
            'Schedule_WeeklyRecurrentScheduleNonNull' {$statusCode = 'ScheduleTypeMismatch'}
            'ScheduleRecurrenceRange_InvalidType' {$statusCode = 'InvalidRecurrenceRangeType'}
            'ScheduleRecurrenceRange_UnsupportedType' {$statusCode = 'InvalidRecurrenceRangeType'}
            'ScheduleRecurrenceRange_NonPositiveRange' {$statusCode = 'InvalidRecurrenceRangeEndDateTime'}
            'ScheduleRecurrenceRange_EndDateTimeNull' {$statusCode = 'InvalidRecurrenceRangeEndDateTime'}
            'ScheduleRecurrenceRange_EndDateTimeNonNull' {$statusCode = 'InvalidRecurrenceRangeEndDateTime'}
            'ScheduleRecurrenceRange_NumberOfOccurrencesZero' {$statusCode = 'InvalidRecurrenceNumberOfOccurrences'}
            'ScheduleRecurrenceRange_NumberOfOccurrencesNull' {$statusCode = 'InvalidRecurrenceNumberOfOccurrences'}
            'ScheduleRecurrenceRange_NumberOfOccurrencesNonNull' {$statusCode = 'InvalidRecurrenceNumberOfOccurrences'}
            'TimeRange_InvalidTimeRange' {$statusCode = 'InvalidTimeRange'}
            'TimeRange_InvalidTimeRangeBound' {$statusCode = 'InvalidTimeRangeBound'}
            'WeeklyRecurrentSchedule_EmptySchedule' {$statusCode = 'EmptyWeeklyRecurrentSchedule'}
            'WeeklyRecurrentSchedule_InvalidTimeRangeBoundariesAlignment' {$statusCode = 'InvalidTimeRangeBoundariesAlignment'}
            'WeeklyRecurrentSchedule_OverlappingTimeRanges' {$statusCode = 'TimeRangesOverlapping'}
            'WeeklyRecurrentSchedule_TooManyTimeRangesPerDay' {$statusCode = 'TooManyTimeRangesForDay'}
            'WeeklyRecurrentSchedule_RecurrenceRangeNull' {$statusCode = 'ScheduleRecurrenceRangeNull'}
        }

        $statusCode
    }
}

# Asp.Net 4.0+ considers these eight characters (<, >, *, %, &, :, \, and ?) as the default
# potential dangerous characters in the URL which may be used in XSS attacks.
# A SIP URI (sip:user@domain.com:port) usually startswith SIP prefix (sip:). This COLON (:)
# in prefix needs to be replaced with something that is not invalid.
# Also, as the last parameter in the URI is "identity", it can not have Dots (.)
# For these reasons we wrote this custom method.
function EncodeSipUri {
    param(
        $Identity
    )

    if ($Identity -eq $null)
    {
        return
    }

    $Identity = $Identity.replace(':', "[COLON]")
    $Identity = $Identity.replace('.', "[DOT]")

    return $Identity
}

# SIG # Begin signature block
# MIInkwYJKoZIhvcNAQcCoIInhDCCJ4ACAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDmpE5W84prVf1i
# 0Y+hLVjiLusHZlh3wluuDxbs9JPfe6CCDXYwggX0MIID3KADAgECAhMzAAADTrU8
# esGEb+srAAAAAANOMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjMwMzE2MTg0MzI5WhcNMjQwMzE0MTg0MzI5WjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQDdCKiNI6IBFWuvJUmf6WdOJqZmIwYs5G7AJD5UbcL6tsC+EBPDbr36pFGo1bsU
# p53nRyFYnncoMg8FK0d8jLlw0lgexDDr7gicf2zOBFWqfv/nSLwzJFNP5W03DF/1
# 1oZ12rSFqGlm+O46cRjTDFBpMRCZZGddZlRBjivby0eI1VgTD1TvAdfBYQe82fhm
# WQkYR/lWmAK+vW/1+bO7jHaxXTNCxLIBW07F8PBjUcwFxxyfbe2mHB4h1L4U0Ofa
# +HX/aREQ7SqYZz59sXM2ySOfvYyIjnqSO80NGBaz5DvzIG88J0+BNhOu2jl6Dfcq
# jYQs1H/PMSQIK6E7lXDXSpXzAgMBAAGjggFzMIIBbzAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQUnMc7Zn/ukKBsBiWkwdNfsN5pdwAw
# RQYDVR0RBD4wPKQ6MDgxHjAcBgNVBAsTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEW
# MBQGA1UEBRMNMjMwMDEyKzUwMDUxNjAfBgNVHSMEGDAWgBRIbmTlUAXTgqoXNzci
# tW2oynUClTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20vcGtpb3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3JsMGEG
# CCsGAQUFBwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDovL3d3dy5taWNyb3NvZnQu
# Y29tL3BraW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3J0
# MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggIBAD21v9pHoLdBSNlFAjmk
# mx4XxOZAPsVxxXbDyQv1+kGDe9XpgBnT1lXnx7JDpFMKBwAyIwdInmvhK9pGBa31
# TyeL3p7R2s0L8SABPPRJHAEk4NHpBXxHjm4TKjezAbSqqbgsy10Y7KApy+9UrKa2
# kGmsuASsk95PVm5vem7OmTs42vm0BJUU+JPQLg8Y/sdj3TtSfLYYZAaJwTAIgi7d
# hzn5hatLo7Dhz+4T+MrFd+6LUa2U3zr97QwzDthx+RP9/RZnur4inzSQsG5DCVIM
# pA1l2NWEA3KAca0tI2l6hQNYsaKL1kefdfHCrPxEry8onJjyGGv9YKoLv6AOO7Oh
# JEmbQlz/xksYG2N/JSOJ+QqYpGTEuYFYVWain7He6jgb41JbpOGKDdE/b+V2q/gX
# UgFe2gdwTpCDsvh8SMRoq1/BNXcr7iTAU38Vgr83iVtPYmFhZOVM0ULp/kKTVoir
# IpP2KCxT4OekOctt8grYnhJ16QMjmMv5o53hjNFXOxigkQWYzUO+6w50g0FAeFa8
# 5ugCCB6lXEk21FFB1FdIHpjSQf+LP/W2OV/HfhC3uTPgKbRtXo83TZYEudooyZ/A
# Vu08sibZ3MkGOJORLERNwKm2G7oqdOv4Qj8Z0JrGgMzj46NFKAxkLSpE5oHQYP1H
# tPx1lPfD7iNSbJsP6LiUHXH1MIIHejCCBWKgAwIBAgIKYQ6Q0gAAAAAAAzANBgkq
# hkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24x
# EDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlv
# bjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5
# IDIwMTEwHhcNMTEwNzA4MjA1OTA5WhcNMjYwNzA4MjEwOTA5WjB+MQswCQYDVQQG
# EwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwG
# A1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYDVQQDEx9NaWNyb3NvZnQg
# Q29kZSBTaWduaW5nIFBDQSAyMDExMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
# CgKCAgEAq/D6chAcLq3YbqqCEE00uvK2WCGfQhsqa+laUKq4BjgaBEm6f8MMHt03
# a8YS2AvwOMKZBrDIOdUBFDFC04kNeWSHfpRgJGyvnkmc6Whe0t+bU7IKLMOv2akr
# rnoJr9eWWcpgGgXpZnboMlImEi/nqwhQz7NEt13YxC4Ddato88tt8zpcoRb0Rrrg
# OGSsbmQ1eKagYw8t00CT+OPeBw3VXHmlSSnnDb6gE3e+lD3v++MrWhAfTVYoonpy
# 4BI6t0le2O3tQ5GD2Xuye4Yb2T6xjF3oiU+EGvKhL1nkkDstrjNYxbc+/jLTswM9
# sbKvkjh+0p2ALPVOVpEhNSXDOW5kf1O6nA+tGSOEy/S6A4aN91/w0FK/jJSHvMAh
# dCVfGCi2zCcoOCWYOUo2z3yxkq4cI6epZuxhH2rhKEmdX4jiJV3TIUs+UsS1Vz8k
# A/DRelsv1SPjcF0PUUZ3s/gA4bysAoJf28AVs70b1FVL5zmhD+kjSbwYuER8ReTB
# w3J64HLnJN+/RpnF78IcV9uDjexNSTCnq47f7Fufr/zdsGbiwZeBe+3W7UvnSSmn
# Eyimp31ngOaKYnhfsi+E11ecXL93KCjx7W3DKI8sj0A3T8HhhUSJxAlMxdSlQy90
# lfdu+HggWCwTXWCVmj5PM4TasIgX3p5O9JawvEagbJjS4NaIjAsCAwEAAaOCAe0w
# ggHpMBAGCSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBRIbmTlUAXTgqoXNzcitW2o
# ynUClTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYD
# VR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRyLToCMZBDuRQFTuHqp8cx0SOJNDBa
# BgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtpL2Ny
# bC9wcm9kdWN0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFfMDNfMjIuY3JsMF4GCCsG
# AQUFBwEBBFIwUDBOBggrBgEFBQcwAoZCaHR0cDovL3d3dy5taWNyb3NvZnQuY29t
# L3BraS9jZXJ0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFfMDNfMjIuY3J0MIGfBgNV
# HSAEgZcwgZQwgZEGCSsGAQQBgjcuAzCBgzA/BggrBgEFBQcCARYzaHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraW9wcy9kb2NzL3ByaW1hcnljcHMuaHRtMEAGCCsG
# AQUFBwICMDQeMiAdAEwAZQBnAGEAbABfAHAAbwBsAGkAYwB5AF8AcwB0AGEAdABl
# AG0AZQBuAHQALiAdMA0GCSqGSIb3DQEBCwUAA4ICAQBn8oalmOBUeRou09h0ZyKb
# C5YR4WOSmUKWfdJ5DJDBZV8uLD74w3LRbYP+vj/oCso7v0epo/Np22O/IjWll11l
# hJB9i0ZQVdgMknzSGksc8zxCi1LQsP1r4z4HLimb5j0bpdS1HXeUOeLpZMlEPXh6
# I/MTfaaQdION9MsmAkYqwooQu6SpBQyb7Wj6aC6VoCo/KmtYSWMfCWluWpiW5IP0
# wI/zRive/DvQvTXvbiWu5a8n7dDd8w6vmSiXmE0OPQvyCInWH8MyGOLwxS3OW560
# STkKxgrCxq2u5bLZ2xWIUUVYODJxJxp/sfQn+N4sOiBpmLJZiWhub6e3dMNABQam
# ASooPoI/E01mC8CzTfXhj38cbxV9Rad25UAqZaPDXVJihsMdYzaXht/a8/jyFqGa
# J+HNpZfQ7l1jQeNbB5yHPgZ3BtEGsXUfFL5hYbXw3MYbBL7fQccOKO7eZS/sl/ah
# XJbYANahRr1Z85elCUtIEJmAH9AAKcWxm6U/RXceNcbSoqKfenoi+kiVH6v7RyOA
# 9Z74v2u3S5fi63V4GuzqN5l5GEv/1rMjaHXmr/r8i+sLgOppO6/8MO0ETI7f33Vt
# Y5E90Z1WTk+/gFcioXgRMiF670EKsT/7qMykXcGhiJtXcVZOSEXAQsmbdlsKgEhr
# /Xmfwb1tbWrJUnMTDXpQzTGCGXMwghlvAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBIDIwMTECEzMAAANOtTx6wYRv6ysAAAAAA04wDQYJYIZIAWUDBAIB
# BQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIBqmNls30ztroFeBrEYEoyOC
# oIqDEZI3jFzg/gyiYzpWMEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEABNXHN6ltJsBLAZsFiBTV/3M7Y1g6WzHvYtLKxVHXv70H1QZoe2U4A3bj
# nb0n0ooA10fveFOkJMCrs1ehzb+NlDWuwtPWEzBt0BtBN/Y3YLCBkb7h6HTnf8Sp
# p0RY4lZwF9/foSh/V280pjtmrGa4tedOa5blMv9UXgRyuLY+ovOMD5gwhKW48U1U
# D0CYzLFUCS7+oEbS4IxVeO0KX54q7TNFCG7mn1ZvJjH9gcKhjKhO4pbDSxtCKC6/
# M4VkJUhBHq9P8ek3Bzo3oaAXj1YbVmYK2TLaQuGy41ysOQ70JoYhqY1clfG/tHdC
# Q3Tp8lkl4jI+aI2juS6sxD7ao6Ogu6GCFv0wghb5BgorBgEEAYI3AwMBMYIW6TCC
# FuUGCSqGSIb3DQEHAqCCFtYwghbSAgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFRBgsq
# hkiG9w0BCRABBKCCAUAEggE8MIIBOAIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCAeG8VJ8LSbztgNWeUkYNiCwMPOS5t/3C/IawSk1HnstgIGZFzUH/T7
# GBMyMDIzMDUxMjEzMTYwNy4yMDNaMASAAgH0oIHQpIHNMIHKMQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1l
# cmljYSBPcGVyYXRpb25zMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjpERDhDLUUz
# MzctMkZBRTElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZaCC
# EVQwggcMMIIE9KADAgECAhMzAAABxQPNzSGh9O85AAEAAAHFMA0GCSqGSIb3DQEB
# CwUAMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQH
# EwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNV
# BAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMB4XDTIyMTEwNDE5MDEz
# MloXDTI0MDIwMjE5MDEzMlowgcoxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNo
# aW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29y
# cG9yYXRpb24xJTAjBgNVBAsTHE1pY3Jvc29mdCBBbWVyaWNhIE9wZXJhdGlvbnMx
# JjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNOOkREOEMtRTMzNy0yRkFFMSUwIwYDVQQD
# ExxNaWNyb3NvZnQgVGltZS1TdGFtcCBTZXJ2aWNlMIICIjANBgkqhkiG9w0BAQEF
# AAOCAg8AMIICCgKCAgEAq0hds70eX23J7pappaKXRhz+TT7JJ3OvVf3+N8fNpxRs
# 5jY4hEv3BV/w5EWXbZdO4m3xj01lTI/xDkq+ytjuiPe8xGXsZxDntv7L1EzMd5jI
# SqJ+eYu8kgV056mqs8dBo55xZPPPcxf5u19zn04aMQF5PXV/C4ZLSjFa9IFNcrib
# dOm3lGW1rQRFa2jUsup6gv634q5UwH09WGGu0z89RbtbyM55vmBgWV8ed6bZCZrc
# oYIjML8FRTvGlznqm6HtwZdXMwKHT3a/kLUSPiGAsrIgEzz7NpBpeOsgs9TrwyWT
# ZBNbBwyIACmQ34j+uR4et2hZk+NH49KhEJyYD2+dOIaDGB2EUNFSYcy1MkgtZt1e
# RqBB0m+YPYz7HjocPykKYNQZ7Tv+zglOffCiax1jOb0u6IYC5X1Jr8AwTcsaDyu3
# qAhx8cFQN9DDgiVZw+URFZ8oyoDk6sIV1nx5zZLy+hNtakePX9S7Y8n1qWfAjoXP
# E6K0/dbTw87EOJL/BlJGcKoFTytr0zPg/MNJSb6f2a/wDkXoGCGWJiQrGTxjOP+R
# 96/nIIG05eE1Lpky2FOdYMPB4DhW7tBdZautepTTuShmgn+GKER8AoA1gSSk1EC5
# ZX4cppVngJpblMBu8r/tChfHVdXviY6hDShHwQCmZqZebgSYHnHl4urE+4K6ZC8C
# AwEAAaOCATYwggEyMB0GA1UdDgQWBBRU6rs4v1mxNYG/rtpLwrVwek0FazAfBgNV
# HSMEGDAWgBSfpxVdAF5iXYP05dJlpxtTNRnpcjBfBgNVHR8EWDBWMFSgUqBQhk5o
# dHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NybC9NaWNyb3NvZnQlMjBU
# aW1lLVN0YW1wJTIwUENBJTIwMjAxMCgxKS5jcmwwbAYIKwYBBQUHAQEEYDBeMFwG
# CCsGAQUFBzAChlBodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NlcnRz
# L01pY3Jvc29mdCUyMFRpbWUtU3RhbXAlMjBQQ0ElMjAyMDEwKDEpLmNydDAMBgNV
# HRMBAf8EAjAAMBMGA1UdJQQMMAoGCCsGAQUFBwMIMA0GCSqGSIb3DQEBCwUAA4IC
# AQCMqN58frMHOScciK+Cdnr6dK8fTsgQDeZ9bvQjCuxNIJZJ92+xpeKRCf3Xq47q
# dRykkKUnZC6dHhLwt1fhwyiy/LfdVQ9yf1hYZ/RpTS+z0hnaoK+P/IDAiUNm32NX
# LhDBu0P4Sb/uCV4jOuNUcmJhppBQgQVhFx/57JYk1LCdjIee//GrcfbkQtiYob9O
# a93DSjbsD1jqaicEnkclUN/mEm9ZsnCnA1+/OQDp/8Q4cPfH94LM4J6X0NtNBeVy
# wvWH0wuMaOJzHgDLCeJUkFE9HE8sBDVedmj6zPJAI+7ozLjYqw7i4RFbiStfWZSG
# jwt+lLJQZRWUCcT3aHYvTo1YWDZskohWg77w9fF2QbiO9DfnqoZ7QozHi7RiPpbj
# gkJMAhrhpeTf/at2e9+HYkKObUmgPArH1Wjivwm1d7PYWsarL7u5qZuk36Gb1mET
# S1oA2XX3+C3rgtzRohP89qZVf79lVvjmg34NtICK/pMk99SButghtipFSMQdbXUn
# S2oeLt9cKuv1MJu+gJ83qXTNkQ2QqhxtNRvbE9QqmqJQw5VW/4SZze1pPXxyOTO5
# yDq+iRIUubqeQzmUcCkiyNuCLHWh8OLCI5mIOC1iLtVDf2lw9eWropwu5SDJtT/Z
# wqIU1qb2U+NjkNcj1hbODBRELaTTWd91RJiUI9ncJkGg/jCCB3EwggVZoAMCAQIC
# EzMAAAAVxedrngKbSZkAAAAAABUwDQYJKoZIhvcNAQELBQAwgYgxCzAJBgNVBAYT
# AlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYD
# VQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xMjAwBgNVBAMTKU1pY3Jvc29mdCBS
# b290IENlcnRpZmljYXRlIEF1dGhvcml0eSAyMDEwMB4XDTIxMDkzMDE4MjIyNVoX
# DTMwMDkzMDE4MzIyNVowfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0
# b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3Jh
# dGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAwggIi
# MA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDk4aZM57RyIQt5osvXJHm9DtWC
# 0/3unAcH0qlsTnXIyjVX9gF/bErg4r25PhdgM/9cT8dm95VTcVrifkpa/rg2Z4VG
# Iwy1jRPPdzLAEBjoYH1qUoNEt6aORmsHFPPFdvWGUNzBRMhxXFExN6AKOG6N7dcP
# 2CZTfDlhAnrEqv1yaa8dq6z2Nr41JmTamDu6GnszrYBbfowQHJ1S/rboYiXcag/P
# XfT+jlPP1uyFVk3v3byNpOORj7I5LFGc6XBpDco2LXCOMcg1KL3jtIckw+DJj361
# VI/c+gVVmG1oO5pGve2krnopN6zL64NF50ZuyjLVwIYwXE8s4mKyzbnijYjklqwB
# Sru+cakXW2dg3viSkR4dPf0gz3N9QZpGdc3EXzTdEonW/aUgfX782Z5F37ZyL9t9
# X4C626p+Nuw2TPYrbqgSUei/BQOj0XOmTTd0lBw0gg/wEPK3Rxjtp+iZfD9M269e
# wvPV2HM9Q07BMzlMjgK8QmguEOqEUUbi0b1qGFphAXPKZ6Je1yh2AuIzGHLXpyDw
# wvoSCtdjbwzJNmSLW6CmgyFdXzB0kZSU2LlQ+QuJYfM2BjUYhEfb3BvR/bLUHMVr
# 9lxSUV0S2yW6r1AFemzFER1y7435UsSFF5PAPBXbGjfHCBUYP3irRbb1Hode2o+e
# FnJpxq57t7c+auIurQIDAQABo4IB3TCCAdkwEgYJKwYBBAGCNxUBBAUCAwEAATAj
# BgkrBgEEAYI3FQIEFgQUKqdS/mTEmr6CkTxGNSnPEP8vBO4wHQYDVR0OBBYEFJ+n
# FV0AXmJdg/Tl0mWnG1M1GelyMFwGA1UdIARVMFMwUQYMKwYBBAGCN0yDfQEBMEEw
# PwYIKwYBBQUHAgEWM2h0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvRG9j
# cy9SZXBvc2l0b3J5Lmh0bTATBgNVHSUEDDAKBggrBgEFBQcDCDAZBgkrBgEEAYI3
# FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAf
# BgNVHSMEGDAWgBTV9lbLj+iiXGJo0T2UkFvXzpoYxDBWBgNVHR8ETzBNMEugSaBH
# hkVodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtpL2NybC9wcm9kdWN0cy9NaWNS
# b29DZXJBdXRfMjAxMC0wNi0yMy5jcmwwWgYIKwYBBQUHAQEETjBMMEoGCCsGAQUF
# BzAChj5odHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY1Jvb0Nl
# ckF1dF8yMDEwLTA2LTIzLmNydDANBgkqhkiG9w0BAQsFAAOCAgEAnVV9/Cqt4Swf
# ZwExJFvhnnJL/Klv6lwUtj5OR2R4sQaTlz0xM7U518JxNj/aZGx80HU5bbsPMeTC
# j/ts0aGUGCLu6WZnOlNN3Zi6th542DYunKmCVgADsAW+iehp4LoJ7nvfam++Kctu
# 2D9IdQHZGN5tggz1bSNU5HhTdSRXud2f8449xvNo32X2pFaq95W2KFUn0CS9QKC/
# GbYSEhFdPSfgQJY4rPf5KYnDvBewVIVCs/wMnosZiefwC2qBwoEZQhlSdYo2wh3D
# YXMuLGt7bj8sCXgU6ZGyqVvfSaN0DLzskYDSPeZKPmY7T7uG+jIa2Zb0j/aRAfbO
# xnT99kxybxCrdTDFNLB62FD+CljdQDzHVG2dY3RILLFORy3BFARxv2T5JL5zbcqO
# Cb2zAVdJVGTZc9d/HltEAY5aGZFrDZ+kKNxnGSgkujhLmm77IVRrakURR6nxt67I
# 6IleT53S0Ex2tVdUCbFpAUR+fKFhbHP+CrvsQWY9af3LwUFJfn6Tvsv4O+S3Fb+0
# zj6lMVGEvL8CwYKiexcdFYmNcP7ntdAoGokLjzbaukz5m/8K6TT4JDVnK+ANuOaM
# mdbhIurwJ0I9JZTmdHRbatGePu1+oDEzfbzL6Xu/OHBE0ZDxyKs6ijoIYn/ZcGNT
# TY3ugm2lBRDBcQZqELQdVTNYs6FwZvKhggLLMIICNAIBATCB+KGB0KSBzTCByjEL
# MAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1v
# bmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjElMCMGA1UECxMcTWlj
# cm9zb2Z0IEFtZXJpY2EgT3BlcmF0aW9uczEmMCQGA1UECxMdVGhhbGVzIFRTUyBF
# U046REQ4Qy1FMzM3LTJGQUUxJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1w
# IFNlcnZpY2WiIwoBATAHBgUrDgMCGgMVACEAGvYXZJK7cUo62+LvEYQEx7/noIGD
# MIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNV
# BAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQG
# A1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAwDQYJKoZIhvcNAQEF
# BQACBQDoCKP5MCIYDzIwMjMwNTEyMTkzOTM3WhgPMjAyMzA1MTMxOTM5MzdaMHQw
# OgYKKwYBBAGEWQoEATEsMCowCgIFAOgIo/kCAQAwBwIBAAICDyowBwIBAAICEccw
# CgIFAOgJ9XkCAQAwNgYKKwYBBAGEWQoEAjEoMCYwDAYKKwYBBAGEWQoDAqAKMAgC
# AQACAwehIKEKMAgCAQACAwGGoDANBgkqhkiG9w0BAQUFAAOBgQBulqHiPnqK0b1m
# mjGDI6XhI05RJhmdKu8Osj8eu9ZrxvIkkJwVQO1jeBCKOf81WQxvvhlq60H+A+56
# FkkPTuCsuU6QoZ6g5vnJyUB8VDoUrogl5ZXYfOb5G6MI9tIvpgfdddnd1Adkt3NF
# NCJ3SHzvaRFRErmIqelGsjWkSSrWgjGCBA0wggQJAgEBMIGTMHwxCzAJBgNVBAYT
# AlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYD
# VQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBU
# aW1lLVN0YW1wIFBDQSAyMDEwAhMzAAABxQPNzSGh9O85AAEAAAHFMA0GCWCGSAFl
# AwQCAQUAoIIBSjAaBgkqhkiG9w0BCQMxDQYLKoZIhvcNAQkQAQQwLwYJKoZIhvcN
# AQkEMSIEIDEGMMLej6BZebf/qFs6eaBCB/KG12GrujcASLj/mVhPMIH6BgsqhkiG
# 9w0BCRACLzGB6jCB5zCB5DCBvQQgGQGxkfYkd0wK+V09wO0sO+sm8gAMyj5EuKPq
# vNQ/fLEwgZgwgYCkfjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3Rv
# bjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0
# aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMAITMwAA
# AcUDzc0hofTvOQABAAABxTAiBCCP9ZuZWJp6xVgpra1PN8Xo2tidVQisZu03er18
# +pt2GzANBgkqhkiG9w0BAQsFAASCAgBVR5WXku6vqykYl9UsKVfKCS6AuUGqa9at
# J/2z2NRzFHJ1/hq9/x2H5rezOVIASLRgx98628E3umg8WpDeFh+JE2lnEuWIa5IH
# GQ9zkfP+XFzT/7VKUkOBpZ44MsuH+ScxwLZ5hH2CJdTdI6ramL+MZrRfrYnK9I/5
# If0yZ31nFcgCVaHswAITbCsn69U7XrL9X7h9A1v8M/6LYlrC1AS0y4uEsMf2NyTU
# Me7PNPA+CLaP0kPO/aNvV/OSJxKQx6yCK86kusbiBeO3x75W5EcfXKvR0G26pivc
# kJxmrY1/P7BeEbrJnoLzrZOGne/yqdYpx2mghcZRrqnEc3XzzElz9/Z0uvELBErr
# h3N83/JaA7ycP6mZvmD42/Q4IucMKZknJJ1xShVq7a7GDSxTAE+l2OzX9dArbQbb
# vIPUKMnAW1LwcrAm27jHMsD3rmVef5MwgENl1FO67XbUpmf3Rj6lJdfFmEBYYQ4p
# I/LQNqRudIpdloFV934iRRITbpmWIh5+XrvK6030n6PSvBuyVRAnVcVgOHIMF6Zy
# Ex2KaYuNPkuNMfCPoI+Rh5syJ++K/IBzdzUCUTd5dI5OX/L+XT3Ae2CWFtRyd1wR
# p8bIT2XEMnyGe7bxPprZ074NxaptgEW9CJRVWyg0fL9HUhNqXV7AVO57omew00qV
# seTQQfCFLQ==
# SIG # End signature block
