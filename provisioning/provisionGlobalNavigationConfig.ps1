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

function ProvisionList() {
    Write-Host ""
    Write-Host "Provisioning Site Columns, Content Types, & Lists" -ForegroundColor Yellow
    Write-Host "-------------------------------------------------" -ForegroundColor Yellow
    
    Write-Host "Global Navigation" -ForegroundColor Green
    Apply-PnPProvisioningTemplate ".\GlobalNavList\definition.xml"
}

## The look up field in the schema used to fail
## this method was used during that time but no longer seems needed
function ConfigureLookupField () {
    Write-Host "Adding Lookup Field" -ForegroundColor Green
    $globalNavList = Get-PnPList -Identity "Lists/GlobalNavList"
    
    if(!$globalNavList) {
        Write-Host "Could not find the list to connect the lookup field. Check that the Global Nav list exists.";
        return;
    }
    else {
        $fieldXml = "<Field ID='{068992B0-C110-411E-A152-4C17E17E43DE}' Name='GlobalNavParent' StaticName='GlobalNavParent' DisplayName='Parent' Group='Global Nav Site Columns' Required='false' Type='Lookup' List='"+ $globalNavList.Id +"' ShowField='Title' Overwrite='TRUE' OverwriteInChildScopes='TRUE' />"
        Add-PnPFieldFromXml -List "Global Nav List" -FieldXml $fieldXml | Out-Null
    }
}

# MAIN 
Remove-PnPList -Identity "Global Nav List"
ProvisionList
ConfigureLookupField

Write-Host ""
Write-Host "Provisioning Completed." -ForegroundColor Blue
