@echo off
@chcp 850 >nul
set startmsg=%date% %time%
SetLocal EnableExtensions EnableDelayedExpansion
echo ////////////////////////////////////////////////////////////////// >> C:\_BackupRestore\DiskPart\VDisks\MountUnMountVDisk.log
echo -------------------------------------------------- >> C:\_BackupRestore\DiskPart\VDisks\MountUnMountVDisk.log
echo 	Задание запущенно - %startmsg% >> C:\_BackupRestore\DiskPart\VDisks\MountUnMountVDisk.log
echo -------------------------------------------------- >> C:\_BackupRestore\DiskPart\VDisks\MountUnMountVDisk.log
schtasks /Run /i /TN MountVDisk(J) /HRESULT >> C:\_BackupRestore\DiskPart\VDisks\MountUnMountVDisk.log
exit
