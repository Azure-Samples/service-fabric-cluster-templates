# Introduction

This folder contains the set of ARM templates you can use to deploy a secure five node service fabric cluster, add a new certificate and then rollover the current primary certificate. You can use these to follow along with the documentation for [rolling over certificates in your secure cluster](https://azure.microsoft.com/en-us/documentation/articles/service-fabric-cluster-security-update-certs-azure/)


## Microsoft Azure Service Fabric ARM template Samples in this folder

### Step1: Provision a secure cluster 
1. Template to provision a five node secure cluster - 5-VM-1-NodeTypes-Secure_Step1.JSON 
2. Template parameters for the above template - 5-VM-1-NodeTypes-Secure.parameters_Step1.JSON 


### Step2 :Add a secondary certificate and swamp it to be the primary using  ARM Powershell

[How to roll over certificates in your secure cluster](https://azure.microsoft.com/en-us/documentation/articles/service-fabric-cluster-security-update-certs-azure/)

1. Template to provision a five node secure cluster - 5-VM-1-NodeTypes-Secure_Step2.JSON 
2. Template parameters for the above template - 5-VM-1-NodeTypes-Secure.parameters_Step2.JSON 