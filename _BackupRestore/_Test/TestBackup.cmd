@echo off
SetLocal EnableExtensions EnableDelayedExpansion
color 0A
chcp 1252 >nul
:: chcp 1251 >nul
:: chcp 866 >nul
:: %USERNAME%
set startmsg=Начата архивация файлов
:: 
set isAppRunning=2
set backuptooldir=C:\_BackupRestore\7za
set backuptoolName=7za
set backuptool=7za.exe
set FileName=TestBackup
set Dir01=C:\_BackupRestore
set BackupsDir=F:\Archive\_BackUps
:: F:\Archive\_BackUps\_ToSysDriveRoot
set DestinationDir001=F:\Archive\_BackUps
:: 
set LogsDir=F:\Archive\__Logs
set FileNameSec01=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%TIME:~0,2%_%TIME:~3,2%_%TIME:~6,2%
set LogFile=%LogsDir%\%FileNameSec01%__%FileName%.log
set backuptoolLogFile=%LogsDir%\%FileNameSec01%__%backuptoolName%.log
set RoboCopyLogFile=%LogsDir%\%FileNameSec01%__%FileName%.txt
:: 
cls
:: 
echo %DATE:~-4%.%DATE:~3,2%.%DATE:~0,2%  %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2% - %startmsg%
rem tasklist /FI "USERNAME ne NT %COMPUTERNAME%\%USERNAME%" /FI "STATUS eq running" /FI "ImageName EQ %backuptool%" | Find /I "%backuptool%"
rem tasklist /nh /V /FI "USERNAME EQ %USERNAME%" /FI "STATUS EQ RUNNING" /fo csv |>> %LogFile% find /i "%backuptool%"
:: tasklist /nh /V /FI "USERNAME EQ %USERNAME%" /FI "ImageName EQ %backuptool%" /FI "STATUS EQ RUNNING" /fo csv | find /i "%backuptool%">> %LogFile%
::
:WatchBackupTool
if "%isAppRunning%"=="2" (
	call tasklist /nh /V /FI "USERNAME EQ %USERNAME%" /FI "ImageName EQ %backuptool%" /fo csv | find /i "%backuptool%">> %LogFile%
	if errorlevel 1 (
		:: backuptool is not running
		call :isNotRunning
	) else (
		:: backuptool is running
		echo "%backuptool% Запущен под пользователем - %COMPUTERNAME%\%USERNAME% - %date% | %time%"
		call :isRunning
	)
) else (
	call tasklist /nh /V /FI "USERNAME EQ %USERNAME%" /FI "ImageName EQ %backuptool%" /fo csv | find /i "%backuptool%">> %LogFile%
	if errorlevel 1 (
		:: backuptool is not running
		call set isAppRunning=0
		call :End1
	) else (
		:: backuptool is running
		call tasklist /nh /V /FI "USERNAME EQ %USERNAME%" /FI "ImageName EQ %backuptool%" /fo table | find /i "%backuptool%"
		call :isRunning
	)
)

:isNotRunning
rem chcp 866 >nul
:: Подготовка к архивированию
if "%isAppRunning%"=="2" (
	call echo Step1 >> "%LogFile%"
	call cd /d %backuptooldir%
	Start /B %backuptool% u -ssw -mx9 "%BackupsDir%\_ToSysDriveRoot\%FileNameSec01%_%FileName%.7z" "%Dir01%\" >> "%backuptoolLogFile%"
	rem Start /WAIT /B %backuptool% u -ssw -mx9 "%BackupsDir%\_ToSysDriveRoot\%FileNameSec01%_%FileName%.7z" "%Dir01%\" >> "%backuptoolLogFile%"
	call set isAppRunning=1
)
call :isRunning

:isRunning
tasklist /nh /V /FI "USERNAME EQ %USERNAME%" /FI "ImageName EQ %backuptool%" /fo csv | find /i "%backuptool%">> %LogFile%
echo %isAppRunning% >> "%LogFile%"
call :WatchBackupTool

:End1
echo %isAppRunning% >> "%LogFile%"
echo ----------------------------------------------------------------------------------------------------------------------------- >> "%LogFile%"
echo finish at: %DATE:~-4%.%DATE:~3,2%.%DATE:~0,2%  %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%
@timeout 5 >nul
REM call :Step2
exit
