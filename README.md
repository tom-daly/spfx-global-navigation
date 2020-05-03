# Introduction
This project is an SPFx application customizer built for Modern SharePoint sites / pages. It will place itself in the header placeholder of your site and pull the global navigation from the root site "/" aka "https://{domain}.sharepoint.com/" 

It's designed to work for Office 365 primarily but would work on prem 2019. Additionaly it will also generate an output to deploy to Classic Sites. 

## Why does this project exist? 
Most people are running their Office 365 environment in some sort of hybrid of Classic sites and Modern sites. This solution helps to merge the two, creating a consistent navigation across both. 

## Why are there 2 versions?
the sp2019 version works for sp2019 and office 365.
-this version currently does not build for classic mode

The o365 version only works for o365.
