@Title "Conan Exiles MKLINK"
@set dm=0
@if "%dm%" == "" @echo off
@if "%dm%" NEQ "" @echo on
setlocal enableextensions
setlocal enabledelayedexpansion
@rem echo -- %dm%
@rem chcp 1251 >nul
@rem @chcp 1252 >
@rem @set charms=0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
@rem ==========================================================================
@set Game=Conan Exiles
@set GameDir=ConanSandbox
@set GameFiles=F:\Archive\SavedGameFiles\%Game%\
@set UserFiles=F:\Archive\SavedGameFiles\%Game%\UserFiles
@set mods=F:\Archive\SavedGameFiles\%Game%\Mods
@set Saved=F:\Archive\SavedGameFiles\%Game%\Saved
@rem ====================================================
@set Letter=F
@if exist "%Letter%:\SteamLibrary\steamapps\common\%Game%\%GameDir%" ( goto :SetPathDest )
@set Letter=H
@if exist "%Letter%:\SteamLibrary\steamapps\common\%Game%\%GameDir%" ( goto :SetPathDest )
@rem @set Letter=I
@rem @if exist "%Letter%:\Games\Steam\steamapps\common\%Game%\%GameDir%" ( goto :SetPathDest )
@rem @if exist "%Letter%:\SteamLibrary\steamapps\common\%Game%\%GameDir%" ( goto :SetPathDest2 )
cls
@rem ==========================================================================
:SetPathDest
@if exist "%Letter%:\SteamLibrary\steamapps\common\%Game%\%GameDir%" (
 @CHDIR /d "%Letter%:\SteamLibrary\steamapps\common\!Game!\%GameDir%\"
 @if not exist "_UserFiles\" (MKLINK /d _UserFiles "!UserFiles!")
 @if not exist "Saved\" (MKLINK /d Saved "!Saved!")
 @if not exist "Mods\" (MKLINK /d /h /j Mods "!mods!")
 @rem 
 goto :exit
)
@rem ==========================================================================
:SetPathDest2
@if exist "%Letter%:\Games\Steam\steamapps\common\%Game%\%GameDir%" (
 @CHDIR /d "%Letter%:\Games\Steam\steamapps\common\!Game!\%GameDir%\"
 @if not exist "_GameFiles\" (MKLINK /d _GameFiles "!GameFiles!")
 @if not exist "_UserFiles\" (MKLINK /d _UserFiles "!UserFiles!")
 @if not exist "Saved\" (MKLINK /d Saved "!Saved!")
 @if not exist "Mods\" (MKLINK /d /h /j Mods "!mods!")
 @rem 
 goto :exit
)

:exit
endlocal

@rem @pause

