@Rem [ Author: [ Бурлачков Василий Александрович) ] ]
@echo off
@chcp 65001>nul
@Title "The Witcher 3 Wild Hunt MKLINK"
@rem setlocal enableextensions enabledelayedexpansion
setlocal EnableExtensions
setlocal EnableDelayedExpansion
@rem echo -- %dm%
@rem chcp 1251 >nul
@rem @chcp 1252 >
@rem @set Letters=0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
@rem ===========================================================================
del /f /q %temp%\tmpDriveLetter.txt
del /f /q %temp%\fDriveLetter.txt
set sDriveLetter=
set sCmd=wmic volume where "label='Storage'" get DriveLetter
call %sCmd%>%temp%\tmpDriveLetter.txt
powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt)[1].Trim()">%temp%\fDriveLetter.txt

powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt)[0,1].Trim()"

FOR /F "usebackq delims=" %%A IN ("%temp%\fDriveLetter.txt") DO ( if not "%%~A" == "" (@set "sDriveLetter=%%~A") )

wmic exit
@rem  Проверить пустая переменная или нет, если да то выход >>>>>>>>>>>>>>>>>>>>>>>>>> >>
@if "%sDriveLetter%" == "" (
	echo DriveLetter not found
	exit /b
)
@rem  << <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
@rem ===========================================================================
@set P=/d /h /j
@set Game=The Witcher 3
@set GameDir01=The Witcher 3 Wild Hunt v4_04a
@set UserFiles=%sDriveLetter%\LSS\[]SavedGameFiles\%Game%\_UserFiles
@set mods404=%sDriveLetter%\LSS\[]SavedGameFiles\%Game%\_W3_Mods\v4_04\mods
@if not exist "%UserFiles%" mkdir "%UserFiles%"
@if not exist "%mods404%" mkdir "%mods404%"
@rem ====================================================
del /f /q %temp%\tmpDriveLetter.txt
del /f /q %temp%\fDriveLetter.txt
@rem ====================================================
set sCmd2=wmic volume where "label='Sys'" get DriveLetter
call %sCmd2%>%temp%\tmpDriveLetter.txt
powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt)[1].Trim()">%temp%\fDriveLetter.txt

powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt)[0,1].Trim()"

FOR /F "usebackq delims=" %%A IN ("%temp%\fDriveLetter.txt") DO ( if not "%%~A" == "" (@set "sDriveLetter=%%~A") )

wmic exit
@rem  Проверить пустая переменная или нет, если да то выход >>>>>>>>>>>>>>>>>>>>>>>>>> >>
@if "%sDriveLetter%" == "" (
	echo DriveLetter not found
	exit /b
)
@rem  << <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
@if exist "%sDriveLetter%:\Games\%GameDir01%" ( goto :SetPathDest )
@rem ==========================================================================
:SetPathDest
@if exist "%sDriveLetter%\Games\%GameDir01%" (
 @CHDIR /d "%sDriveLetter%\Games\!GameDir01!\"
 @if not exist "_UserFiles\" (MKLINK %P% _UserFiles "!UserFiles!")
 @if not exist "mods\" (MKLINK %P% mods "!mods404!")
 @rem 
)
@rem ==========================================================================
goto :exit

:exit
del /f /q %temp%\tmpDriveLetter.txt
del /f /q %temp%\fDriveLetter.txt
endlocal

@rem @pause

