:: Get Dir Size
@echo on
Title "Get Dir Size"
SetLocal EnableExtensions EnableDelayedExpansion
:: chcp 1251 >nul
:: chcp 1252 >nul
:: chcp 866 >nul
::  Time
set digit1=%time:~0,1%
if "%digit1%"==" " (set digit1=0)
set TimeStamp=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%digit1%%TIME:~1,1%_%TIME:~3,2%_%TIME:~6,2%
::  bool
::  int
set /A KB=1*1024
set /A MB=400*1048576
::  Папки
set Dir001=%userprofile%\AppData\Local
set LogsDir=C:\_BackupRestore\__Logs
::  Files
set FileName=GetDirSize.log
set LogFile=%LogsDir%\%TimeStamp%_%FileName%.log
::  Self Backup
copy /v /y %0 %~dp0__BatchBackup\%~n0__%TimeStamp%%~x0
:: 
for %%i in ("%~dp1") do set "CurDir=%%~fi"
rem %UnrealPak% %1 -Extract "%CurDir%\"
echo %~dp0__BatchBackup\%~n0__%TimeStamp%%~x0
echo %~dp1\%~n1

@pause