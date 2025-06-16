@echo off
setlocal EnableExtensions
setlocal EnableDelayedExpansion
set FileName01=Manage-bde--unlock
set LogsDir=C:\_BackupRestore\__Logs
set FileNameSec01=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%TIME:~0,2%_%TIME:~3,2%
set LogFile01=%LogsDir%\%FileNameSec01%_%FileName01%.log
set VolumeSelected=\\?\Volume{cff95479-0000-0000-0000-100000000000}\
cls
manage-bde -unlock %VolumeSelected% -pw >nul
rem @timeout 3 >nul && "G:\Archive\Sys\_BackUps\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\SYS\CMD\HardDisks\Video.url" && exit
rem if exist "%VolumeSelected%" echo yes
rem if NOT EXIST "%VolumeSelected%" echo no
@timeout 3 >nul && if exist "%VolumeSelected%" explorer "I:\Users\New\_HardDisks\Video" && exit
