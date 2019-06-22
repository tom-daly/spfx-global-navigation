$siteUrl = Read-Host -Prompt "Enter the site url"

if($siteUrl -like '*ADFS_SITE_URL.com*') {
    Connect-PnPOnline -url $siteUrl -UseWebLogin
}
else {
    Connect-PnPOnline -url $siteUrl -Credentials (Get-Credential)
}


function ProvisionLists() {
    Write-Host ""
    Write-Host "Provisioning Site Columns, Content Types, & Lists" -ForegroundColor Yellow
    Write-Host "-------------------------------------------------" -ForegroundColor Yellow
    Write-Host "Global Nav List" -ForegroundColor Green
    Apply-PnPProvisioningTemplate ".\GlobalNavList\definition.xml"
    Write-Host "Provisioning done" -ForegroundColor Blue
}

ProvisionLists