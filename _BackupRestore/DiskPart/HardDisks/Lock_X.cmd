@echo off
setlocal EnableExtensions
setlocal EnableDelayedExpansion
set FileName01=Manage-bde--lock
set LogsDir=C:\_BackupRestore\__Logs
set FileNameSec01=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%TIME:~0,2%_%TIME:~3,2%
set LogFile01=%LogsDir%\%FileNameSec01%_%FileName01%.log
set VolumeSelected=\\?\Volume{62a21ef8-91e7-11e9-b150-08606e7e3562}\
cls
@timeout 3 >nul && if exist "%VolumeSelected%" manage-bde -lock %VolumeSelected% -ForceDismount >nul && exit
rem manage-bde -lock %VolumeSelected% -ForceDismount >nul
rem  >> "%LogFile01%"
rem @timeout 1 >nul && exit
