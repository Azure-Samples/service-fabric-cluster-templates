# 7 Node, 3 nodetype secure Ubuntu 18.04 Service Fabric Cluster with Azure Diagnostics enabled

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2F7-VM-Ubuntu-3-NodeTypes-Secure%2FAzureDeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2F7-VM-Ubuntu-3-NodeTypes-Secure%2FAzureDeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template allows you to deploy a secure 7 Node,three Node Type Service Fabric Cluster running Ubuntu Server on a Standard_D2_v2 Size Virtual Machine Scale set with Azure Diagnostics turned on. 

![DownloadCert]

## Creating a custom ARM template

If you are wanting to create a custom ARM template for your cluster, then you have two choices.

1. You can acquire this sample template make changes to it. 
2. Log into the azure portal and use the service fabric portal pages to generate the template for you to customize.
  1. Log on to the Azure Portal [http://aka.ms/servicefabricportal](http://aka.ms/servicefabricportal).

  2. Go through the process of creating the cluster as described in [Creating Service Fabric Cluster via portal](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-creation-via-portal) , but do not click on ***create**, instead go to Summary and download the template and parameters.


 ![DownloadTemplate][DownloadTemplate]


Unzip the downloaded .zip on your local machine, make any changes to template or the parameter file as you need.


<!--Image references-->
[DownloadTemplate]: ./DownloadTemplate.png
[DownloadCert]: ./DownloadCert.PNG



