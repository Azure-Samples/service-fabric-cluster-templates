#Requires -Module Az.KeyVault

# Use this script to create a certificate that you can use to secure a Service Fabric Cluster
# This script requires an existing KeyVault that is EnabledForDeployment and EnabledForTemplateDeployment.  The vault must be in the same region as the cluster.
# To create a new vault, set the EnabledForDeployment, and set EnabledForTemplateDeployment property run:
#
#$keyvaultRG="mykevaultrg"
#$KeyVaultName="mykevaultname"
#New-AzResourceGroup -Name $KeyvaultRG -Location WestUS
#New-AzKeyVault -VaultName $KeyVaultName -ResourceGroupName $KeyvaultRG -Location WestUS -EnabledForDeployment -EnabledForTemplateDeployment
#
# Once the certificate is created and stored in the vault, the script will provide the parameter values needed for template deployment
# 
# You can download the cert from the key-vault portal, if you need it on your machine.

param(
    [string] [Parameter(Mandatory=$true)] $Password,
    [string] [Parameter(Mandatory=$true)] $CertDNSName,
    [string] [Parameter(Mandatory=$true)] $KeyVaultName,
    [string] [Parameter(Mandatory=$true)] $KeyVaultSecretName
)

$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force
$CertFileFullPath = $(Join-Path (Split-Path -Parent $MyInvocation.MyCommand.Definition) "\$CertDNSName.pfx")

$NewCert = New-SelfSignedCertificate -CertStoreLocation Cert:\CurrentUser\My -DnsName $CertDNSName 
Export-PfxCertificate -FilePath $CertFileFullPath -Password $SecurePassword -Cert $NewCert

$Bytes = [System.IO.File]::ReadAllBytes($CertFileFullPath)
$Base64 = [System.Convert]::ToBase64String($Bytes)

$JSONBlob = @{
    data = $Base64
    dataType = 'pfx'
    password = $Password
} | ConvertTo-Json

$ContentBytes = [System.Text.Encoding]::UTF8.GetBytes($JSONBlob)
$Content = [System.Convert]::ToBase64String($ContentBytes)

$SecretValue = ConvertTo-SecureString -String $Content -AsPlainText -Force
$NewSecret = Set-AzKeyVaultSecret -VaultName $KeyVaultName -Name $KeyVaultSecretName -SecretValue $SecretValue -Verbose

Write-Host
Write-Host "Source Vault Resource Id: "$(Get-AzKeyVault -VaultName $KeyVaultName).ResourceId
Write-Host "Certificate URL : "$NewSecret.Id
Write-Host "Certificate Thumbprint : "$NewCert.Thumbprint