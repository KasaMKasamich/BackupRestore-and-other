@Title "7DaysToDie MKLINK"
@set dm=0
@if "%dm%" == "" @echo off
@if "%dm%" NEQ "" @echo on
setlocal enableextensions
setlocal enabledelayedexpansion
@rem echo -- %dm%
@rem chcp 1251 >nul
@rem @chcp 1252 >
@rem 
chcp 65001 >nul
@rem @set charms=0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
@rem ==========================================================================
@Set Dev=H:\Games\TESV\SkyrimSE\Data\_Dev
@Set ModName=MarkAndRecallMulti
@set ModFiles=F:\Archive\SavedGameFiles\§ Bethesda Softworks\§ TES V\Skyrim Special Edition\§ Модификации\❑ Магия\MarkAndRecallMulti\
@rem ====================================================
cls
@rem ==========================================================================
:SetPathDest
@if exist "%ModFiles%" (
 @CHDIR /d "%Dev%"
 @if not exist "%ModName%Files\" (MKLINK /d /h /j %ModName%Files "!ModFiles!")
 @rem 
 goto :exit
)

:exit
endlocal

@rem @pause

