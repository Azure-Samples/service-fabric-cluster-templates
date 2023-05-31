[service-fabric-cluster-templates](https://github.com/Azure-Samples/service-fabric-cluster-templates/tree/master)/
Building a Secure Service Fabric Cluster: Enabling Storage Account
Access from Existing VNET with Firewall Configuration

## **Building a Secure Service Fabric Cluster: Enabling Storage Account Access from Existing VNET with Firewall Configuration**

## Overview

The purpose of this ARM (Azure Resource Manager) template is to
facilitate the seamless provisioning of a Service Fabric cluster while
ensuring the security and protection of the associated storage account.
By implementing the template, you can create a Service Fabric cluster
that is shielded from public network access, thereby minimizing
potential security risks.

One of the key features of this template is the ability to configure
access to the storage account only from a whitelisted network/IP. This
ensures that access to the storage account is restricted to specific
networks or IP addresses, thereby enhancing the overall security posture
of your Service Fabric cluster.

## Prerequisites

-   Azure Key Vault in the same region where the Service Fabric Cluster
    would be created.

-   Changed the kind of Storage account to StorageV2.

-   Changed the API version of Storage resource to 2019-04-01 or higher.

-   Existing virtual network on which you will be deploying your cluster
    & whitelisting it in Storage account Firewall rules from ARM
    template.

-   Make sure your subnet has Microsoft.Storage service endpoint.

    -   From Azure portal go the existing Virtual network you will be
        using for cluster & navigating to subnet. Click on the subnet &
        enable the Microsoft.Storage service endpoint.


-   Get your subnet ID at resources.azure.com \> select your
    subscription \> Existing VNet Resource group \> Micosoft.Network\>
    VNET \> Subnet, which is needed to be whitelisted.



-   For securing the Storage account from public network access, include
    the below definition on your storage account definition -\>
    properties section. Make sure you replace the "**Subnetid**" & then
    deploy the ARM template.

> \"properties\": {
>
>                 \"allowBlobPublicAccess\": false,
>
>                 \"networkAcls\": {
>
>                     \"resourceAccessRules\": \[\],
>
>                     \"bypass\": \"AzureServices\",
>
>                     \"virtualNetworkRules\": \[
>
>                          {
>
>                             \"id\": "**Subnetid**\",
>
>                             \"action\": \"Allow\",
>
>                             \"state\": \"Succeeded"
>
>                          }
>
>                      \],
>
>                     \"ipRules\": \[\],
>
>                     \"defaultAction\": \"Deny\"
>
>                 }
>
>             }
>


## Key Parameters

existingVNetRGName: Existing VNET's Resource group name.

existingVNetName: Existing VNet name

subnet0Name: Subnet name

## References: 

<https://learn.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts?pivots=deployment-language-arm-template>

<https://learn.microsoft.com/en-us/azure/service-fabric/service-fabric-patterns-networking#existing-virtual-network-or-subnet>
