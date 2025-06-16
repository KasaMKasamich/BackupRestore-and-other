@echo off
@chcp 850 >nul
set startmsg=%date% %time%
SetLocal EnableExtensions EnableDelayedExpansion
echo ////////////////////////////////////////////////////////////////// >> C:\_BackupRestore\DiskPart\VDisks\MountUnMountVDisk.log
echo -------------------------------------------------- >> C:\_BackupRestore\DiskPart\VDisks\MountUnMountVDisk.log
echo     Задание запущенно - %startmsg% >> C:\_BackupRestore\DiskPart\VDisks\MountUnMountVDisk.log
echo -------------------------------------------------- >> C:\_BackupRestore\DiskPart\VDisks\MountUnMountVDisk.log
schtasks /Run /i /TN UnMountVDisk(7Days2Die) /HRESULT >> C:\_BackupRestore\DiskPart\VDisks\MountUnMountVDisk.log
timeout 5
schtasks /Run /i /TN UnMountVDisk(MasterOfOrion) /HRESULT >> C:\_BackupRestore\DiskPart\VDisks\MountUnMountVDisk.log
exit
