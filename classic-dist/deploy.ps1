function UpdateFile ($localFile, $file, $folder) {
    $currentSiteServerRelativeUrl = Get-PnPSite -Includes ServerRelativeUrl | % { $_.ServerRelativeUrl }
    $currentSiteServerRelativeUrl = $currentSiteServerRelativeUrl.TrimEnd("/") 

    $styleLibrary = Get-PnPFolderItem -FolderSiteRelativeUrl "$folder/$file" -ItemType File
     Write-Host "File Located" -ForegroundColor Green
     Write-Host "Deploy Style Library Assets" -ForegroundColor Green
     Set-PnPFileCheckedOut -Url "$currentSiteServerRelativeUrl/$folder/$file"
     Add-PnPFile -Path $localFile -Folder $folder | Out-Null
     Set-PnPFileCheckedIn -Url "$currentSiteServerRelativeUrl/$folder/$file"
     Write-Host "Update Complete" -ForegroundColor Blue
}



Connect-PnPOnline -Url "http://intranet"

$currentSiteServerRelativeUrl = Get-PnPSite -Includes ServerRelativeUrl | % { $_.ServerRelativeUrl }
$currentSiteServerRelativeUrl = $currentSiteServerRelativeUrl.TrimEnd("/") 
UpdateFile "./top-navigation.js" "top-navigation.js" "Style Library/seco/js"
Add-PnPJavaScriptLink -Name "topNavigation" -Url "$currentSiteServerRelativeUrl/Style Library/seco/js/top-navigation.js" -Scope Site
#Remove-PnPJavaScriptLink -Identity "topNavigation" -Scope Site -Force 