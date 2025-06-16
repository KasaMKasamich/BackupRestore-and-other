@Title "Conan Exiles MKLINK"
setlocal EnableExtensions
setlocal EnableDelayedExpansion
@rem chcp 1251 >nul
@rem @chcp 1252 >
@rem @set charms=0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
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
@set Steam-in[C]=C:\Program Files (x86)\Steam\steamapps\common
@set Game=Conan Exiles
@set GameDir=ConanSandbox
@set GameFiles=%sDriveLetter%\LSS\[]SavedGameFiles\%Game%\
@set UserFiles=%sDriveLetter%\LSS\[]SavedGameFiles\%Game%\UserFiles
@set mods=%sDriveLetter%\LSS\[]SavedGameFiles\%Game%\Mods
@set Saved=%sDriveLetter%\LSS\[]SavedGameFiles\%Game%\Saved
@rem ====================================================
@rem @set Letter=F
@rem @if exist "%Letter%:\SteamLibrary\steamapps\common\%Game%\%GameDir%" ( goto :SetPathDest )
@rem @set Letter=H
@rem @if exist "%Letter%:\SteamLibrary\steamapps\common\%Game%\%GameDir%" ( goto :SetPathDest )
@rem ==========================================================================
@if not exist "%UserFiles%" mkdir "%UserFiles%"
@if not exist "%mods%" mkdir "%mods%"
@if not exist "%Saved%" mkdir "%Saved%"
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
@if exist "%Steam-in[C]%\%Game%\%GameDir%" ( goto :SetPathDest )
@rem ==========================================================================
:SetPathDest
@if exist "%Steam-in[C]%\%Game%\%GameDir%" (
 @CHDIR /d "%Steam-in[C]%\%Game%\%GameDir%\"
 @if not exist "_UserFiles\" (MKLINK %P% _UserFiles "!UserFiles!")
 @if not exist "mods\" (MKLINK %P% mods "!mods!")
 @if not exist "Saved\" (MKLINK %P% Saved "!Saved!")
 @rem 
)
@rem ==========================================================================
goto :exit

:exit
del /f /q %temp%\tmpDriveLetter.txt
del /f /q %temp%\fDriveLetter.txt
endlocal

@rem @pause

