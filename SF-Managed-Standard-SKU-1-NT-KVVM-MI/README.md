# Standard SKU Service Fabric managed cluster, 1 node type with Key Vault virtual machine extension (KVVM) enabled

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2FSF-Managed-Standard-SKU-1-NT-KVVM-MI%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2FSF-Managed-Standard-SKU-1-NT-KVVM-MI%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template allows you to deploy a Service Fabric managed cluster using the *Standard* SKU. This cluster contains a single node type running *Windows Server 2022 Datacenter* on a *Standard_D2s_v3* size virtual machine scale set with [Key Vault virtual machine extension](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-windows) enabled. KVVM extension provides certificate provisioning and management for certificates in Azure key vault. To provision entirely in ARM only 'User assigned managed identity' is supported in ARM templates for managed clusters. System assigned identity can be used but must be provisioned outside of ARM template deployment. See [../SF-Managed-Standard-SKU-1-NT-KVVM/README.md](../SF-Managed-Standard-SKU-1-NT-KVVM/README.md) to use KVVM with 'System assigned managed identity'. This template will provision a user assigned managed identity in addition to the KVVM extension. If providing a value for parameter 'keyVaultResourceId' the new user assigned identity will be added to the specified key vault resource id with configured permissions. See [Resources](#resources) for additional information.

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

Go through the process of creating the cluster as described in [Deploy a Service Fabric managed cluster](https://docs.microsoft.com/azure/service-fabric/tutorial-managed-cluster-deploy)

## Resources

For more info, see:

- [Add a managed identity to a Service Fabric managed cluster node type](https://docs.microsoft.com/azure/service-fabric/how-to-managed-identity-managed-cluster-virtual-machine-scale-sets)

- [Virtual machine scale set extension support on Service Fabric managed cluster node type(s)](https://docs.microsoft.com/azure/service-fabric/how-to-managed-cluster-vmss-extension)

- [Service Fabric managed cluster overview](https://docs.microsoft.com/azure/service-fabric/overview-managed-cluster) for details on managed clusters.

- [Service Fabric managed cluster template format](https://docs.microsoft.com/azure/templates/microsoft.servicefabric/2021-05-01/managedclusters) for more details on modifying this ARM template to meet your requirements.

- [List Azure Role Definitions](https://docs.microsoft.com/azure/role-based-access-control/role-definitions-list) for additional information about Role Definitions and Assignments.
