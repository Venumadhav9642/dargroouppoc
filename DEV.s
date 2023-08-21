{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "sites_rg-dargroup-dev": {
            "defaultValue": "rg-dargroup-dev",
            "type": "String"
        },
        "components_rg-dargroup-dev": {
            "defaultValue": "rg-dargroup-dev",
            "type": "String"
        },
        "serverfarms_rg-dargroup-app-dev_name": {
            "defaultValue": "rg-dargroup-app-dev",
            "type": "String"
        },
        "actionGroups_Application_Insights_Smart_Detection_name": {
            "defaultValue": "Application Insights Smart Detection",
            "type": "String"
        },
        "smartdetectoralertrules_failure_anomalies___rg-dargroup-dev": {
            "defaultValue": "failure anomalies - rg-dargroup-dev",
            "type": "String"
        },
        "workspaces_DefaultWorkspace_42c342a3_b2db_4152_8914_f87ba358e0ff_CID_externalid": {
            "defaultValue": "/subscriptions/42c342a3-b2db-4152-8914-f87ba358e0ff/resourceGroups/DefaultResourceGroup-CID/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-42c342a3-b2db-4152-8914-f87ba358e0ff-CID",
            "type": "String"
        }
    },
    "variables": {},
    "resources": [
        {
            "type": "microsoft.insights/actionGroups",
            "apiVersion": "2023-01-01",
            "name": "[parameters('actionGroups_Application_Insights_Smart_Detection_name')]",
            "location": "Global",
            "properties": {
                "groupShortName": "SmartDetect",
                "enabled": true,
                "emailReceivers": [],
                "smsReceivers": [],
                "webhookReceivers": [],
                "eventHubReceivers": [],
                "itsmReceivers": [],
                "azureAppPushReceivers": [],
                "automationRunbookReceivers": [],
                "voiceReceivers": [],
                "logicAppReceivers": [],
                "azureFunctionReceivers": [],
                "armRoleReceivers": [
                    {
                        "name": "Monitoring Contributor",
                        "roleId": "749f88d5-cbae-40b8-bcfc-e573ddc772fa",
                        "useCommonAlertSchema": true
                    },
                    {
                        "name": "Monitoring Reader",
                        "roleId": "43d0d8ad-25c7-4714-9337-8ba259a9fe05",
                        "useCommonAlertSchema": true
                    }
                ]
            }
        },
        {
            "type": "microsoft.insights/components",
            "apiVersion": "2020-02-02",
            "name": "[parameters('components_rg-dargroup-dev')]",
            "location": "centralindia",
            "tags": {
                "environment": "POC"
            },
            "kind": "web",
            "properties": {
                "Application_Type": "web",
                "Flow_Type": "Redfield",
                "Request_Source": "IbizaWebAppExtensionCreate",
                "RetentionInDays": 90,
                "WorkspaceResourceId": "[parameters('workspaces_DefaultWorkspace_42c342a3_b2db_4152_8914_f87ba358e0ff_CID_externalid')]",
                "IngestionMode": "LogAnalytics",
                "publicNetworkAccessForIngestion": "Enabled",
                "publicNetworkAccessForQuery": "Enabled"
            }
        },
        {
            "type": "Microsoft.Web/serverfarms",
            "apiVersion": "2022-09-01",
            "name": "[parameters('serverfarms_rg-dargroup-app-dev_name')]",
            "location": "Central India",
            "tags": {
                "environment": "dev"
            },
            "sku": {
                "name": "F1",
                "tier": "Free",
                "size": "F1",
                "family": "F",
                "capacity": 0
            },
            "kind": "app",
            "properties": {
                "perSiteScaling": false,
                "elasticScaleEnabled": false,
                "maximumElasticWorkerCount": 1,
                "isSpot": false,
                "reserved": false,
                "isXenon": false,
                "hyperV": false,
                "targetWorkerCount": 0,
                "targetWorkerSizeId": 0,
                "zoneRedundant": false
            }
        },
        {
            "type": "microsoft.insights/components/ProactiveDetectionConfigs",
            "apiVersion": "2018-05-01-preview",
            "name": "[concat(parameters('components_rg-dargroup-dev'), '/degradationindependencyduration')]",
            "location": "centralindia",
            "dependsOn": [
                "[resourceId('microsoft.insights/components', parameters('components_rg-dargroup-dev'))]"
            ],
            "properties": {
                "ruleDefinitions": {
                    "Name": "degradationindependencyduration",
                    "DisplayName": "Degradation in dependency duration",
                    "Description": "Smart Detection rules notify you of performance anomaly issues.",
                    "HelpUrl": "https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics",
                    "IsHidden": false,
                    "IsEnabledByDefault": true,
                    "IsInPreview": false,
                    "SupportsEmailNotifications": true
                },
                "enabled": true,
                "sendEmailsToSubscriptionOwners": true,
                "customEmails": []
            }
        },
        {
            "type": "microsoft.insights/components/ProactiveDetectionConfigs",
            "apiVersion": "2018-05-01-preview",
            "name": "[concat(parameters('components_rg-dargroup-dev'), '/degradationinserverresponsetime')]",
            "location": "centralindia",
            "dependsOn": [
                "[resourceId('microsoft.insights/components', parameters('components_rg-dargroup-dev'))]"
            ],
            "properties": {
                "ruleDefinitions": {
                    "Name": "degradationinserverresponsetime",
                    "DisplayName": "Degradation in server response time",
                    "Description": "Smart Detection rules notify you of performance anomaly issues.",
                    "HelpUrl": "https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics",
                    "IsHidden": false,
                    "IsEnabledByDefault": true,
                    "IsInPreview": false,
                    "SupportsEmailNotifications": true
                },
                "enabled": true,
                "sendEmailsToSubscriptionOwners": true,
                "customEmails": []
            }
        },
        {
            "type": "microsoft.insights/components/ProactiveDetectionConfigs",
            "apiVersion": "2018-05-01-preview",
            "name": "[concat(parameters('components_rg-dargroup-dev'), '/digestMailConfiguration')]",
            "location": "centralindia",
            "dependsOn": [
                "[resourceId('microsoft.insights/components', parameters('components_rg-dargroup-dev'))]"
            ],
            "properties": {
                "ruleDefinitions": {
                    "Name": "digestMailConfiguration",
                    "DisplayName": "Digest Mail Configuration",
                    "Description": "This rule describes the digest mail preferences",
                    "HelpUrl": "www.homail.com",
                    "IsHidden": true,
                    "IsEnabledByDefault": true,
                    "IsInPreview": false,
                    "SupportsEmailNotifications": true
                },
                "enabled": true,
                "sendEmailsToSubscriptionOwners": true,
                "customEmails": []
            }
        },
        {
            "type": "microsoft.insights/components/ProactiveDetectionConfigs",
            "apiVersion": "2018-05-01-preview",
            "name": "[concat(parameters('components_rg-dargroup-dev'), '/extension_billingdatavolumedailyspikeextension')]",
            "location": "centralindia",
            "dependsOn": [
                "[resourceId('microsoft.insights/components', parameters('components_rg-dargroup-dev'))]"
            ],
            "properties": {
                "ruleDefinitions": {
                    "Name": "extension_billingdatavolumedailyspikeextension",
                    "DisplayName": "Abnormal rise in daily data volume (preview)",
                    "Description": "This detection rule automatically analyzes the billing data generated by your application, and can warn you about an unusual increase in your application's billing costs",
                    "HelpUrl": "https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/billing-data-volume-daily-spike.md",
                    "IsHidden": false,
                    "IsEnabledByDefault": true,
                    "IsInPreview": true,
                    "SupportsEmailNotifications": false
                },
                "enabled": true,
                "sendEmailsToSubscriptionOwners": true,
                "customEmails": []
            }
        },
        {
            "type": "microsoft.insights/components/ProactiveDetectionConfigs",
            "apiVersion": "2018-05-01-preview",
            "name": "[concat(parameters('components_rg-dargroup-dev'), '/extension_canaryextension')]",
            "location": "centralindia",
            "dependsOn": [
                "[resourceId('microsoft.insights/components', parameters('components_rg-dargroup-dev'))]"
            ],
            "properties": {
                "ruleDefinitions": {
                    "Name": "extension_canaryextension",
                    "DisplayName": "Canary extension",
                    "Description": "Canary extension",
                    "HelpUrl": "https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/",
                    "IsHidden": true,
                    "IsEnabledByDefault": true,
                    "IsInPreview": true,
                    "SupportsEmailNotifications": false
                },
                "enabled": true,
                "sendEmailsToSubscriptionOwners": true,
                "customEmails": []
            }
        },
        {
            "type": "microsoft.insights/components/ProactiveDetectionConfigs",
            "apiVersion": "2018-05-01-preview",
            "name": "[concat(parameters('components_rg-dargroup-dev'), '/extension_exceptionchangeextension')]",
            "location": "centralindia",
            "dependsOn": [
                "[resourceId('microsoft.insights/components', parameters('components_rg-dargroup-dev'))]"
            ],
            "properties": {
                "ruleDefinitions": {
                    "Name": "extension_exceptionchangeextension",
                    "DisplayName": "Abnormal rise in exception volume (preview)",
                    "Description": "This detection rule automatically analyzes the exceptions thrown in your application, and can warn you about unusual patterns in your exception telemetry.",
                    "HelpUrl": "https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/abnormal-rise-in-exception-volume.md",
                    "IsHidden": false,
                    "IsEnabledByDefault": true,
                    "IsInPreview": true,
                    "SupportsEmailNotifications": false
                },
                "enabled": true,
                "sendEmailsToSubscriptionOwners": true,
                "customEmails": []
            }
        },
        {
            "type": "microsoft.insights/components/ProactiveDetectionConfigs",
            "apiVersion": "2018-05-01-preview",
            "name": "[concat(parameters('components_rg-dargroup-dev'), '/extension_memoryleakextension')]",
            "location": "centralindia",
            "dependsOn": [
                "[resourceId('microsoft.insights/components', parameters('components_rg-dargroup-dev'))]"
            ],
            "properties": {
                "ruleDefinitions": {
                    "Name": "extension_memoryleakextension",
                    "DisplayName": "Potential memory leak detected (preview)",
                    "Description": "This detection rule automatically analyzes the memory consumption of each process in your application, and can warn you about potential memory leaks or increased memory consumption.",
                    "HelpUrl": "https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/memory-leak.md",
                    "IsHidden": false,
                    "IsEnabledByDefault": true,
                    "IsInPreview": true,
                    "SupportsEmailNotifications": false
                },
                "enabled": true,
                "sendEmailsToSubscriptionOwners": true,
                "customEmails": []
            }
        },
        {
            "type": "microsoft.insights/components/ProactiveDetectionConfigs",
            "apiVersion": "2018-05-01-preview",
            "name": "[concat(parameters('components_rg-dargroup-dev'), '/extension_securityextensionspackage')]",
            "location": "centralindia",
            "dependsOn": [
                "[resourceId('microsoft.insights/components', parameters('components_rg-dargroup-dev'))]"
            ],
            "properties": {
                "ruleDefinitions": {
                    "Name": "extension_securityextensionspackage",
                    "DisplayName": "Potential security issue detected (preview)",
                    "Description": "This detection rule automatically analyzes the telemetry generated by your application and detects potential security issues.",
                    "HelpUrl": "https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/application-security-detection-pack.md",
                    "IsHidden": false,
                    "IsEnabledByDefault": true,
                    "IsInPreview": true,
                    "SupportsEmailNotifications": false
                },
                "enabled": true,
                "sendEmailsToSubscriptionOwners": true,
                "customEmails": []
            }
        },
        {
            "type": "microsoft.insights/components/ProactiveDetectionConfigs",
            "apiVersion": "2018-05-01-preview",
            "name": "[concat(parameters('components_rg-dargroup-dev'), '/extension_traceseveritydetector')]",
            "location": "centralindia",
            "dependsOn": [
                "[resourceId('microsoft.insights/components', parameters('components_rg-dargroup-dev'))]"
            ],
            "properties": {
                "ruleDefinitions": {
                    "Name": "extension_traceseveritydetector",
                    "DisplayName": "Degradation in trace severity ratio (preview)",
                    "Description": "This detection rule automatically analyzes the trace logs emitted from your application, and can warn you about unusual patterns in the severity of your trace telemetry.",
                    "HelpUrl": "https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/degradation-in-trace-severity-ratio.md",
                    "IsHidden": false,
                    "IsEnabledByDefault": true,
                    "IsInPreview": true,
                    "SupportsEmailNotifications": false
                },
                "enabled": true,
                "sendEmailsToSubscriptionOwners": true,
                "customEmails": []
            }
        },
        {
            "type": "microsoft.insights/components/ProactiveDetectionConfigs",
            "apiVersion": "2018-05-01-preview",
            "name": "[concat(parameters('components_rg-dargroup-dev'), '/longdependencyduration')]",
            "location": "centralindia",
            "dependsOn": [
                "[resourceId('microsoft.insights/components', parameters('components_rg-dargroup-dev'))]"
            ],
            "properties": {
                "ruleDefinitions": {
                    "Name": "longdependencyduration",
                    "DisplayName": "Long dependency duration",
                    "Description": "Smart Detection rules notify you of performance anomaly issues.",
                    "HelpUrl": "https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics",
                    "IsHidden": false,
                    "IsEnabledByDefault": true,
                    "IsInPreview": false,
                    "SupportsEmailNotifications": true
                },
                "enabled": true,
                "sendEmailsToSubscriptionOwners": true,
                "customEmails": []
            }
        },
        {
            "type": "microsoft.insights/components/ProactiveDetectionConfigs",
            "apiVersion": "2018-05-01-preview",
            "name": "[concat(parameters('components_rg-dargroup-dev'), '/migrationToAlertRulesCompleted')]",
            "location": "centralindia",
            "dependsOn": [
                "[resourceId('microsoft.insights/components', parameters('components_rg-dargroup-dev'))]"
            ],
            "properties": {
                "ruleDefinitions": {
                    "Name": "migrationToAlertRulesCompleted",
                    "DisplayName": "Migration To Alert Rules Completed",
                    "Description": "A configuration that controls the migration state of Smart Detection to Smart Alerts",
                    "HelpUrl": "https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics",
                    "IsHidden": true,
                    "IsEnabledByDefault": false,
                    "IsInPreview": true,
                    "SupportsEmailNotifications": false
                },
                "enabled": false,
                "sendEmailsToSubscriptionOwners": true,
                "customEmails": []
            }
        },
        {
            "type": "microsoft.insights/components/ProactiveDetectionConfigs",
            "apiVersion": "2018-05-01-preview",
            "name": "[concat(parameters('components_rg-dargroup-dev'), '/slowpageloadtime')]",
            "location": "centralindia",
            "dependsOn": [
                "[resourceId('microsoft.insights/components', parameters('components_rg-dargroup-dev'))]"
            ],
            "properties": {
                "ruleDefinitions": {
                    "Name": "slowpageloadtime",
                    "DisplayName": "Slow page load time",
                    "Description": "Smart Detection rules notify you of performance anomaly issues.",
                    "HelpUrl": "https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics",
                    "IsHidden": false,
                    "IsEnabledByDefault": true,
                    "IsInPreview": false,
                    "SupportsEmailNotifications": true
                },
                "enabled": true,
                "sendEmailsToSubscriptionOwners": true,
                "customEmails": []
            }
        },
        {
            "type": "microsoft.insights/components/ProactiveDetectionConfigs",
            "apiVersion": "2018-05-01-preview",
            "name": "[concat(parameters('components_rg-dargroup-dev'), '/slowserverresponsetime')]",
            "location": "centralindia",
            "dependsOn": [
                "[resourceId('microsoft.insights/components', parameters('components_rg-dargroup-dev'))]"
            ],
            "properties": {
                "ruleDefinitions": {
                    "Name": "slowserverresponsetime",
                    "DisplayName": "Slow server response time",
                    "Description": "Smart Detection rules notify you of performance anomaly issues.",
                    "HelpUrl": "https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics",
                    "IsHidden": false,
                    "IsEnabledByDefault": true,
                    "IsInPreview": false,
                    "SupportsEmailNotifications": true
                },
                "enabled": true,
                "sendEmailsToSubscriptionOwners": true,
                "customEmails": []
            }
        },
        {
            "type": "Microsoft.Web/sites",
            "apiVersion": "2022-09-01",
            "name": "[parameters('sites_rg-dargroup-dev')]",
            "location": "Central India",
            "dependsOn": [
                "[resourceId('Microsoft.Web/serverfarms', parameters('serverfarms_rg-dargroup-asp-dev_name'))]"
            ],
            "tags": {
                "environment": "POC"
            },
            "kind": "app",
            "properties": {
                "enabled": true,
                "hostNameSslStates": [
                    {
                        "name": "[concat(parameters('sites_rg-dargroup-dev'), '.azurewebsites.net')]",
                        "sslState": "Disabled",
                        "hostType": "Standard"
                    },
                    {
                        "name": "[concat(parameters('sites_rg-dargroup-dev'), '.scm.azurewebsites.net')]",
                        "sslState": "Disabled",
                        "hostType": "Repository"
                    }
                ],
                "serverFarmId": "[resourceId('Microsoft.Web/serverfarms', parameters('serverfarms_rg-dargroup-asp-dev_name'))]",
                "reserved": false,
                "isXenon": false,
                "hyperV": false,
                "vnetRouteAllEnabled": false,
                "vnetImagePullEnabled": false,
                "vnetContentShareEnabled": false,
                "siteConfig": {
                    "numberOfWorkers": 1,
                    "acrUseManagedIdentityCreds": false,
                    "alwaysOn": false,
                    "http20Enabled": false,
                    "functionAppScaleLimit": 0,
                    "minimumElasticInstanceCount": 0
                },
                "scmSiteAlsoStopped": false,
                "clientAffinityEnabled": true,
                "clientCertEnabled": false,
                "clientCertMode": "Required",
                "hostNamesDisabled": false,
                "customDomainVerificationId": "6DE9E0A530031F51D8B4C1D325F1ED718741079293CE79EEB0F58E3B84BAB32F",
                "containerSize": 0,
                "dailyMemoryTimeQuota": 0,
                "httpsOnly": true,
                "redundancyMode": "None",
                "publicNetworkAccess": "Enabled",
                "storageAccountRequired": false,
                "keyVaultReferenceIdentity": "SystemAssigned"
            }
        },
        {
            "type": "Microsoft.Web/sites/basicPublishingCredentialsPolicies",
            "apiVersion": "2022-09-01",
            "name": "[concat(parameters('sites_rg-dargroup-dev'), '/ftp')]",
            "location": "Central India",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_rg-dargroup-dev'))]"
            ],
            "tags": {
                "environment": "POC"
            },
            "properties": {
                "allow": true
            }
        },
        {
            "type": "Microsoft.Web/sites/basicPublishingCredentialsPolicies",
            "apiVersion": "2022-09-01",
            "name": "[concat(parameters('sites_rg-dargroup-dev'), '/scm')]",
            "location": "Central India",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_rg-dargroup-dev'))]"
            ],
            "tags": {
                "environment": "POC"
            },
            "properties": {
                "allow": true
            }
        },
        {
            "type": "Microsoft.Web/sites/config",
            "apiVersion": "2022-09-01",
            "name": "[concat(parameters('sites_rg-dargroup-dev'), '/web')]",
            "location": "Central India",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_rg-dargroup-dev'))]"
            ],
            "tags": {
                "environment": "POC"
            },
            "properties": {
                "numberOfWorkers": 1,
                "defaultDocuments": [
                    "Default.htm",
                    "Default.html",
                    "Default.asp",
                    "index.htm",
                    "index.html",
                    "iisstart.htm",
                    "default.aspx",
                    "index.php",
                    "hostingstart.html"
                ],
                "netFrameworkVersion": "v4.0",
                "nodeVersion": "~18",
                "requestTracingEnabled": false,
                "remoteDebuggingEnabled": false,
                "httpLoggingEnabled": false,
                "acrUseManagedIdentityCreds": false,
                "logsDirectorySizeLimit": 35,
                "detailedErrorLoggingEnabled": false,
                "publishingUsername": "$rg-dargroup-dev",
                "scmType": "GitHubAction",
                "use32BitWorkerProcess": true,
                "webSocketsEnabled": false,
                "alwaysOn": false,
                "managedPipelineMode": "Integrated",
                "virtualApplications": [
                    {
                        "virtualPath": "/",
                        "physicalPath": "site\\wwwroot",
                        "preloadEnabled": false
                    }
                ],
                "loadBalancing": "LeastRequests",
                "experiments": {
                    "rampUpRules": []
                },
                "autoHealEnabled": false,
                "vnetRouteAllEnabled": false,
                "vnetPrivatePortsCount": 0,
                "publicNetworkAccess": "Enabled",
                "localMySqlEnabled": false,
                "ipSecurityRestrictions": [
                    {
                        "ipAddress": "Any",
                        "action": "Allow",
                        "priority": 2147483647,
                        "name": "Allow all",
                        "description": "Allow all access"
                    }
                ],
                "scmIpSecurityRestrictions": [
                    {
                        "ipAddress": "Any",
                        "action": "Allow",
                        "priority": 2147483647,
                        "name": "Allow all",
                        "description": "Allow all access"
                    }
                ],
                "scmIpSecurityRestrictionsUseMain": false,
                "http20Enabled": false,
                "minTlsVersion": "1.2",
                "scmMinTlsVersion": "1.2",
                "ftpsState": "FtpsOnly",
                "preWarmedInstanceCount": 0,
                "elasticWebAppScaleLimit": 0,
                "functionsRuntimeScaleMonitoringEnabled": false,
                "minimumElasticInstanceCount": 0,
                "azureStorageAccounts": {}
            }
        },
        {
            "type": "Microsoft.Web/sites/hostNameBindings",
            "apiVersion": "2022-09-01",
            "name": "[concat(parameters('sites_rg-dargroup-dev'), '/', parameters('sites_rg-dargroup-dev'), '.azurewebsites.net')]",
            "location": "Central India",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_rg-dargroup-dev'))]"
            ],
            "properties": {
                "siteName": "rg-dargroup-dev",
                "hostNameType": "Verified"
            }
        },
        {
            "type": "microsoft.alertsmanagement/smartdetectoralertrules",
            "apiVersion": "2021-04-01",
            "name": "[parameters('smartdetectoralertrules_failure_anomalies___rg-dargroup-dev')]",
            "location": "global",
            "dependsOn": [
                "[resourceId('microsoft.insights/components', parameters('components_rg-dargroup-dev'))]",
                "[resourceId('microsoft.insights/actionGroups', parameters('actionGroups_Application_Insights_Smart_Detection_name'))]"
            ],
            "properties": {
                "description": "Failure Anomalies notifies you of an unusual rise in the rate of failed HTTP requests or dependency calls.",
                "state": "Enabled",
                "severity": "Sev3",
                "frequency": "PT1M",
                "detector": {
                    "id": "FailureAnomaliesDetector"
                },
                "scope": [
                    "[resourceId('microsoft.insights/components', parameters('components_rg-dargroup-dev'))]"
                ],
                "actionGroups": {
                    "groupIds": [
                        "[resourceId('microsoft.insights/actionGroups', parameters('actionGroups_Application_Insights_Smart_Detection_name'))]"
                    ]
                }
            }
        }
    ]
}
