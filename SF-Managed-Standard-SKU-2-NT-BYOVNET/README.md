# Standard SKU Service Fabric managed cluster, 2 node types, deployed in to existing subnet

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2FSF-Managed-Standard-SKU-2-NT-BYOVNET%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2FSF-Managed-Standard-SKU-2-NT-BYOVNET%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template allows you to deploy a Service Fabric managed cluster in to an existing subnet using the *Standard* SKU. This cluster contains two node types running *Windows Server 2019 Datacenter* on *Standard_D2s_v3* size virtual machine scale sets.

You *must* have an existing subnet for this to work. See [Bring your own virtual network documentation](https://docs.microsoft.com/azure/service-fabric/how-to-managed-cluster-networking#bring-your-own-virtual-network) for more details.

## Use Powershell to deploy your cluster

Go through the process of creating the cluster as described in [Creating Service Fabric Cluster via arm](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-creation-via-arm)

## Resources

For more info, see:

- [Service Fabric managed cluster quickstart](https://docs.microsoft.com/azure/service-fabric/quickstart-managed-cluster-template) for a walkthrough of the ARM template.

- [Service Fabric managed cluster overview](https://docs.microsoft.com/azure/service-fabric/overview-managed-cluster) for more details on cluster SKUs.

- [Service Fabric managed cluster template format](https://docs.microsoft.com/azure/templates/microsoft.servicefabric/2021-07-01-preview/managedclusters) for more details on modifying this ARM template to meet your requirements.
