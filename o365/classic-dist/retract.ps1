$siteUrl = Read-Host -Prompt "Enter the site url"

if($siteUrl -like '*ADFS_SITE_URL.com*') {
    Connect-PnPOnline -url $siteUrl -UseWebLogin
}
else {
    Connect-PnPOnline -url $siteUrl -Credentials (Get-Credential)
}

Remove-PnPJavaScriptLink -Identity "topNavigation" -Scope Site -Force 