@Title "Empyrion - Galactic Survival MKLINK"
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
@set Game=Empyrion - Galactic Survival
@set GameFiles=F:\Archive\SavedGameFiles\%Game%\
@set UserFiles=F:\Archive\SavedGameFiles\%Game%\UserFiles
@set mods=F:\Archive\SavedGameFiles\%Game%\Content\Mods
@set Saves=F:\Archive\SavedGameFiles\Empyrion - Galactic Survival\Saves
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
 @if not exist "%Letter%:\SteamLibrary\steamapps\common\!Game!\_GameFiles" (MKLINK /d _GameFiles "!GameFiles!")
 @if not exist "%Letter%:\SteamLibrary\steamapps\common\!Game!\_UserFiles" (MKLINK /d _UserFiles "!UserFiles!")
 @if not exist "%Letter%:\SteamLibrary\steamapps\common\!Game!\Saves" (MKLINK /d /h /j Saves "!Saves!")
 @CHDIR /d "%Letter%:\SteamLibrary\steamapps\common\!Game!\Content"
 @if not exist "%Letter%:\SteamLibrary\steamapps\common\!Game!\Content\mods" (MKLINK /d /h /j mods "!mods!")
 @rem 
 goto :exit
)
@rem ==========================================================================
:SetPathDest2
@if exist "%Letter%:\Games\steamapps\common\%Game%" (
 @CHDIR /d "%Letter%:\Games\steamapps\common\!Game!\"
 @if not exist "%Letter%:\Games\steamapps\common\!Game!\_GameFiles" (MKLINK /d _GameFiles "!GameFiles!")
 @if not exist "%Letter%:\Games\steamapps\common\!Game!\_UserFiles" (MKLINK /d _UserFiles "!UserFiles!")
 @if not exist "%Letter%:\Games\steamapps\common\!Game!\Saves" (MKLINK /d /h /j Saves "!Saves!")
 @CHDIR /d "%Letter%:\Games\steamapps\common\!Game!\Content"
 @if not exist "%Letter%:\Games\steamapps\common\!Game!\Content\mods" (MKLINK /d /h /j mods "!mods!")
 @rem 
 goto :exit
)

:exit
endlocal

@rem @pause

