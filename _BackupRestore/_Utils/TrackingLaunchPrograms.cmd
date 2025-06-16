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
set iCycle=
set startmsg="(%TimeStamp%)"
set runtaskmsg=The task run - 
set process[0]=cmd
set process[1]=powershell
set Warningmsg=Process %process% found and killed
set runasmsg=Run as user kill

set LogsDir=C:\_BackupRestore\__Logs\TrackingLaunchPrograms
set LogFileRUNNING="%LogsDir%\%TimeStamp%__RUNNING.log"
set LogFileUNKNOWN="%LogsDir%\%TimeStamp%__UNKNOWN.log"
set LogFileNOTRESPONDING="%LogsDir%\%TimeStamp%__NOTRESPONDING.log"
set LogFile_EQ_MEM_0="%LogsDir%\%TimeStamp%__EQ_MEM_0.log"
set LogFile_LT_MEM_0="%LogsDir%\%TimeStamp%__LT_MEM_0.log"
if not exist "%LogsDir%" mkdir "%LogsDir%"
if exist %LogsDir% goto Start

:Start
echo --------------------------------------------------
echo 	%runtaskmsg% %startmsg%
echo --------------------------------------------------
@goto WatchProcessRUNNING
rem STATUS eq, ne RUNNING / NOT RESPONDING / UNKNOWN
REM Watch process
:Clear
@set /a iTick=!iTick!+1
@if %iTick% == 50 ( cls )
:WatchProcessRUNNING
echo WatchProcessRUNNING
@tasklist /nh /V /FI "STATUS EQ RUNNING" /fo csv >> %LogFileRUNNING%
@if errorlevel 1 (
	REM @echo %process% is not running
	@goto WatchProcessUNKNOWN
) else (
	echo %Warningmsg% RUNNING (!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!)
	@tasklist /nh /M /FI "STATUS EQ RUNNING" >> %LogFileRUNNING%
	@echo ----------------------------------------------------------------------------------------------------------------------------- >> %LogFileRUNNING%
	@goto WatchProcessUNKNOWN
)
exit /b

:WatchProcessUNKNOWN
echo WatchProcessUNKNOWN
@tasklist /nh /V /FI "STATUS EQ UNKNOWN" /fo csv >nul
@if errorlevel 1 (
	REM @echo %process% is not running
	@goto WatchProcessNOTRESPONDING
) else (
	echo %Warningmsg% UNKNOWN (!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!)
	rem netstat -bfq 5
	@echo (!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!)>> %LogFileUNKNOWN%
	@tasklist /nh /V /FI "STATUS EQ UNKNOWN" /fo csv >> %LogFileUNKNOWN%
	@tasklist /nh /M /FI "STATUS EQ UNKNOWN" >> %LogFileUNKNOWN%
	
	echo ----------------------------------------------------------------------------------------------------------------------------- >> %LogFileUNKNOWN%
	REM echo %process% is running
	@goto WatchProcessNOTRESPONDING
)
:WatchProcessNOTRESPONDING
echo WatchProcessNOTRESPONDING
@tasklist /nh /V /FI "STATUS EQ NOT RESPONDING" /fo csv >> %LogFileNOTRESPONDING%
@if errorlevel 1 (
	REM @echo %process% is not running
	@goto WatchProcess_EQ_MEM_0
) else (
	echo %Warningmsg% NOTRESPONDING (!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!)
	@tasklist /nh /M /FI "STATUS EQ NOT RESPONDING" >> %LogFileNOTRESPONDING%
	echo ----------------------------------------------------------------------------------------------------------------------------- >> %LogFileNOTRESPONDING%
	REM echo %process% is running
	@goto WatchProcess_EQ_MEM_0
)
:WatchProcess_EQ_MEM_0
echo Watch Process EQ MEM 0
@tasklist /nh /V /FI "MEMUSAGE EQ 0" /fo csv >nul
@if errorlevel 1 (
	REM @echo %process% is not running
	@goto WatchProcess_LT_MEM_0
) else (
	echo %Warningmsg% UNKNOWN (!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!)
	rem netstat -bfq 5
	@echo (!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!)>> %LogFile_EQ_MEM_0%
	@tasklist /nh /V /FI "MEMUSAGE EQ 0" /fo csv >> %LogFile_EQ_MEM_0%
	@tasklist /nh /M /FI "MEMUSAGE EQ 0" >> %LogFile_EQ_MEM_0%
	
	echo ----------------------------------------------------------------------------------------------------------------------------- >> %LogFileUNKNOWN%
	REM echo %process% is running
	@goto WatchProcess_LT_MEM_0
)
:WatchProcess_LT_MEM_0
echo Watch Process LT MEM 0
@tasklist /nh /V /FI "MEMUSAGE LT 0" /fo csv >nul
@if errorlevel 1 (
	REM @echo %process% is not running
	@goto Clear
) else (
	echo %Warningmsg% UNKNOWN (!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!)
	rem netstat -bfq 5
	@echo (!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!)>> %LogFile_LT_MEM_0%
	@tasklist /nh /V /FI "MEMUSAGE LT 0" /fo csv >> %LogFile_LT_MEM_0%
	@tasklist /nh /M /FI "MEMUSAGE LT 0" >> %LogFile_LT_MEM_0%
	
	echo ----------------------------------------------------------------------------------------------------------------------------- >> %LogFileUNKNOWN%
	REM echo %process% is running
	@goto Clear
)



endlocal
