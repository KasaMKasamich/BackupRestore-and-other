@if "%dm%" == "" echo off
@Title "Kill Fake Svchost"
setlocal enableextensions
setlocal enabledelayedexpansion

@color 0A
@chcp 1252 >nul
@rem  Time
set digit1=%time:~0,1%
if "%digit1%"==" " (set digit1=0)
set TimeStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
rem  int
set iTick=0
set startmsg="(%TimeStamp%)"
set runtaskmsg=The task run - 
set process001=7DaysToDie.exe
set process002=7DaysToDie_EAC.exe
set Warningmsg=Process %process% found and killed
set runasmsg=Run as user kill

set LogsDir=C:\_BackupRestore\__Logs\Processes
set LogFile="%LogsDir%\%TimeStamp%_Kill.log"
if not exist "%LogsDir%" mkdir "%LogsDir%"
if exist %LogsDir% goto Start

:Start
echo --------------------------------------------------
echo 	%runtaskmsg% %startmsg%
echo --------------------------------------------------
echo ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// >> %LogFile%
echo ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// >> %LogFile%
echo -------------------------------------------------- >> %LogFile%
echo 	%runtaskmsg% %startmsg% >> %LogFile%
echo -------------------------------------------------- >> %LogFile%
taskkill /F /IM %process001%
taskkill /F /IM %process002%

endlocal
