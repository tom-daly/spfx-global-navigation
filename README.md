# Getting Started

This project is an SPFx application customizer built for Modern SharePoint sites / pages. It will place itself in the header placeholder of your site and pull the global navigation from the root site "/" aka "https://{domain}.sharepoint.com/" 

Currently the purpose of this repository is for you to pull down the code and build the solution to produce the .sppkg file that would be used to deploy to your SharePoint tenant app catalog. 

It's designed to work for Office 365 primarily but would work on prem 2019. Additionaly it will also generate an output to deploy to Classic Sites. 

# Prerequisites

1. SPFx Development Environment https://docs.microsoft.com/en-us/sharepoint/dev/spfx/set-up-your-development-environment
2. Powershell PnP https://github.com/SharePoint/PnP-PowerShell/releases
3. Tenant App Catalog https://docs.microsoft.com/en-us/sharepoint/dev/spfx/set-up-your-developer-tenant#create-app-catalog-site

# Installation & Deployment

## Overview
1. Provision the Global Nav List
2. Build the SPFx Application Customizer
2. Deploy the SPFx Application Customizer
3. Add the App to your site

## Step 1 - Provision the Global Nav List

+ You need to provision the list using Powershell PnP.
+ The "/provisioning" folder will contain the deployment script & the list definition. 
+ From the Powershell Command Line just run "./deploy.ps1" 
+ This will ask you for the site url. It is recommended to deploy the list to the root "https://{domain}.sharepoint.com" of your tenant as this is where the application customizer is designed to look for the list by default. 
+ Next it will ask for your user credentials to log into the site. This information is not stored and it used by Powershell PnP one time. 
+ After that the provisioning process will begin to create the list through the Powershell PnP template and then connect the lookup field.

## Step 2 - Build the Solution

## Step 3 - Deploy the Application Customizer

## Step 4 - Activate the App

### Additional Dependencies for Classic Mode Build ###
dependencies
@babel/polyfill

npm install @babel/polyfill --save

devDependencies
"css-loader": "^2.1.1",
"mini-css-extract-plugin": "^0.6.0",
"sass-loader": "^7.1.0",
"style-loader": "^0.23.1",

npm install css-loader mini-css-extract-plugin sass-loader style-loader --save-devDependencies

### Building the code for Classic Mode
Execute the following command:

npx webpack --config webpack.config.js

