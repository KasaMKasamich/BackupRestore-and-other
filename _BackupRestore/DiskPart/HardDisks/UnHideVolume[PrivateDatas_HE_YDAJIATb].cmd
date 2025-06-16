@echo off
SetLocal EnableExtensions EnableDelayedExpansion
set FileName01=Manage-bde--unlock
set FileName02=UnHideVolume
set LogsDir=C:\_BackupRestore\__Logs
set FileNameSec01=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%TIME:~0,2%_%TIME:~3,2%
set LogFile01=%LogsDir%\%FileNameSec01%_%FileName01%.log
set LogFile02=%LogsDir%\%FileNameSec01%_%FileName02%.log
set VolumeSelected=\\?\Volume{cff95479-0000-0000-0000-100000000000}\
cls
diskpart /s "C:\_BackupRestore\DiskPart\HardDisks\Scripts\UnHideVolume[PrivateDatas_HE_YDAJIATb].txt" >> %LogFile02%
@timeout 3 >nul && manage-bde -unlock %VolumeSelected% -pw
@timeout 3 >nul && "G:\Archive\Sys\_BackUps\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\SYS\CMD\HardDisks\XXX.url" && exit
rem manage-bde -unlock x: -pw >> %LogFile01%
rem exit
