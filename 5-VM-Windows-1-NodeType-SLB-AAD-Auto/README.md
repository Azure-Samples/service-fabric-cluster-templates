# 5 Node 1 node type secure Windows Service Fabric Cluster with standard load balancer, AAD, and Automatic OS Upgrade

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2F5-VM-Windows-1-NodeType-SLB-AAD-Auto%2FAzureDeploy.json)
[![Visualize](http://armviz.io/visualizebutton.png)](http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fservice-fabric-cluster-templates%2Fmaster%2F5-VM-Windows-1-NodeType-SLB-AAD-Auto%2FAzureDeploy.json)

This template allows you to deploy a secure 5 node, 1 Node Type Service Fabric Cluster with Standard load balancer running Windows Server 2022 Datacenter on a Standard_DS4_v2 Size Virtual Machine Scale set. This template additionally is configured for Azure Active Directory authentication and Automatic OS Upgrade. [Set up Azure Active Directory for client authentication in the Azure portal](https://learn.microsoft.com/azure/service-fabric/service-fabric-cluster-creation-setup-azure-ad-via-portal) provides the steps necessary for creation of the client and cluster App registration accounts. After accounts have been created, this template can be used to deploy the cluster with AAD configuration enabled.

```json
"azureActiveDirectory": {
    "clientApplication": "[parameters('aadClientApplication')]",
    "clusterApplication": "[parameters('aadClusterApplication')]",
    "tenantId": "[parameters('aadTenantId')]"
},
```

## Template Configuration

- Cluster Reliability Level: Silver or higher
- Certificate Thumbprint configuration
- Azure Active Directory configuration
- Automatic OS Upgrade configuration

## Template Resources

- 1 service fabric cluster
- 1 vm scale set / node type
  - 5 nodes / virtual machines
  - 2 extensions
    - Service Fabric
    - Iaas Diagnostic
- 1 standard load balancer
- 1 public IP address
- 1 network security group
- 1 virtual network
- 2 storage account v2
  - diagnostics
  - service fabric logs

## Certificates

This template assumes that you already have certificates uploaded to your key vault. Production clusters should always use a CA signed certificate. If needing a certificate for testing, a .pfx certificate can be generated directly in the key vault or if you want to create a new certificate run the [New-ServiceFabricClusterCertificate.ps1](../scripts/New-ServiceFabricClusterCertificate.ps1) file in this repository. That script will output the values necessary for deployment via the parameters file.

> [!NOTE]  
> Azure Key vault 'Access Configuration' should have 'Azure Virtual Machines for deployment' and 'Azure Resource Manager for template deployment' enabled for node key vault access during template deployment.

You can download the .PFX from the key vault from the portal

- Go to the key vault resource
- navigate to the secrets tab and download the .pfx

![DownloadCert]

## Use Powershell to deploy your cluster

Execute from a machine with Azure 'Az.Accounts' and 'Az.Resources' modules installed. Optionally, uncomment the `Install-Module` lines to install the modules if not already installed.

```powershell
# Install-Module -Name Az.Accounts -AllowClobber -Scope CurrentUser
# Install-Module -Name Az.Resources -AllowClobber -Scope CurrentUser
Import-Module Az.Accounts
Import-Module Az.Resources
Connect-AzAccount

$location = '<location>'
$resourceGroupName = '<resource group name>'
$templateFile = '.\azuredeploy.json'
$templateParameterFile = '.\azuredeploy.parameters.json'

New-AzResourceGroup -Name $resourceGroupName -Location $location
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
            -DeploymentDebugLogLevel All `
            -TemplateFile $templateFile `
            -TemplateParameterFile $templateParameterFile `
            -Verbose
```

## Use Powershell to connect to your cluster

Execute from a windows powershell command prompt with the Service Fabric SDK installed. The Service Fabric SDK can be installed from the [Download and install the runtime and SDK](https://learn.microsoft.com/azure/service-fabric/service-fabric-get-started) page.

```powershell
Import-Module ServiceFabric

$location = '<location>'
$clusterName = '<cluster name>'
$serverCertThumbprint = '<cluster certificate thumbprint>'

$clusterFqdn = "$clusterName.$location.cloudapp.azure.com"
$clusterEndpoint = "$($clusterFqdn):19000"
Connect-ServiceFabricCluster -ConnectionEndpoint $clusterEndpoint `
    -ServerCertThumbprint $serverCertThumbprint `
    -AzureActiveDirectory `
    -Verbose
```

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