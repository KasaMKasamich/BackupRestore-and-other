@rem Full Backup
@rem C:\_BackupRestore\_Backup_Full.cmd
@if "%dm%" == "" echo off
@if "%dm%" NEQ "" echo on
echo -- %dm%
@Title "Cleaning Cache Steam"
setlocal enableextensions
setlocal enabledelayedexpansion
@rem chcp 1251 >nul
@rem chcp 1252 >nul
@rem chcp 866 >nul
@rem  Time
set digit1=%time:~0,1%
if "%digit1%"==" " (set digit1=0)
set TimeStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
set DateStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!
set OnlyTimeStamp=!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@rem  Dirs
set Dir001=%temp%
set Dir002="C:\Program Files (x86)\Steam\appcache\httpcache\"
set Dir003="C:\Program Files (x86)\Steam\steamapps\temp\"
set Dir004="C:\Program Files (x86)\Steam\steamapps\downloading\"
@rem set Dir005="F:\Games\Steam\steamapps\"
@rem set Dir006="I:\Games\Steam\steamapps\"
set FolderPart=Games\Steam\steamapps

@rem  Имена дисков и буква >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> >>
set sDriveLetter=
set sCmd1=wmic volume where "label='Archive'" get DriveLetter
set sCmd2=wmic volume where "label='User Data'" get DriveLetter
@rem  << <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

set LogsDir=C:\_BackupRestore\__Logs
set LogFile=%LogsDir%\%DateStamp%\%OnlyTimeStamp%__%~n0.log.txt
set ErrorLogFile=%LogsDir%\%DateStamp%\%OnlyTimeStamp%__Error_%~n0.log.txt

if not exist %LogsDir%\%DateStamp% (mkdir "%LogsDir%\%DateStamp%" 1>nul 2>&1)
cmd /u /c chcp >>%LogFile%

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

set DestinationFolder01=%sDriveLetter%\%FolderPart%\temp\
set DestinationFolder02=%sDriveLetter%\%FolderPart%\downloading\
echo %DestinationFolder01%>>%LogFile%
echo %DestinationFolder02%>>%LogFile%

del /f /q %temp%\tmpDriveLetter.txt
del /f /q %temp%\fDriveLetter.txt
set sDriveLetter=

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

set DestinationFolder03=%sDriveLetter%\%FolderPart%\temp\
set DestinationFolder04=%sDriveLetter%\%FolderPart%\downloading\
echo %DestinationFolder03%>>%LogFile%
echo %DestinationFolder04%>>%LogFile%

del /f /q %temp%\tmpDriveLetter.txt
del /f /q %temp%\fDriveLetter.txt
set sDriveLetter=
@rem @pause

taskkill /F /IM "Steam.exe"
taskkill /F /IM "SteamService.exe"
taskkill /F /IM "steamwebhelper.exe"

del /f /s /q %temp%\*.*
RMDIR /S /Q %Dir002%
RMDIR /S /Q %Dir003%
RMDIR /S /Q %Dir004%
RMDIR /S /Q %DestinationFolder01%
RMDIR /S /Q %DestinationFolder02%
RMDIR /S /Q %DestinationFolder03%
RMDIR /S /Q %DestinationFolder04%

@rem @pause

@rem if exist %Dir005% (RMDIR /S /Q %Dir005%)
@rem if exist %Dir006% (RMDIR /S /Q %Dir005%)
@rem FOR /F "usebackq delims=" %%A IN ("a-z") DO ( if exist %%~A:\Games\Steam\steamapps\ (echo %%~A:\ is Exist) )

@rem FOR /F "usebackq delims=" %%A IN ("%temp%\fDriveLetter.txt") DO ( if not "%%~A" == "" (@set "sDriveLetter=%%~A") )
@rem exit
