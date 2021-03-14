# 15VM- 2 Node Types, Stateless CrossAZ Secure Windows Service Fabric Cluster

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2F15-VM-2-NodeTypes-Windows-Stateless-CrossAZ-Secure%2FAzureDeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2F15-VM-2-NodeTypes-Windows-Stateless-CrossAZ-Secure%2FAzureDeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This test template allows you to deploy a secure 10 node, 2 Node Types Service Fabric Cluster, with Non Primary node type optimized for running Stateless workloads, running Windows Server 2016 Datacenter with containers on a Standard_D2_v2 Size Virtual Machine Scale set.

The main intent for this template is to show how you can specify node types to host only Stateless workloads. 

## Note on Stateless Node Type Support
1. Stateless only Node Type is supported only on SF cluster code version 7.1.409 and above.
2. Durability of the Node Type for Stateless support should be Bronze.


## Use Powershell to deploy your cluster

Go through the process of creating the cluster as described in [Creating Service Fabric Cluster via arm](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-creation-via-arm)


## Creating a custom ARM template

If you are wanting to create a custom ARM template for your cluster, then you have two choices.

1. You can acquire this sample template make changes to it. 
2. Log into the azure portal and use the service fabric portal pages to generate the template for you to customize.
  * Log on to the Azure Portal [http://aka.ms/servicefabricportal](http://aka.ms/servicefabricportal).

  * Go through the process of creating the cluster as described in [Creating Service Fabric Cluster via portal](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-creation-via-portal) , but do not click on **create**, instead go to Summary and download the template and parameters.


 ![DownloadTemplate]


Unzip the downloaded .zip on your local machine, make any changes to template or the parameter file as you need.


<!-- Links -->
[azure-powershell]:https://azure.microsoft.com/documentation/articles/powershell-install-configure/
[azure-CLI]:https://docs.microsoft.com/en-us/cli/azure/get-started-with-azure-cli?view=azure-cli-latest

<!--Image references-->
[DownloadTemplate]: ./DownloadTemplate.png
[NSG3]: ./NSG3.PNG
[NSG2]: ./NSG2.PNG
[DownloadCert]: ./DownloadCert.PNG




