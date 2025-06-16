@echo off
set startrestorefiles=%date% %time% ***Starting Restore BackUp***
echo %startrestorefiles%
SetLocal EnableExtensions EnableDelayedExpansion
set backuptoolpath=D:\_BackupRestore\7za
set backuptoolpath2=D:\_BackupRestore
set backupspath=G:\Archive\Sys\_BackUps\AppData
set restorepath1=%userprofile%\AppData
set restorepath2=%userprofile%
set backup=7za.exe
set prebackupspath=C:\_BR

mkdir "%prebackupspath%\Yandex\YandexBrowser\User Data\Default"
mkdir "%prebackupspath%\_backups\"
mkdir "%prebackupspath%\Clover\User Data\Default"
mkdir "%prebackupspath%\Skyrim"
mkdir "%prebackupspath%\iSendSMS"
mkdir "%prebackupspath%\NetSarang"
mkdir "%prebackupspath%\Lunascape\Lunascape6\ApplicationData"
mkdir "%prebackupspath%\Lunascape\Lunascape6\Mode"
mkdir "%prebackupspath%\Lunascape\Lunascape6\Profile"
mkdir "%prebackupspath%\_WWW\"
mkdir "C:\_BackupRestore\7za\"
ROBOCOPY "%backuptoolpath%" /E /Z /R:3 /W:2 "C:\_BackupRestore\7za"

cd /d "%backuptoolpath%"

@echo "%date% %time% ***Local Files***"

Start /B /HIGH 7za.exe x "%backupspath%\Local\YandexDataBackup.7z" -o%restorepath1%\Local -r

Start /B /HIGH 7za.exe x "%backupspath%\Local\CloverDataBackup.7z" -o%restorepath1%\Local -r

Start /B /HIGH 7za.exe x "%backupspath%\Local\SkyrimDataBackup.7z" -o%restorepath1%\Local -r

@echo "%date% %time% ***Roaming Files***"

Start /B /HIGH 7za.exe x "%backupspath%\Roaming\iSendSMSDataBackup.7z" -o%restorepath1%\Roaming -r

Start /B /HIGH 7za.exe x "%backupspath%\Roaming\NetSarangDataBackup.7z" -o%restorepath1%\Roaming -r

Start /B /HIGH 7za.exe x "%backupspath%\Roaming\LunascapeDataBackup.7z" -o%restorepath1%\Roaming -r

@echo "%date% %time% ***Desktop Files***"

Start /B /HIGH 7za.exe x "%backupspath%\_LastDesktopBackup.7z" -o%restorepath2% -r

REM wait until started
@timeout 3
@echo "%date% %time% ***Web Server***"

@echo "%date% %time% ***Task***"
cd /d "%backuptoolpath2%\_Tasks" && schtasks /Create /XML _BackUpFiles.xml /TN _BackUpFiles
cd /d "%backuptoolpath2%\_Tasks" && schtasks /Create /XML _BackUpWWW.xml /TN _BackUpWWW

REM wait
@timeout 3
exit
