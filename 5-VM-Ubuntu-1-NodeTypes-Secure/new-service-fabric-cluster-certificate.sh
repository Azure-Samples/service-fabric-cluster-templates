#!/bin/bash

# Last tested on Azure CLI 2.0 version 2.0.32.

# Use this script to create a certificate that you can use to secure a Service Fabric Cluster
# This script requires a KeyVault that is EnabledForDeployment.  The vault must be in the same region as the cluster.
# Once the certificate is created and stored in the vault, the script will provide the parameter values needed for template deployment
# 
# You can download the cert from the key vault portal, if you need it on your machine.

declare region=$1
declare keyVaultRG=$2
declare keyVaultName=$3
declare certPassword=$4
declare certDNSName=$5

declare keyVaultSecretName=${certDNSName//./-}

# To create a new vault in a new resource group, and set the EnabledForDeployment property run:
echo "Creating resource group for Key Vault . . . "
az group create --name $keyVaultRG --location $region

echo "Creating Key Vault . . ."
az keyvault create --name $keyVaultName --resource-group $keyVaultRG --location $region --enabled-for-deployment


# Due to KeyVault DNS propagation, we have to wait for 10 seconds (see https://github.com/Azure/azure-cli/issues/3348)
while [[ -z "$(az keyvault show -n $keyVaultName -g $keyVaultRG)" ]]; do
  sleep 10s
  echo "Waiting for 10 seconds for KeyVault DNS propagation"
done


# Create a new self-signed cert, specifying the FQDN as the subject.
openssl req -x509 -newkey rsa:2048 -subj '/CN='$certDNSName -days 365 -out $certDNSName.crt -keyout $certDNSName.pem -passout pass:$certPassword

# Convert PEM to PFX
openssl pkcs12 -export -in $certDNSName.crt -inkey $certDNSName.pem -passin pass:$certPassword -out $certDNSName.pfx -passout pass:$certPassword

# Upload to Key Vault
echo "Importing certificate to Key Vault . . ."
az keyvault certificate import --vault-name $keyVaultName --name $keyVaultSecretName --file $certDNSName.pfx --password $certPassword

echo "Fetching certificate values from Key Vault . . ."
# -- Get the values from Key Vault to use in the ARM template --
# Source vault ID
declare keyVaultResourceId=$(az keyvault show --name $keyVaultName --query id -o tsv)

# Certificate thumbprint
declare certThumbprint=$(az keyvault certificate show --vault-name $keyVaultName --name $keyVaultSecretName --query x509ThumbprintHex -o tsv)

# Certificate URL
declare certUrl=$(az keyvault certificate show --vault-name $keyVaultName --name $keyVaultSecretName --query sid -o tsv)


#-- ALTERNATIVE: Let Azure Key Vault create the certificate.
# Create a cert with the specified policy. Use 'az keyvault certificate get-default-policy' to 
# get the default policy, and then change the 'subject' in the policy to match the FQDN for the cluster.
# az keyvault certificate create --vault-name $keyVaultName --name $keyVaultSecretName-p @policy.json

# Download the secrete (private key information) associated with the cert
# az keyvault secret download --vault-name $keyVaultName --name $keyVaultSecretName --encoding base64 --file $certDNSName.pfx


echo
echo "Source Vault Resource Id: "$keyVaultResourceId
echo "Certificate URL: "$certUrl
echo "Certificate Thumbprint: "$certThumbprint