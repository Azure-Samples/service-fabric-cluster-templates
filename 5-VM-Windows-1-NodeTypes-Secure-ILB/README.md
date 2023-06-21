# 5 Node secure internal Windows Service Fabric Cluster 

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2F5-VM-Windows-1-NodeTypes-Secure-ILB%2FAzureDeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2F5-VM-Windows-1-NodeTypes-Secure-ILB%2FAzureDeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template allows you to deploy an internal (private IP address) secure 5 node, Single Node Type Service Fabric Cluster running Windows Server 2022 Datacenter on a Standard_D2_v2 Size Virtual Machine Scale set with Azure Diagnostics turned on.

**NOTE: All nodes in the cluster need to resolve and connect outbound to the configured public regional Service Fabric Resource Provider (SFRP) https url on port 443 for the cluster to function.**

## Certificate needed for the template if using the 'Deploy to Azure' button above

This template assumes that you already have certificates uploaded to your key vault. Production clusters should always use a CA signed certificate. If needing a certificate for testing, a .pfx certificate can be generated directly in the key vault or if you want to create a new certificate run the [New-ServiceFabricClusterCertificate.ps1](../scripts/New-ServiceFabricClusterCertificate.ps1) file in this repository. That script will output the values necessary for deployment via the parameters file.

**NOTE: Azure Key vault 'Access Configuration' should have 'Azure Virtual Machines for deployment' and 'Azure Resource Manager for template deployment' enabled for node key vault access during template deployment.**

You can download the .PFX from the key vault from the portal

- Go to the key vault resource [Key vaults](https://ms.portal.azure.com/#browse/Microsoft.KeyVault%2Fvaults)
- Navigate to the 'Certificates' object, select the current certificate version, and download the .pfx

![DownloadCert]

## Use Powershell to deploy your cluster

Go through the process of creating the cluster as described in [Creating Service Fabric Cluster via arm](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-creation-via-arm)

## Creating a custom ARM template

If you are wanting to create a custom ARM template for your cluster, then you have two choices.

1. You can acquire this sample template and make changes to it.
2. Log into the azure portal and use the service fabric portal pages to generate the template for you to customize.

    - Log on to the Azure Portal [http://aka.ms/servicefabricportal](http://aka.ms/servicefabricportal).
    - Go through the process of creating the cluster as described in [Creating Service Fabric Cluster via portal](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-creation-via-portal) , but do not click on ***create**, instead go to Summary and download the template and parameters.

 ![DownloadTemplate][DownloadTemplate]

Unzip the downloaded .zip on your local machine, make any changes to template or the parameter file as you need.

<!--Image references-->
[DownloadTemplate]: ../media//DownloadTemplate.png
[DownloadCert]: ../media/DownloadCert.PNG
