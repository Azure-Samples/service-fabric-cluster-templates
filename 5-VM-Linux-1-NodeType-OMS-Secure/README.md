# Create a Service Fabric cluster with OMS

This template allows you to deploy a secure 1, 3 - 99 node Service Fabric cluster running Linux. The template also creates an OMS Workspace with Service Fabric and Containers solutions within it, and deploys the OMS agent to each of the nodes to collect diagnostics information.

## Creating a custom ARM template

To create a custom ARM template for your cluster, log in to the Azure Portal and go through the process of creating a new cluster as described in [Creating Service Fabric Cluster via portal](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-creation-via-portal). When ready, instead of clicking **create** for the resource, go to **Summary** and download the template and parameters. 

## Deploying the ARM template to Azure using Resource Manager PowerShell

Refer to [Deploying ARM templates using ARM PS](https://azure.microsoft.com/documentation/articles/service-fabric-cluster-creation-via-arm/) for detailed guidance on how to. There is detailed guidance on how to set up your certificates as well.