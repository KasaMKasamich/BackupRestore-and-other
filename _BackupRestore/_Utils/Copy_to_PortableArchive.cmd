@Rem [ Author: [ Бурлачков Василий Александрович) ] ]
@rem Copy Pass
@echo off
@rem setlocal enableextensions enabledelayedexpansion
setlocal EnableExtensions
setlocal EnableDelayedExpansion
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
set DestFolderPart=Archive\Sys\_Pass

set sDriveLetter=
set sCmd=wmic volume where "label='PortableArchive'" get DriveLetter

set LogsDir=C:\_BackupRestore\__Logs
set LogFile=%LogsDir%\%DateStamp%\%OnlyTimeStamp%__%~n0.log.txt
set ErrorLogFile=%LogsDir%\%DateStamp%\%OnlyTimeStamp%__Error_%~n0.log.txt

if not exist %LogsDir%\%DateStamp% (mkdir "%LogsDir%\%DateStamp%" 1>nul 2>&1)
cmd /u /c chcp >>%LogFile%

call %sCmd%>%temp%\tmpDriveLetter.txt
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

set DestinationFolder=%sDriveLetter%\%DestFolderPart%
echo %DestinationFolder%>>%LogFile%
@rem @pause

if not exist %DestinationFolder% (mkdir "%DestinationFolder%" 1>nul 2>&1)

ROBOCOPY "%SourceDir%" "%DestinationFolder%" %RCParams% %RCFileDataFlags3%>>%LogFile%
@rem Версия с исключением по атрибутам и более ранним файлам.
@rem ROBOCOPY "%SourceDir%" "%DestinationFolder%" %RCParams%%RCKey%%RCKey2% %RCFileDataFlags3%>>%LogFile%

@rem @pause

del /f /q %temp%\tmpDriveLetter.txt
del /f /q %temp%\fDriveLetter.txt

:End
echo - Exit Code -
endlocal
@rem exit
