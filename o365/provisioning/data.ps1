$configFile = "config.json";

if((Test-Path $configFile) -eq $false) {
    $siteUrl = Read-Host -Prompt "Enter the site url"
    @{siteUrl=$siteUrl} | ConvertTo-Json | Out-File $configFile
}

$configObject = Get-Content $configFile | ConvertFrom-Json
Connect-PnPOnline -url $configObject.siteUrl

function RemoveAllListItems($listName) {
    Write-Host "Remove All Current List Items from -> $listName" -ForegroundColor Yellow
    $items = Get-PnPListItem -List $listName -PageSize 1000
    $index = 1
    $totalitems = $items.Count
    foreach ($item in $items)
    {
        try
        {
            Remove-PnPListItem -List $listName -Identity $item.Id -Force
            Write-Host "$index/$totalItems" -ForegroundColor Red
            $index++
        }
        catch
        {
        Write-Host "error"
        }
    }
}

function GetItemIdByTitle($title) {
    $listName = "Global Nav List"
    $item =  Get-PnPListItem -List $listName -Query "<View><Query><Where><Eq><FieldRef Name='Title'/><Value Type='Text'>$title</Value></Eq></Where></Query></View>"
    return $item.Id
}

function GenerateTestData-Navigation {
    $listName = "Global Nav List"
    RemoveAllListItems $listName 

    $currentWebServerRelativeUrl = Get-PnPWeb | % { $_.ServerRelativeUrl }
    $currentWebServerRelativeUrl = $currentWebServerRelativeUrl.TrimEnd("/")     

    Write-Host "Adding New List Items" -ForegroundColor Yellow
    Add-PnPListItem -List $listName -ContentType "Global Nav Content Type" -Values @{"Title"="Home";"GlobalNavUrl"="#";"GlobalNavOrder"="0";}
    Add-PnPListItem -List $listName -ContentType "Global Nav Content Type" -Values @{"Title"="Departments";"GlobalNavUrl"="#";"GlobalNavOrder"="1";}
    Add-PnPListItem -List $listName -ContentType "Global Nav Content Type" -Values @{"Title"="Services";"GlobalNavUrl"="#";"GlobalNavOrder"="2";}
    Add-PnPListItem -List $listName -ContentType "Global Nav Content Type" -Values @{"Title"="Locations";"GlobalNavUrl"="#";"GlobalNavOrder"="3";}
    Add-PnPListItem -List $listName -ContentType "Global Nav Content Type" -Values @{"Title"="Directory";"GlobalNavUrl"="#";"GlobalNavOrder"="4";}

    $departmentsId = GetItemIdByTitle "Departments"
    Add-PnPListItem -List $listName -ContentType "Global Nav Content Type" -Values @{"Title"="Finance";"GlobalNavUrl"="#";"GlobalNavOrder"="0";"GlobalNavParent"="$departmentsId";} 
    Add-PnPListItem -List $listName -ContentType "Global Nav Content Type" -Values @{"Title"="Human Resources";"GlobalNavUrl"="#";"GlobalNavOrder"="1";"GlobalNavParent"="$departmentsId";} 
    Add-PnPListItem -List $listName -ContentType "Global Nav Content Type" -Values @{"Title"="Marketing";"GlobalNavUrl"="#";"GlobalNavOrder"="2";"GlobalNavParent"="$departmentsId";} 

    $locationsId = GetItemIdByTitle "Locations"
    Add-PnPListItem -List $listName -ContentType "Global Nav Content Type" -Values @{"Title"="Ahmedabad";"GlobalNavUrl"="#";"GlobalNavOrder"="0";"GlobalNavParent"="$locationsId";} 
    Add-PnPListItem -List $listName -ContentType "Global Nav Content Type" -Values @{"Title"="London";"GlobalNavUrl"="#";"GlobalNavOrder"="1";"GlobalNavParent"="$locationsId";} 
    Add-PnPListItem -List $listName -ContentType "Global Nav Content Type" -Values @{"Title"="New York";"GlobalNavUrl"="#";"GlobalNavOrder"="2";"GlobalNavParent"="$locationsId";} 
    Add-PnPListItem -List $listName -ContentType "Global Nav Content Type" -Values @{"Title"="Philly";"GlobalNavUrl"="#";"GlobalNavOrder"="3";"GlobalNavParent"="$locationsId";} 
}

GenerateTestData-Navigation




#Connect-PnPOnline –Url https://bandrdev.sharepoint.com/sites/gnt
#Get-PnPJavaScriptLink
#Add-PnPJavaScriptLink -Name GlobalNav -Url https://bandrdev.sharepoint.com/sites/gnt/SiteAssets/top-navigation.js -Scope Site -Sequence 100
#Remove-PnPJavaScriptLink -Name GlobalNav