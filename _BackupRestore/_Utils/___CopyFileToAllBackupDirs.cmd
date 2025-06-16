@Title "Restore Backup"
@rem 
@echo off
:: setlocal enableextensions enabledelayedexpansion
setlocal enableextensions
setlocal enabledelayedexpansion
@rem chcp 1251 >nul
@rem chcp 1252 >nul
@rem chcp 866 >nul
set DestFolderPart=Archive\_BackUps\_BackupsArchive
set sDriveLetter=
set sCmd=wmic volume where "label='Archive'" get DriveLetter
echo [92m " =================================== End init =================================== " [0m 
@rem ======================================================================
call %sCmd%>%temp%\tmpDriveLetter.txt
powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt)[1].Trim()">%temp%\fDriveLetter.txt

powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt)[0,1].Trim()"

FOR /F "usebackq delims=" %%A IN ("%temp%\fDriveLetter.txt") DO ( if not "%%~A" == "" (@set "sDriveLetter=%%~A") )

@rem  Проверить пустая переменная или нет, если да то выход >>>>>>>>>>>>>>>>>>>>>>>>>> >>
@if "%sDriveLetter%" == "" (
	echo DriveLetter not found
	exit /b
)
@rem  << <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
set DestinationFolder=%sDriveLetter%\%DestFolderPart%
echo %DestinationFolder%
@rem @pause
del /f /q %temp%\tmpDriveLetter.txt
del /f /q %temp%\fDriveLetter.txt
@rem ======================================================================
for /d %%g in (%DestinationFolder%\*) do copy /v /y %sDriveLetter%\_BackupRestore\_Utils\_RestoreBackup.cmd %%g
explorer "%DestinationFolder%"
