$siteUrl = Read-Host -Prompt "Enter the site url"

#if using MFA or ADFS, replace 'ADFS_SITE_URL.com' with your real domain
if($siteUrl -like '*ADFS_SITE_URL.com*') {
    Connect-PnPOnline -url $siteUrl -UseWebLogin
}
else {
    Connect-PnPOnline -url $siteUrl -Credentials (Get-Credential)
}

function UpdateFile ($localFile, $file, $folder) {
    $currentSiteServerRelativeUrl = Get-PnPSite -Includes ServerRelativeUrl | % { $_.ServerRelativeUrl }
    $currentSiteServerRelativeUrl = $currentSiteServerRelativeUrl.TrimEnd("/")

     Write-Host "Deploy Style Library Assets" -ForegroundColor Green
     Set-PnPFileCheckedOut -Url "$currentSiteServerRelativeUrl/$folder/$file"
     Add-PnPFile -Path $localFile -Folder $folder | Out-Null
     Set-PnPFileCheckedIn -Url "$currentSiteServerRelativeUrl/$folder/$file"
     Write-Host "Update Complete" -ForegroundColor Blue
}

$currentSiteServerRelativeUrl = Get-PnPSite -Includes ServerRelativeUrl | % { $_.ServerRelativeUrl }
$currentSiteServerRelativeUrl = $currentSiteServerRelativeUrl.TrimEnd("/")
UpdateFile "./top-navigation.js" "top-navigation.js" "Style Library/spfx-global-nav/js"
Add-PnPJavaScriptLink -Name "topNavigation" -Url "$currentSiteServerRelativeUrl/Style Library/spfx-global-nav/js/top-navigation.js" -Scope Site
#Remove-PnPJavaScriptLink -Identity "topNavigation" -Scope Site -Force
