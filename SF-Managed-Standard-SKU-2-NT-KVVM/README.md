# Standard SKU Service Fabric managed cluster, 2 node types with Key Vault virtual machine extension (KVVM) enabled

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2FSF-Managed-Standard-SKU-2-NT-KVVM%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2FSF-Managed-Standard-SKU-2-NT-KVVM%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template allows you to deploy a Service Fabric managed cluster using the *Standard* SKU. This cluster contains a two node types running *Windows Server 2022 Datacenter* on a *Standard_D2s_v3* size virtual machine scale set with [Key Vault virtual machine extension](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-windows) enabled. KVVM extension provides certificate provisioning and management for certificates in Azure key vault. To provision entirely in ARM only 'User assigned managed identity' is supported in ARM templates for managed clusters. System assigned identity can be used but must be provisioned outside of ARM template deployment. See [../SF-Managed-Standard-SKU-2-NT-KVVM-MI/README.md](../SF-Managed-Standard-SKU-2-NT-KVVM-MI/README.md) to use KVVM with 'User assigned identity'. This template will provision a managed cluster with KVVM extension. After template deployment, navigate to the provisioned nodetype located in 'SFC_{{cluster deployment id}}' resource group in Azure portal. Select 'Identity' and turn on 'System assigned' identity. For the Azure key vault being accessed, in 'Access Policies' enable RBAC and assign the nodetype with certificate and secret read permissions. KVVM extension will not be able to access these key vault until this is performed, therefore, in ARM template, ensure 'requireInitialSync' is set to 'false' for the KVVM extension or deployment will fail.

## Use Powershell to deploy your cluster

Go through the process of creating the cluster as described in [Deploy a Service Fabric managed cluster](https://docs.microsoft.com/azure/service-fabric/tutorial-managed-cluster-deploy)

## Resources

For more info, see:

- [Add a managed identity to a Service Fabric managed cluster node type](https://docs.microsoft.com/azure/service-fabric/how-to-managed-identity-managed-cluster-virtual-machine-scale-sets)

- [Virtual machine scale set extension support on Service Fabric managed cluster node type(s)](https://docs.microsoft.com/azure/service-fabric/how-to-managed-cluster-vmss-extension)

- [Service Fabric managed cluster overview](https://docs.microsoft.com/azure/service-fabric/overview-managed-cluster) for details on managed clusters.

- [Service Fabric managed cluster template format](https://docs.microsoft.com/azure/templates/microsoft.servicefabric/2021-05-01/managedclusters) for more details on modifying this ARM template to meet your requirements.

- [List Azure Role Definitions](https://docs.microsoft.com/azure/role-based-access-control/role-definitions-list) for additional information about Role Definitions and Assignments.
