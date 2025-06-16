@Title "Copy-Passwords"
@rem C:\_BackupRestore\_Backup_Full.cmd
@if "%dm%" == "" echo off
@if "%dm%" NEQ "" echo on
echo -- %dm%
setlocal enableextensions
setlocal enabledelayedexpansion
@rem cmd /u /c chcp 1252 >nul
@rem chcp 866 >nul
@rem  Time
set digit1=%time:~0,1%
if "%digit1%"==" " (set digit1=0)
set TimeStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
set DateStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!
set OnlyTimeStamp=!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!

@rem  RoboCopy
set RCParams=/S /ZB /R:3 /W:2 /SL /MT:8
set RCParams2=/S /B /R:3 /W:2 /SL /MT:8
@rem Исключить по атрибутам.
set RCKey= /XA:sh
@rem Исключить более ранние файлы.
set RCKey2= /XO

set RCFileDataFlags=/COPYALL /DCOPY:DAT
set RCFileDataFlags2=/SEC /DCOPY:DAT
set RCFileDataFlags3=/COPY:DAT /DCOPY:DAT

set SourceDir=%~dp0\_Pass
set DestFolder1=C:\_BackupRestore\_Utils
set DestFolderPart1=Archive\Sys\_Pass
set DestFolderPart2=

@rem  Имена дисков и буква >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>
set sDriveLetter=
set sCmd1=wmic volume where "label='PortableArchive'" get DriveLetter
set sCmd2=wmic volume where "label='Archive'" get DriveLetter
@rem  << <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

set LogsDir=C:\_BackupRestore\__Logs
set LogFile=%LogsDir%\%DateStamp%\%OnlyTimeStamp%__%~n0.log.txt
set ErrorLogFile=%LogsDir%\%DateStamp%\%OnlyTimeStamp%__Error_%~n0.log.txt
set Echo1=[92m " >>>>>>> The copy to the archive disk >>>>>>> " [0m 

if not exist %LogsDir%\%DateStamp% (mkdir "%LogsDir%\%DateStamp%" 1>nul 2>&1)
@echo %TimeStamp% >>%LogFile%
cls
@rem  ============================================================================================================
@rem @echo  - %0
@rem @echo  - %~dp0
@rem @echo  - %~n0
@rem @echo  - %~x0

chcp 1252 >nul
@rem Self Backup
@rem Копирование на выбор, XCopy или ROBOCOPY
echo XCopy: >>%LogFile%
xcopy /D /R /Y /Z %0 %DestFolder1%\%~n0%~x0>>%LogFile%
@rem ROBOCOPY "%~dp0/" "%DestFolder1%/" "%~n0%~x0" %RCParams%%RCKey2% %RCFileDataFlags3%>>%LogFile%
chcp 866 >nul

@rem call %LogFile%
@rem @pause

call %sCmd1%>%temp%\tmpDriveLetter.txt
powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt)[1].Trim()">%temp%\fDriveLetter.txt

powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt)[0,1].Trim()">>%LogFile%

FOR /F "usebackq delims=" %%A IN ("%temp%\fDriveLetter.txt") DO ( if not "%%~A" == "" (@set "sDriveLetter=%%~A") )

@rem  Проверить пустая переменная или нет, если да то выход >>>>>>>>>>>>>>>>>>>>>>>>>> >>
@if "%sDriveLetter%" == "" (
	echo DriveLetter not found >%ErrorLogFile%
	exit /b
)
@if "%sDriveLetter%" == " " (
	echo DriveLetter not found >%ErrorLogFile%
	exit /b
)
@rem  << <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

set DestinationFolder=%sDriveLetter%\%DestFolderPart1%
echo %DestinationFolder%>>%LogFile%
@rem @pause

if not exist %DestinationFolder% (mkdir "%DestinationFolder%" 1>nul 2>&1)

chcp 1252 >nul
ROBOCOPY "%SourceDir%" "%DestinationFolder%" %RCParams%%RCKey2% %RCFileDataFlags3%>>%LogFile%
chcp 866 >nul

@rem @pause

@rem  Очистить переменные >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>
del /f /q %temp%\tmpDriveLetter.txt
del /f /q %temp%\fDriveLetter.txt
set sDriveLetter=
@rem  << <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

@rem  ============================================================================================================
echo %Echo1%

call %sCmd2%>%temp%\tmpDriveLetter.txt
powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt)[1].Trim()">%temp%\fDriveLetter.txt

powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt)[0,1].Trim()">>%LogFile%

FOR /F "usebackq delims=" %%A IN ("%temp%\fDriveLetter.txt") DO ( if not "%%~A" == "" (@set "sDriveLetter=%%~A") )

@rem  Проверить пустая переменная или нет, если да то выход >>>>>>>>>>>>>>>>>>>>>>>>>> >>
@if "%sDriveLetter%" == "" (
	echo DriveLetter not found >%ErrorLogFile%
	exit /b
)
@if "%sDriveLetter%" == " " (
	echo DriveLetter not found >%ErrorLogFile%
	exit /b
)
@rem  << <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

set DestinationFolder=%sDriveLetter%\%DestFolderPart1%
echo %DestinationFolder%>>%LogFile%

if not exist %DestinationFolder% (mkdir "%DestinationFolder%" 1>nul 2>&1)

chcp 1252 >nul
ROBOCOPY "%SourceDir%" "%DestinationFolder%" %RCParams%%RCKey2% %RCFileDataFlags3%>>%LogFile%
chcp 866 >nul
@rem @pause

@rem  Очистить переменные >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>
del /f /q %temp%\tmpDriveLetter.txt
del /f /q %temp%\fDriveLetter.txt
set sDriveLetter=
@rem  << <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

:End
%LogFile%
if exist %ErrorLogFile% ( call %ErrorLogFile%)
echo - Exit Code -
endlocal
@rem exit













@rem wmic volume where "label='PortableArchive'" get DriveLetter
@rem wmic volume where "label='PortableArchive'" get DriveType
@rem wmic volume where "label='PortableArchive'" set DriveLetter=g:
@rem if %sDriveLetter% == G: (wmic volume where "label='PortableArchive'" get DriveLetter)
@rem if not %sDriveLetter% == G: (wmic volume where "label='PortableArchive'" set DriveLetter=g:)
