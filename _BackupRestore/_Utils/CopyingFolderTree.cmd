@ECHO OFF
SetLocal EnableExtensions EnableDelayedExpansion
chcp 1252 >nul
color 0A
:start
rem Переменные
set SourceDir001=I:\Users\New
set DestinationFolder=I:\_TempBackup
set LogsDir=%DestinationFolder%
set FileName=TestROBOCOPY
set FileNameSec01=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%TIME:~0,2%_%TIME:~3,2%
set LogFile=%LogsDir%\%FileNameSec01%_%FileName%.log
set RoboCopyLogFile=%LogsDir%\%FileNameSec01%_%FileName%.txt
cls
REM Копирование дерева папок
xcopy "%SourceDir001%" "%DestinationFolder%" /Y /Z /K /E /T
rem ROBOCOPY "%SourceDir001%" "%DestinationFolder%" /TBD /MIR /ZB /R:3 /W:2 /MT:32 /LOG:"%RoboCopyLogFile%" /XJD /XJF /XA:RAHCNETO /COPYALL /DCOPY:DAT
