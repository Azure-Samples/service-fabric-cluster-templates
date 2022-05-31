# Standard SKU Service Fabric managed cluster, 1 node type

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2FSF-Managed-Standard-SKU-1-NT-MI%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2FSF-Managed-Standard-SKU-1-NT-MI%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This example has 2 templates:

1.  **Managed identity and role assignment**: Template to create the managed identity and the role assignment to allow Service Fabric RP to assign the identity to the managed cluster's virtual machine scale set. This should be deployed only once before using the managed identity on the node type resource.

2. **Managed cluster and node type**: Template for the service fabric managed cluster using the *Standard* SKU and containing a single node type type running *Windows Server 2019 Datacenter* on a *Standard_D2s_v3* size virtual machine scale set resources, using the user-assigned managed identity created before.

## Use Powershell to deploy your cluster

1. Deploy managed identity and role assignment.

```powershell
New-AzResourceGroupDeployment -ResourceGroupName <managedIdentityRGName> -TemplateFile ".\managedIdentityAndSfrpRoleAssignment.json" -TemplateParameterFile ".\managedIdentityAndSfrpRoleAssignment.Parameters.json" -Verbose
```

2. Deploy the node type resource assigning the identity

```powershell
New-AzResourceGroupDeployment -ResourceGroupName <sfmcRGName> -TemplateFile ".\sfmcVmManagedIdentity.json" -TemplateParameterFile ".\sfmcVmManagedIdentity.Parameters.json" -Verbose
```

Generate a new GUID for the parameter **vmIdentityRoleNameGuid** (it can be generated in powershell using [Guid]::NewGuid()) and if you deploy again the same template including the role assignment, make sure the GUID is the same as the one originally used or remove this resource as it just needs to be created once.

## Resources

For more info, see:

- [Service Fabric managed cluster quickstart](https://docs.microsoft.com/azure/service-fabric/quickstart-managed-cluster-template) for a walkthrough of the base ARM template without a managed identity added.

- [How to add a managed identity to a managed cluster node type](https://docs.microsoft.com/azure/service-fabric/how-to-managed-identity-managed-cluster-virtual-machine-scale-sets) for discussion of this template and steps to add a managed identity to a node type on a Service Fabric managed cluster.

- [Service Fabric managed cluster overview](https://docs.microsoft.com/azure/service-fabric/overview-managed-cluster) for more details on cluster SKUs.

- [Service Fabric managed cluster template format](https://docs.microsoft.com/azure/templates/microsoft.servicefabric/2021-05-01/managedclusters) for more details on modifying this ARM template to meet your requirements.
