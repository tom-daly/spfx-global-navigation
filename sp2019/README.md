# Introduction
This project is an SPFx application customizer built for Modern SharePoint sites / pages. It will place itself in the header placeholder of your site and pull the global navigation from the root site "/" aka "https://{domain}.sharepoint.com/" 

It's designed to work for Office 365 primarily but would work on prem 2019. Additionaly it will also generate an output to deploy to Classic Sites. 

## Why does this project exist? 
Most people are running their Office 365 environment in some sort of hybrid of Classic sites and Modern sites. This solution helps to merge the two, creating a consistent navigation across both. 

## Modern Page Demonstration
Designed for modern sites
![demo on modern](https://i.imgur.com/sSMCwKF.gif)

## Classic Page Demonstration
Also works on classic sites
![demo on classic](https://i.imgur.com/BUnbHvW.gif)

# Getting Started
Currently the purpose of this repository is for you to pull down the code and build the solution to produce the .sppkg file that would be used to deploy to your SharePoint tenant app catalog.

# Prerequisites

1. [SPFx Development Environment](https://docs.microsoft.com/en-us/sharepoint/dev/spfx/set-up-your-development-environment)
2. [Powershell PnP](https://github.com/SharePoint/PnP-PowerShell/releases)
3. [Tenant App Catalog](https://docs.microsoft.com/en-us/sharepoint/dev/spfx/set-up-your-developer-tenant#create-app-catalog-site)
4. Node 8.x.x -- SP2019 MUST USE THIS VERSION

# Installation & Deployment
The following steps assume that you've cloned this repository or downloaded the files and successfully installed all the dependencies using 'npm install'. Make sure to use the same version of node to get a successfull build. 

## Overview
1. Provision the Global Nav List
2. Build the SPFx Application Customizer
2. Deploy the SPFx Application Customizer
3. Add the App to your site

## Step 1 - Provision the Global Nav List
In this step we will provision the Global Navigation list to your tenant using a Powershell PnP provisioning template and cmdlets. Inside the './provisioning' folder there will be a 'deploy.ps1' that will automate this process.

***It is recommended to deploy the list to the root "https://{domain}.sharepoint.com" of your tenant as this is where the application customizer is designed to look for the list by default.*** 

1. Navigate to a Classic site
2. From the SharePoint Online Management Shell navigate to the 'provisioning' folder
3. Run './deploy.ps1' 
4. Enter url of the classic site that you want to deploy to 'https://{domain}.sharepoint.com/'
5. Enter your credentials

![provision the list](https://i.imgur.com/rQtjBEC.gif)

## Step 2 - Build the Solution
It is recommended to run the 'build.cmd' file from the projects root folder. This file does all the normal SPFx build commands such as build, bundle, package-solution but it will also generate the necessary file needed for support on classic sites. The 'build.cmd' also does a number of other things out of scope for guide. Please refer to the following blogs posts for more information on this file.

+ [Simple Build Script for the SharePoint Framework](https://thomasdaly.net/2018/05/07/simple-build-script-for-the-sharepoint-framework/)
+ [SPFx Automatically Generating Revision Numbers](https://thomasdaly.net/2018/08/12/spfx-automatically-generating-revision-numbers/)
+ [Update: SPFx Automatically Generating Revision Numbers + Versioning](https://thomasdaly.net/2018/08/21/update-spfx-automatically-generating-revision-numbers-versioning/)

![build](https://i.imgur.com/8G55Dym.png)

### Modern App Build
When the build script completes you will have the app package for modern sites located in './sharepoint/solution/spfx-global-navigation.sppkg'

![App Package](https://i.imgur.com/5I1BrRE.png)

### Classic JS File Build
As mentioned in the introduction, by using the 'build.cmd' the build process will generate a JavaScript file suitable for deployment on a Classic site. 

Without going into too much detail, the build process calls a separate webpack configuration that points to a seperate component for Classic Mode. This webpack configuration and the custom component both have additional references and polyfills in order for it to work on a Classic Site. 

After running the build script you will have the .js file for classic sites located in './classic-dist/top-navigation.js'

![JavaScript File](https://i.imgur.com/adOUY2h.png)

***Deploying to a Classic site will target and override the default navigation. The code targets the element '#DeltaTopNavigation'. This reference can be changed in the 'components/ClassicMode/ClassicMode.ts' file*** 

## Step 3 - Deploy the Application Customizer

#### Modern Deployment
Modern site deployment is straightforward. [For more information about this process see official MS Docs](https://docs.microsoft.com/en-us/sharepoint/use-app-catalog)

1. Navigate to your tenant App Catalog
2. Click Apps for SharePoint in the Quick Launch menu
3. Click and drag the .sppkg file into the tenant App Catalog

![deploy app customizer](https://i.imgur.com/il6utDR.gif)

#### Classic Deployment
For classic mode support we need to upload a file into the 'Style Library/spfx-global-nav/js/top-navigation.js' of the site collection and then link to the JavaScript file. Inside the './classic-dist' folder there will be a 'deploy.ps1' that will automate this process. Understand that this deployment is per site collection, meaning that each site collection gets it's own file. 

***Consider centrally hosting this file in a CDN to avoid publishing it to each site collection individually.***

***This method does not modify the masterpage of the classic site. It uses ScriptLinks to register itself to the site***

1. Navigate to a Classic site
2. From the SharePoint Online Management Shell navigate to the 'classic-dist' folder
3. Run './deploy.ps1' 
4. Enter url of the classic site that you want to deploy to 'https://{domain}.sharepoint.com/sites/{classic-site}'
5. Enter your credentials

![deploy for classic](https://i.imgur.com/bdkWTs7.gif)

***This screenshot shows the attached scriptlink link using a Chrome Extension, [SP-Editor](https://chrome.google.com/webstore/detail/sp-editor/ecblfcmjnbbgaojblcpmjoamegpbodhd?hl=en)***

## Step 4 - Activate the App
Activation on a Modern site deployment is straightforward. [For more information about this process see official MS Docs](https://docs.microsoft.com/en-us/sharepoint/use-app-catalog)

1. Navigate to your Modern site
2. From the gear icon, click 'Add an App'
3. In the left menu, click 'From your Organization'
4. Click 'spfx-global-navigation-client-side-solution'

***In a minute or two it will be activated on that modern site***

![activate solution](https://i.imgur.com/4S73iiN.gif)

# Modifications

## Updating the Styles
The project was written with a global sass stylesheet for Modern sites first and was then extended to support Classic sites. It should be simple enough to update the hex colors and rebuild to match your site's palette. 

+ globalNavStyles.scss - Contains all the styles for the menu for both Classic and Modern sites. This file contains sass variables to easily update the colors of the menus to match your environment. All the other sass should not be adjusted as it controls the function of the menu.
+ classicModeStyles.scss - Contains styles to speficic to Classic sites. This file contains styles to hide the default top navigation menu on a Classic site. 

## Home Node Icon
The project's css file contains a few lines of code that tranfer a node called 'Home' into a house. That can be removed or commented out and rebuilt

When nodes are built their labels are [slugified](https://www.npmjs.com/package/slugify) and added as classes. Custom CSS can be written to target any node element by their slugified labels.

&nbsp;    
&nbsp;  
&nbsp;  
&nbsp;  

# Notes

### ADFS Support
**Problem**: The deploy script is not working because your tenant is using ADFS or MFS to authenticate.

**Solution**: Each 'deploy.ps1' contains a simple site url check to use either the standard login approach or the web login. Using web login is necessary for ADFS or MFA authentication and Powershell PnP to work together. Inside the each of the 'deploy.ps1' scripts modify line 3 to include your SharePoint site url between the *'s. When you run the script again and if the site url matches then it will execute the Powershell PnP command, Connect-PnPOnline with the UseWebLogin parameter. This will open a browser and allow you login just as your normally would and pass the credentials back to the Powershell PnP cmdlets.

![adfs support](https://i.imgur.com/nSN2IE4.png)


### Additional Dependencies for Classic Mode Build ###
There were a few additional depencies that were required for a React component to work on a Classic site. 

The following changes were made to the 'packages.json' of this project.

```json
"dependencies": {
    "@babel/polyfill": "^7.4.4"
}
```

```shell
npm install @babel/polyfill --save
```

```json
"devDependencies": {
  "css-loader": "^2.1.1",
  "mini-css-extract-plugin": "^0.6.0",
  "sass-loader": "^7.1.0",
  "style-loader": "^0.23.1"
}
```

```shell
npm install css-loader mini-css-extract-plugin sass-loader style-loader --save-devDependencies
```

### Building the code for Classic Mode
The following command is required to be executed in order to generate a Classic mode JavaScript file.

```shell
npx webpack --config webpack.config.js
```
