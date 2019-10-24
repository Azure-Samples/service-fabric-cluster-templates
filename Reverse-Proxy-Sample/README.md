
# Introduction

This folder contains the set of ARM templates  you can use to deploy a secure five node service fabric cluster and then enable/configure Reverse Proxy with a new certificate and then rollover the Reverse Proxy certificate.
To read more about the Reverse Proxy, refer [Service Fabric Reverse Proxy](https://docs.microsoft.com/azure/service-fabric/service-fabric-reverseproxy)
To read about Deploy templates to Azure, refer the section [Deploy the template to Azure](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-security-update-certs-azure)

## Configure HTTPS Reverse Proxy in a secure cluster.

### Step1: Provision a secure cluster (without Reverse Proxy)
1. Template to provision a five node secure cluster - 5-VM-1-NodeTypes-SecureRP_Step1.JSON 
2. Template parameters for the above template - 5-VM-1-NodeTypes-SecureRP_Step1.parameters.JSON 


### Step2 :Provision a new certificate using ARM Powershell. 
This upgrade step takes care of installing the Reverse Proxy certificate on all the VMs and acl'ing the certificate such that Service Fabric can access it.
Here the new certificate is added to the virtual machine scale set osProfile and the Service Fabric extension for virtual machine scale sets.

1. Template to provision a five node secure cluster with new certificates to be used by Reverse Proxy later- 5-VM-1-NodeTypes-Secure_Step2.JSON 
2. Template parameters for the above template - 5-VM-1-NodeTypes-SecureRP_Step2.parameters.JSON 

### Step3 :Enable Reverse Proxy using ARM Powershell
This upgrade step includes: 
    Configure Load balancer Rule and Probe for Reverse Proxy.
    Configure the port for the Reverse Proxy.
    Configure Reverse Proxy certificate in the Service Fabric cluster resource.

1. Template to provision a five node secure cluster with Reverse Proxy - 5-VM-1-NodeTypes-SecureRP_Step3.JSON 
2. Template parameters for the above template - 5-VM-1-NodeTypes-SecureRP_Step3.parameters.JSON 

## Rolling over Reverse Proxy certificate.
Once you have a cluster with Reverse Proxy configured (HTTPS, using the above steps), now we will discuss how to rollover the Reverse Proxy certificate.
Rolling over the Reverse Proxy certificate involves issuing two upgrades:

### Step1: Provision a second certificate for Reverse Proxy using ARM Powershell. 

This upgrade step takes care of installing the Reverse Proxy certificate on all the VMs and acl'ing the certificate such that Service Fabric can access it.

1. Template to provision a five node secure cluster with new certificates to be used by Reverse Proxy later- 5-VM-1-NodeTypes-SecureRP_RollOverStep1.JSON 
2. Template parameters for the above template - 5-VM-1-NodeTypes-SecureRP_RollOverStep1.parameters.JSON 


### Step2 :Rollover Reverse Proxy certificate to use the one added in the above step using ARM Powershell. 
Here, it sets the Reverse Proxy certificate in the Service Fabric cluster resource to the new thumbprint.

1. Template to provision a five node secure cluster and have Reverse Proxy use the new certificate- 5-VM-1-NodeTypes-SecureRP_RollOverStep2.JSON 
2. Template parameters for the above template - 5-VM-1-NodeTypes-SecureRP_RollOverStep2.parameters.JSON 

## Configure reverse proxy to connect to secure services
The below three templates show the different options to establish a secure channel between reverse proxy and services.
To read more about configuring secure end-to-end communication via the Reverse Proxy, refer [Connect to a secure service with the reverse proxy](https://docs.microsoft.com/azure/service-fabric/service-fabric-reverseproxy-configure-secure-communication)

### 5-VM-1-NodeTypes-SecureRP_ServiceCertValidationNone.JSON
Use this template to deploy a 5 node cluster with reverse proxy listening on HTTPS. Here ApplicationCertificateValidationPolicy is set to None. 
Reverse proxy will skip the server certificate validation while connecting to secure services.

### 5-VM-1-NodeTypes-SecureRP_ServiceCertValidationCommonName.JSON
This template shows how to configure the reverse proxy to validate the service's certificate based on certificate common name and issue's thumbprint.

###  5-VM-1-NodeTypes-SecureRP_ServiceCertValidationThumbprints.JSON
This template shows how to configure the reverse proxy to validate the service's certificate based on certificate's thumbprints. 