$configFile = "config.json";

if((Test-Path $configFile) -eq $false) {
    $siteUrl = Read-Host -Prompt "Enter the site url"
    $username = Read-Host -Prompt "Enter the username"
    $securePassword = Read-Host -Prompt "Enter your tenant password" -AsSecureString | ConvertFrom-SecureString
    @{username=$username;securePassword=$securePassword;siteUrl=$siteUrl} | ConvertTo-Json | Out-File $configFile
}

$configObject = Get-Content $configFile | ConvertFrom-Json
$password = $configObject.securePassword | ConvertTo-SecureString
$credentials = new-object -typename System.Management.Automation.PSCredential -argumentlist $configObject.username, $password
Connect-PnPOnline -url $configObject.siteUrl -Credentials $credentials

function CreateListFromTemplate($listTemplateInternalName, $listName, $listUrl) {
    $ctx = Get-PnPContext
    $web = $ctx.Site.RootWeb
    $listTemplates = $ctx.Site.GetCustomListTemplates($web)
    $ctx.Load($web)
    $ctx.Load($listTemplates)
    $ctx.ExecuteQuery()
 
    $listTemplate = $listTemplates | where { $_.InternalName -eq $listTemplateInternalName }

    if ($listTemplate -eq $null)
    {
        Throw [System.Exception] "Template not found"
    }

    $listCreation = New-Object Microsoft.SharePoint.Client.ListCreationInformation
    $listCreation.Title = $listName
    $listCreation.Url = $listUrl
    $listCreation.ListTemplate = $listTemplate

    $list = $web.Lists.Add($listCreation) 
    $list.Update()
    $ctx.ExecuteQuery() 
}

Write-Host ""
Write-Host "Provisioning Site Columns, Content Types, & Lists" -ForegroundColor Yellow
Write-Host "-------------------------------------------------" -ForegroundColor Yellow

Write-Host "Global Navigation" -ForegroundColor Green

$listTemplate = Get-ChildItem "./GlobalNavList/GlobalNavList.stp"
Write-Host -ForegroundColor Yellow "Adding Template: "$listTemplate.Name
Add-PnPFile -Path $listTemplate.FullName -Folder "_catalogs/lt"

CreateListFromTemplate "GlobalNavList.stp" "Global Nav List" "GlobalNavList"

Write-Host "Provisioning done" -ForegroundColor Blue
