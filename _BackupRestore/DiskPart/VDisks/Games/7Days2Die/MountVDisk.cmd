@echo off
rem @chcp 850 >nul
rem set startmsg=%date% %time%
rem SetLocal EnableExtensions EnableDelayedExpansion
diskpart /s "C:\_BackupRestore\DiskPart\VDisks\Scripts\Games\MountVDisk[7Days2Die].txt" >> C:\_BackupRestore\DiskPart\VDisks\MountUnMountVDisk.log
exit
