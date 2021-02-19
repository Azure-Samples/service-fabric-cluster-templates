# Standard SKU Service Fabric managed cluster, 1 node type with disk encryption enabled

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2FSF-Managed-Standard-SKU-1-NT-DiskEncryption%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2FSF-Managed-Standard-SKU-1-NT-DiskEncryption%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template allows you to deploy a Service Fabric managed cluster using the *Standard* SKU. This cluster contains a single node type running *Windows Server 2019 Datacenter* on a *Standard_D2_v2* size virtual machine scale set with disk encryption enabled.

## Resources

For more info, see:

- [Enable disk encryption for Service Fabric managed cluster nodes](https://docs.microsoft.com/azure/service-fabric/how-to-enable-managed-cluster-disk-encryption) for a walkthrough of the template changes required to enable disk encryption.

- [Service Fabric managed cluster overview](https://docs.microsoft.com/azure/service-fabric/overview-managed-cluster) for details on managed clusters.

- [Service Fabric managed cluster template format](https://docs.microsoft.com/azure/templates/microsoft.servicefabric/2020-01-01-preview/managedclusters) for more details on modifying this ARM template to meet your requirements.
