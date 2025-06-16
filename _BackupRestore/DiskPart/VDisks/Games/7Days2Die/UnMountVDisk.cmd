@echo off
@chcp 850 >nul
set startmsg=%date% %time%
SetLocal EnableExtensions EnableDelayedExpansion
diskpart /s "C:\_BackupRestore\DiskPart\VDisks\Scripts\Games\UnMountVDisk[7Days2Die].txt" >> C:\_BackupRestore\DiskPart\VDisks\MountUnMountVDisk.log
exit
