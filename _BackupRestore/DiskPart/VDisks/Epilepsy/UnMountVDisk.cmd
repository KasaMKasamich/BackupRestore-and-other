@echo off
@chcp 850 >nul
set startmsg=%date% %time%
SetLocal EnableExtensions EnableDelayedExpansion
cd
diskpart /s "C:\_BackupRestore\DiskPart\VDisks\Scripts\UnMountVDisk[Epilepsy].txt" >> C:\_BackupRestore\DiskPart\VDisks\MountUnMountVDisk.log
exit
