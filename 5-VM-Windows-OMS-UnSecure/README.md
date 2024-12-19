# 5 Node - Windows - OMS - Unsecure

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2F5-VM-Windows-OMS-UnSecure%2Fsfclusteroms.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2F5-VM-Windows-OMS-UnSecure%2Fsfclusteroms.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This test template allows you to deploy an unsecure 5 node cluster with OMS Log Analytics configured. Specifically, the template configures the following:

* Creates a 5 node Service Fabric cluster
* Creates a Log Analytics workspace and Service Fabric solution
* Configures the OMS Agent to collect and send 2 sample performance counters to to the workspace
* Configures WAD to collect Service Fabric and sends them to Azure storage tables (WADServiceFabric*EventTable)
* Configures the Log Analytics workspace to read the events from these tables


## Use Powershell to deploy this template

You can go through the process of creating the cluster as described in [Creating Service Fabric Cluster via ARM](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-creation-via-arm)

You can also use the `New-AzResourceGroupDeployment` Powershell command if you have the Azure PowerShell prerequisites in the link above. 

```Powershell
New-AzResourceGroupDeployment -ResourceGroupName "<resourceGroupName>" -TemplateFile "<templatefile>.json"
```

## Creating a custom ARM template

If you are wanting to create a custom ARM template for your cluster, then you have two choices.

1. You can acquire this sample template make changes to it. 
2. Log into the azure portal and use the service fabric portal pages to generate the template for you to customize.
  * Log on to the Azure Portal [http://aka.ms/servicefabricportal](http://aka.ms/servicefabricportal).

  * Go through the process of creating the cluster as described in [Creating Service Fabric Cluster via portal](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-creation-via-portal) , but do not click on **create**, instead go to Summary and download the template and parameters.