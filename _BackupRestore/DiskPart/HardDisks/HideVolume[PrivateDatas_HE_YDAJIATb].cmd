@echo off
SetLocal EnableExtensions EnableDelayedExpansion
set FileName01=Manage-bde--lock
set FileName02=HideVolume
set LogsDir=C:\_BackupRestore\__Logs
set FileNameSec01=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%TIME:~0,2%_%TIME:~3,2%
set LogFile01=%LogsDir%\%FileNameSec01%_%FileName01%.log
set LogFile02=%LogsDir%\%FileNameSec01%_%FileName02%.log
set VolumeSelected=\\?\Volume{cff95479-0000-0000-0000-100000000000}\
cls
rem manage-bde -lock x: -ForceDismount >> %LogFile01%
manage-bde -lock %VolumeSelected% -ForceDismount
@timeout 3 >nul && diskpart /s "C:\_BackupRestore\DiskPart\HardDisks\Scripts\HideVolume[PrivateDatas_HE_YDAJIATb].txt" >> %LogFile02%
rem exit
