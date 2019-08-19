## Modern Page
Designed for modern sites
![demo on modern](https://i.imgur.com/sSMCwKF.gif)

## Classic Page
Also works on classic sites
![demo on classic](https://i.imgur.com/BUnbHvW.gif)

# Getting Started

This project is an SPFx application customizer built for Modern SharePoint sites / pages. It will place itself in the header placeholder of your site and pull the global navigation from the root site "/" aka "https://{domain}.sharepoint.com/" 

Currently the purpose of this repository is for you to pull down the code and build the solution to produce the .sppkg file that would be used to deploy to your SharePoint tenant app catalog. 

It's designed to work for Office 365 primarily but would work on prem 2019. Additionaly it will also generate an output to deploy to Classic Sites. 

# Prerequisites

1. SPFx Development Environment https://docs.microsoft.com/en-us/sharepoint/dev/spfx/set-up-your-development-environment
2. Powershell PnP https://github.com/SharePoint/PnP-PowerShell/releases
3. Tenant App Catalog https://docs.microsoft.com/en-us/sharepoint/dev/spfx/set-up-your-developer-tenant#create-app-catalog-site
4. Node 8.16.0

# Installation & Deployment
The following steps assume that you've cloned this repository or downloaded the files and successfully installed all the dependencies using 'npm install'. Make sure to use the same version of node to get a successfull build. 

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

![provision the list](https://i.imgur.com/rQtjBEC.gif)

## Step 2 - Build the Solution
It is recommended to run the 'build.cmd' file from the projects root folder. This file does all the normal SPFx build commands such as build, bundle, package-solution but it will also generate the necessary file needed for support on classic sites. The 'build.cmd' also does a number of other things out of scope for guide. Please refer to the following blogs posts for more information on this file.

+ [Simple Build Script for the SharePoint Framework](https://thomasdaly.net/2018/05/07/simple-build-script-for-the-sharepoint-framework/)
+ [SPFx Automatically Generating Revision Numbers](https://thomasdaly.net/2018/08/12/spfx-automatically-generating-revision-numbers/)
+ [Update: SPFx Automatically Generating Revision Numbers + Versioning](https://thomasdaly.net/2018/08/21/update-spfx-automatically-generating-revision-numbers-versioning/)

![build](https://i.imgur.com/8G55Dym.png)

### Modern App 
When the build script completes you will have the app package for modern sites located in './sharepoint/solution/spfx-global-navigation.sppkg'

![App Package](https://i.imgur.com/5I1BrRE.png)

### Classic JS File
When the build script completes you will have the .js file for classic sites located in './classic-dist/top-navigation.js'

![JavaScript File](https://i.imgur.com/adOUY2h.png)

## Step 3 - Deploy the Application Customizer
...coming soon

## Step 4 - Activate the App
...coming soon




\
\
\
\
\



# Notes

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

