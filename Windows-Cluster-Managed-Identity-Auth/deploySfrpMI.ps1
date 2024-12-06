param (
    [string] $resourceGroup, 
    [string] $clusterName,
    [string] $region = "southcentralus",   
    [string] $username = "vmadmin",
    [string] $password = "Password123!@#",
    [string] $certName = "sfrptestcert",
    [string] $durability = "Silver",
    [string] $reliability = "Silver",
    [string] $templatePath = ".\template_WindowsMI.json",
    [string] $parametersPath = ".\parameters_WindowsMI.json",
    [string] $sfRuntimeVersion
)

if ([string]::IsNullOrEmpty($clusterName))
{
    $clusterName = $resourceGroup
}

if ( $null -eq (Get-AzResourceGroup -Name $resourceGroup -ErrorAction Ignore))
{
    New-AzResourceGroup -Name $resourceGroup -Location $region
}

$vaultName = $clusterName + "kv"
$keyVault = Get-AzKeyVault -VaultName $vaultName -ResourceGroupName $resourceGroup
if ($null -eq $keyVault)
{
    $keyVault = New-AzKeyVault -VaultName $vaultName -ResourceGroupName $resourceGroup -Location $region -EnabledForDeployment -EnabledForTemplateDeployment
}

$certSecretId = $null
$cert = Get-AzKeyVaultCertificate -VaultName $vaultName -Name $certName
if ($null -eq $cert)
{
    $policy = New-AzKeyVaultCertificatePolicy -SecretContentType application/x-pkcs12 -SubjectName "CN=$certName" -IssuerName Self
    Add-AzKeyVaultCertificate -VaultName $vaultName -Name $certName -CertificatePolicy $policy
}
else {
    $certSecretId = $cert.SecretId
}

# wait until the cert is fully created
while (-not $certSecretId) {
    $cert = Get-AzKeyVaultCertificate -VaultName $vaultName -Name $certName

    $certSecretId = $cert.SecretId

    Write-Host "($(Get-Date)) Waiting for cert to be created."
    Start-Sleep -Seconds 15
}


# certificateThumbprint
$cert.Thumbprint
# sourceVaultValue
$keyVault.ResourceId
# certificateUrlValue
$cert.SecretId

$pass = (ConvertTo-SecureString -AsPlainText -Force $password)
$timestamp = "{0:MMddHHmmfff}{1}" -f [DateTime]::UtcNow, (Get-Random -Minimum 1000 -Maximum 9999)


Write-Host "($(Get-Date)) New-AzResourceGroupDeployment -Name "$resourceGroup-$timestamp" -ResourceGroupName $resourceGroup `
                        -TemplateFile $templatePath `
                        -TemplateParameterFile $parametersPath `
                        -clusterName $clusterName -clusterLocation $region -adminPassword $pass -durability $durability -reliability $reliability `
                        -certificateThumbprint $($cert.Thumbprint) -sourceVaultValue $($keyVault.ResourceId) -certificateUrlValue $($cert.SecretId)"

New-AzResourceGroupDeployment -Name "$resourceGroup-$timestamp" -ResourceGroupName $resourceGroup `
    -TemplateFile $templatePath `
    -TemplateParameterFile $parametersPath `
    -clusterName $clusterName -clusterLocation $region -adminPassword $pass -durability $durability -reliability $reliability `
    -certificateThumbprint $cert.Thumbprint -sourceVaultValue $keyVault.ResourceId -certificateUrlValue $cert.SecretId # -Verbose -Debug