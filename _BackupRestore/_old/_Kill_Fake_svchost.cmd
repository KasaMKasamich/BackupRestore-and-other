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
set process=svchost.exe
set Warningmsg=Process %process% found and killed
set runasmsg=Run as user kill

set LogsDir=C:\_BackupRestore\__Logs\svchost
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
@goto WatchProcessRUNNING
rem STATUS eq, ne RUNNING / NOT RESPONDING / UNKNOWN
REM Watch process
rem tasklist /nh /V /FI "ImageName EQ %process%" /FI "USERNAME NE NT %COMPUTERNAME%\%USERNAME%" /FI "STATUS EQ running" | Find /I "%process%" >> %LogFile%
:Clear
@set /a iTick=!iTick!+1
@if %iTick% == 50 ( cls )

:WatchProcessRUNNING
@tasklist /nh /V /FI "USERNAME EQ %USERNAME%" /FI "STATUS EQ RUNNING" /fo csv |>> %LogFile% find /i "%process%"
@if errorlevel 1 (
	REM @echo %process% is not running
	@goto WatchProcessUNKNOWN
) else (
	echo %Warningmsg% RUNNING (%DATE:~-4%.%DATE:~3,2%.%DATE:~0,2%  %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%)
	@tasklist /nh /M /FI "USERNAME EQ %USERNAME%" /FI "STATUS EQ RUNNING" |>> %LogFile% find /i "%process%"
	@taskkill /F /FI "ImageName EQ %process%" /FI "USERNAME EQ %USERNAME%" /FI "STATUS EQ RUNNING" /IM %process% >> %LogFile%
	@echo ----------------------------------------------------------------------------------------------------------------------------- >> %LogFile%
	REM echo %process% is running
	goto WatchProcessUNKNOWN
)
:WatchProcessUNKNOWN
@tasklist /nh /V /FI "USERNAME EQ %USERNAME%" /FI "STATUS EQ UNKNOWN" /fo csv |>nul find /i "%process%"
@if errorlevel 1 (
	REM @echo %process% is not running
	@goto WatchProcessNOTRESPONDING
) else (
	echo %Warningmsg% UNKNOWN (%DATE:~-4%.%DATE:~3,2%.%DATE:~0,2%  %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%)
	rem netstat -bfq 5
	@echo (%DATE:~-4%.%DATE:~3,2%.%DATE:~0,2%  %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%)>> %LogFile%
	@tasklist /nh /V /FI "USERNAME EQ %USERNAME%" /FI "STATUS EQ UNKNOWN" /fo csv |>> %LogFile% find /i "%process%"
	@tasklist /nh /M /FI "USERNAME EQ %USERNAME%" /FI "STATUS EQ UNKNOWN" |>> %LogFile% find /i "%process%"
	@taskkill /F /FI "ImageName EQ %process%" /FI "USERNAME EQ %USERNAME%" /FI "STATUS EQ UNKNOWN" /IM %process% >> %LogFile%
	
	echo ----------------------------------------------------------------------------------------------------------------------------- >> %LogFile%
	REM echo %process% is running
	@goto WatchProcessNOTRESPONDING
)
:WatchProcessNOTRESPONDING
@tasklist /nh /V /FI "USERNAME EQ %USERNAME%" /FI "STATUS EQ NOT RESPONDING" /fo csv |>> %LogFile% find /i "%process%"
@if errorlevel 1 (
	REM @echo %process% is not running
	@goto Clear
) else (
	echo %Warningmsg% NOTRESPONDING (%DATE:~-4%.%DATE:~3,2%.%DATE:~0,2%  %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%)
	@tasklist /nh /M /FI "USERNAME EQ %USERNAME%" /FI "STATUS EQ NOT RESPONDING" |>> %LogFile% find /i "%process%"
	@taskkill /F /FI "ImageName EQ %process%" /FI "USERNAME EQ %USERNAME%" /FI "STATUS EQ NOT RESPONDING" /IM %process% >> %LogFile%
	echo ----------------------------------------------------------------------------------------------------------------------------- >> %LogFile%
	REM echo %process% is running
	@goto Clear
)
endlocal
