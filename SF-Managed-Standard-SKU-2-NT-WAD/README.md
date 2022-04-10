# Standard SKU Service Fabric managed cluster, 2 node types with Windows Azure Diagnostics (WAD) enabled

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2FSF-Managed-Standard-SKU-1-NT-AzureMonitor%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2FSF-Managed-Standard-SKU-1-NT-AzureMonitor%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template allows you to deploy a Service Fabric managed cluster using the *Standard* SKU. This cluster contains two node types running *Windows Server 2019 Datacenter* on a *Standard_D2s_v3* size virtual machine scale set with Windows Azure Diagnostics (WAD) enabled. WAD currently provides the most comprehensive level of monitoring that can cover: events, counters, Event Tracing for Windows (ETW) as well as other information. Managed Identity read and assign Role Assignment is required for access from nodetype nodes to diagnostics storage account. 'f1a07417-d97a-45cb-824c-7a7467783830' is the Role Definition Id. See [Resources](#resources) for additional information.

To enumerate Service Fabric Resource Provider (SFRP) Id for subscription, execute the following powershell commands and select 'Id' value. This Id is used in template for parameter 'subscriptionSFRPId'.  

**NOTE: The 'Id' value is different for each Azure subscription:**

```powershell
Login-AzAccount
Select-AzSubscription -SubscriptionId {{subscription id}}
Get-AzADServicePrincipal -DisplayName "Azure Service Fabric Resource Provider"

DisplayName                              Id                                     AppId
-----------                              --                                     -----
'Azure Service Fabric Resource Provider' '39276235-4e4a-43f0-8523-ff0de6cbe12a' 'ac0b81e8-b54c-46e1-8b00-ce4aed8ba469'
```

For reference, to enumerate role definition, use the following. 'f1a07417-d97a-45cb-824c-7a7467783830' is the value to be used in template for parameter 'roleDefinitionId'.  

```powershell
PS C:\> get-azroledefinition | where id -ieq 'f1a07417-d97a-45cb-824c-7a7467783830'

Name             : Managed Identity Operator
Id               : 'f1a07417-d97a-45cb-824c-7a7467783830'
IsCustom         : False
Description      : Read and Assign User Assigned Identity
Actions          : {Microsoft.ManagedIdentity/userAssignedIdentities/*/read, Microsoft.ManagedIdentity/userAssignedIdentities/*/assign/action,
                   Microsoft.Authorization/*/read, Microsoft.Insights/alertRules/*…}
NotActions       : {}
DataActions      : {}
NotDataActions   : {}
AssignableScopes : {/}
```

## Use Powershell to deploy your cluster

Go through the process of creating the cluster as described in [Creating Service Fabric Cluster via arm](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-creation-via-arm)

## Resources

For more info, see:

- [Service Fabric managed cluster overview](https://docs.microsoft.com/azure/service-fabric/overview-managed-cluster) for details on managed clusters.

- [Service Fabric managed cluster template format](https://docs.microsoft.com/azure/templates/microsoft.servicefabric/2021-05-01/managedclusters) for more details on modifying this ARM template to meet your requirements.

- [Overview of Azure Monitor agents](https://docs.microsoft.com/azure/azure-monitor/agents/agents-overview) for a summary of different monitoring agents available and capabilities.

- [Performance monitoring with the Windows Azure Diagnostics extension](https://docs.microsoft.com/azure/service-fabric/service-fabric-diagnostics-perf-wad) for service fabric specific ETW and metric configuration information.

- [Windows Diagnostics Extension Schema](https://docs.microsoft.com/azure/azure-monitor/agents/diagnostics-extension-schema-windows) for WadCfg schema definition information.

- [List Azure Role Definitions](https://docs.microsoft.com/azure/role-based-access-control/role-definitions-list) for additional information about Role Definitions and Assignments.
