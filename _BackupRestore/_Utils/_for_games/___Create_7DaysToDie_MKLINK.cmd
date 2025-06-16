@Title "7DaysToDie MKLINK"
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
@set Game=7 Days To Die
@set ModCollection7dtd=MC7dtd
@set GameFiles=F:\Archive\SavedGameFiles\%Game%\
@set UserFiles=F:\Archive\SavedGameFiles\%Game%\UserFiles
@set mods=F:\Archive\SavedGameFiles\%Game%\Mods
@set Mods_DMT=F:\Archive\SavedGameFiles\%Game%\Mods_DMT
@set ModCollection7dtdPath=F:\Archive\SavedGameFiles\%Game%\Mods\%ModCollection7dtd%
@rem ====================================================
@set Letter=h
@if exist "%Letter%:\SteamLibrary\steamapps\common\%Game%" ( goto :SetPathDest )
@rem @if exist "%Letter%:\Games\steamapps\common\%Game%" ( goto :SetPathDest2 )
@set Letter=f
@if exist "%Letter%:\SteamLibrary\steamapps\common\%Game%" ( goto :SetPathDest )
@rem @if exist "%Letter%:\Games\steamapps\common\%Game%" ( goto :SetPathDest2 )
@set Letter=i
@if exist "%Letter%:\SteamLibrary\steamapps\common\%Game%" ( goto :SetPathDest )
@rem @if exist "%Letter%:\Games\steamapps\common\%Game%" ( goto :SetPathDest2 )
cls
@rem ==========================================================================
:SetPathDest
@if exist "%Letter%:\SteamLibrary\steamapps\common\%Game%" (
 @CHDIR /d "%Letter%:\SteamLibrary\steamapps\common\!Game!\"
 @if not exist "_GameFiles\" (MKLINK /d _GameFiles "!GameFiles!")
 @if not exist "_UserFiles\" (MKLINK /d _UserFiles "!UserFiles!")
 @if not exist "mods\" (MKLINK /d /h /j mods "!mods!")
 @if not exist "Mods_DMT\" (MKLINK /d /h /j Mods_DMT "!Mods_DMT!")
 @CHDIR /d "Data\Bundles\"
 @if not exist "%ModCollection7dtd%\" (MKLINK /d /h /j MC7dtd "!ModCollection7dtdPath!")
 @rem 
 goto :exit
)
@rem ==========================================================================
:SetPathDest2
@if exist "%Letter%:\Games\steamapps\common\%Game%" (
 @CHDIR /d "%Letter%:\Games\steamapps\common\!Game!\"
 @if not exist "_GameFiles\" (MKLINK /d _GameFiles "!GameFiles!")
 @if not exist "_UserFiles\" (MKLINK /d _UserFiles "!UserFiles!")
 @if not exist "mods\" (MKLINK /d /h /j mods "!mods!")
 @if not exist "Mods_DMT\" (MKLINK /d /h /j Mods_DMT "!Mods_DMT!")
 @CHDIR /d "Data\Bundles\"
 @if not exist "%ModCollection7dtd%\" (MKLINK /d /h /j MC7dtd "!ModCollection7dtdPath!")
 @rem 
 goto :exit
)

:exit
endlocal

@rem @pause

