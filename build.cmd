@echo off
cls

SET _build=%1

IF NOT [%_build%]==[] (
    SET _revision=--no-revision
    IF "%_build%" == "patch" goto build
    IF "%_build%" == "minor" goto build
    IF "%_build%" == "major" goto build
    goto unrecognized
) ELSE (
    SET _build=DEV:DEBUG
    SET _revision=
    goto build
)

:build
    echo.
    echo [96mBUILDING '%_build%' PACKAGE [0m
    echo.
    IF NOT [%1]==[] goto warning
    goto execute

:warning
   echo [91mWARNING:[0m Your code must be checked in prior to buildings a MAJOR/MINOR/PATCH.
   echo Verify that you have a clean working tree before continuing.
   echo.

   set /p answer=[93mI HAVE VERIFIED MY WORKING TREE IS CLEAN (Y/N)? [0m

   if /i "%answer:~,100%" EQU "Y" goto execute
   if /i "%answer:~,100%" EQU "N" goto finish
   echo Please type Y for Yes or N for No
   goto warning

:execute
    call gulp clean
    call gulp build --ship %_revision%
    call gulp bundle --ship --no-revision
    IF NOT [%1]==[] (
        call npm version %_build%
    )
    call gulp package-solution --ship
    goto openfolder

:openfolder
    call explorer .\sharepoint\solution\
    goto finish

:unrecognized
    echo.
    echo [91mUnrecognized parameters specified.[0m
    echo.
    echo Specify no parameter for development build.
    echo Use '[96mpatch[0m', '[96mminor[0m', or '[96mmajor[0m' for production level builds.
    echo.

:finish
