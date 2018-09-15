# Multiple Node Types Secure Ubuntu Service Fabric Cluster

This template allows you to create multiple node types with each node type having different number of VMSS Instances

## Overview 

This ARM template will provision Service Fabric cluster which has internet accessible and authenticated endpoints. 
The endpoint can be exposed through a public load balancer or Application Gateway.


## Prerequisites 

* Azure Key Vault in the same region where the Service Fabric Cluster would be created.
* Client Authentication Certificate - either self signed or issued from a Trusted Root CA.
* Azure Virtual Network with sufficient address space to provision VMs
* Azure CLI installed on Windows, Mac OS or Linux machine. 
* Service Fabric CLI SFCTL installed on Windows, Mac OS or Linux machine.
* Access to Azure Subscription


### Notes
This ARM template uses resource loops to create multiple node types, public ip addresses and load balancers and adds the node types to the Service Fabric Cluster. Each Node Type is associated with a Load Balancer using the loop index.
Each nodetype can be deployed into it's own subnet. 

### Key Parameters
 
clientCertificateStoreValue - Thumb print of PFX certificate uploaded to Key Vault.

certificateThumbprint - Thumb print from filename.crt, stored in local machine's certificate store.

loopCount - Number of Nodetypes to create with index 0 being the primary node type

vmNodeTypeSize - Specify VM size for each Node Type

subnetNames - Array of subnet names for each node type. This array length should match the node type loop count

        

### Key Variables

ntProperties - Specify array of Node Type placement properties for each node type. 
