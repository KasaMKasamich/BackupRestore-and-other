@Rem [ Author: [ Бурлачков Василий Александрович) ] ]
@echo off
@chcp 65001>nul
@Title "The Witcher 3 Wild Hunt MKLINK"
@set dm=0
@if "%dm%" == "" @echo off
@if "%dm%" NEQ "" @echo on
@rem setlocal enableextensions enabledelayedexpansion
setlocal EnableExtensions
setlocal EnableDelayedExpansion
@rem echo -- %dm%
@rem chcp 1251 >nul
@rem @chcp 1252 >
@rem @set Letters=0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
@rem ==========================================================================H:\Games\The Witcher 3 Wild Hunt
@set Game=The Witcher 3
@set P=/d /h /j
@set GameDir01=The Witcher 3 Wild Hunt
@set GameDir02=The Witcher 3 Wild Hunt (v1.32)
@set GameDir03=The Witcher 3 Wild Hunt (v4.01)
@set UserFiles=F:\Archive\SavedGameFiles\%Game%\_UserFiles
@set mods131=F:\Archive\SavedGameFiles\%Game%\_W3_Mods\v1_31\mods
@set mods132=F:\Archive\SavedGameFiles\%Game%\_W3_Mods\v1_32\mods
@set mods401=F:\Archive\SavedGameFiles\%Game%\_W3_Mods\v4_01\mods
@set mods402=F:\Archive\SavedGameFiles\%Game%\_W3_Mods\v4_02\mods
@if not exist "%UserFiles%" mkdir "%UserFiles%"
@if not exist "%mods131%" mkdir "%mods131%"
@if not exist "%mods132%" mkdir "%mods132%"
@if not exist "%mods401%" mkdir "%mods401%"
@if not exist "%mods402%" mkdir "%mods402%"
@rem ====================================================
@set Letter=h
@if exist "%Letter%:\Games\%GameDir01%" ( goto :SetPathDest )
@if exist "%Letter%:\Games\%GameDir02%" ( goto :SetPathDest2 )
@if exist "%Letter%:\Games\%GameDir03%" ( goto :SetPathDest3 )
@set Letter=f
@if exist "%Letter%:\Games\%GameDir01%" ( goto :SetPathDest )
@if exist "%Letter%:\Games\%GameDir02%" ( goto :SetPathDest2 )
@if exist "%Letter%:\Games\%GameDir03%" ( goto :SetPathDest3 )
@set Letter=i
@if exist "%Letter%:\Games\%GameDir01%" ( goto :SetPathDest )
@if exist "%Letter%:\Games\%GameDir02%" ( goto :SetPathDest2 )
@if exist "%Letter%:\Games\%GameDir03%" ( goto :SetPathDest3 )
cls
@rem ==========================================================================
:SetPathDest
@if exist "%Letter%:\Games\%GameDir01%" (
 @CHDIR /d "%Letter%:\Games\!GameDir01!\"
 @if not exist "_UserFiles\" (MKLINK %P% _UserFiles "!UserFiles!")
 @if not exist "mods\" (MKLINK %P% mods "!mods131!")
 @if not exist "mods\" (MKLINK %P% mods "!mods132!")
 @if not exist "mods\" (MKLINK %P% mods "!mods401!")
 @if not exist "mods\" (MKLINK %P% mods "!mods402!")
 @rem 
)
@rem ==========================================================================
:SetPathDest2
@if exist "%Letter%:\Games\%GameDir02%" (
 @CHDIR /d "%Letter%:\Games\!GameDir02!\"
 @if not exist "_UserFiles\" (MKLINK %P% _UserFiles "!UserFiles!")
 @if not exist "mods\" (MKLINK %P% mods "!mods131!")
 @if not exist "mods\" (MKLINK %P% mods "!mods132!")
 @if not exist "mods\" (MKLINK %P% mods "!mods401!")
 @if not exist "mods\" (MKLINK %P% mods "!mods402!")
 @rem 
)
:SetPathDest3
@if exist "%Letter%:\Games\%GameDir03%" (
 @CHDIR /d "%Letter%:\Games\!GameDir03!\"
 @if not exist "_UserFiles\" (MKLINK %P% _UserFiles "!UserFiles!")
 @if not exist "mods\" (MKLINK %P% mods "!mods131!")
 @if not exist "mods\" (MKLINK %P% mods "!mods132!")
 @if not exist "mods\" (MKLINK %P% mods "!mods401!")
 @if not exist "mods\" (MKLINK %P% mods "!mods402!")
 @rem 
)
goto :exit

:exit
endlocal

@rem @pause

