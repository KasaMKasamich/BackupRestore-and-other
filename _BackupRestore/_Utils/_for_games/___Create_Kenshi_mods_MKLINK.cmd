@Title "%Game% MKLINK"
@set dm=
@if "%dm%" == "" @echo off
@if "%dm%" NEQ "" @echo on
setlocal enableextensions
setlocal enabledelayedexpansion
@rem echo -- %dm%
@rem chcp 1251 >nul
@rem @chcp 1252 >
@rem @set charms=0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
@rem ==========================================================================
@set Game=Kenshi
@set GameFiles=F:\Archive\SavedGameFiles\%Game%\
@set UserFiles=F:\Archive\SavedGameFiles\%Game%\UserFiles
@set mods=F:\Archive\SavedGameFiles\%Game%\Mods
@set save=F:\Archive\SavedGameFiles\%Game%\save
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
:ifPathExist
goto :SetPathDest
:SetPathDest
@CHDIR /d "%Letter%:\SteamLibrary\steamapps\common\%Game%"
@if not exist "%Letter%:\SteamLibrary\steamapps\common\%Game%\___GameFiles" (MKLINK /d ___GameFiles "%GameFiles%")
@if not exist "%Letter%:\SteamLibrary\steamapps\common\%Game%\___UserFiles" (MKLINK /d ___UserFiles "%UserFiles%")
@if not exist "%Letter%:\SteamLibrary\steamapps\common\%Game%\mods" (MKLINK /d /h /j mods "%mods%")
@if not exist "%Letter%:\SteamLibrary\steamapps\common\%Game%\save" (MKLINK /d /h /j save "%save%")
@rem 
goto :exit
@rem ==========================================================================
:SetPathDest2
@if exist "%Letter%:\Games\steamapps\common\%Game%" (
 @CHDIR /d "%Letter%:\Games\steamapps\common\!Game!\"
 @if not exist "%Letter%:\Games\steamapps\common\!Game!\___GameFiles" (MKLINK /d ___GameFiles "!GameFiles!")
 @if not exist "%Letter%:\Games\steamapps\common\!Game!\___UserFiles" (MKLINK /d ___UserFiles "!UserFiles!")
 @if not exist "%Letter%:\Games\steamapps\common\!Game!\mods" (MKLINK /d /h /j mods "!mods!")
 @if not exist "%Letter%:\Games\steamapps\common\!Game!\save" (MKLINK /d /h /j save "!save!")
 @rem 
 goto :exit
)
:exit
