@echo off
set startrestorefiles=%date% %time% ***Starting Restore BackUp***
echo %startrestorefiles%
SetLocal EnableExtensions EnableDelayedExpansion
Rem echo %USERNAME%
Rem echo %userprofile%
set prebackupspath=C:\_BR
set backuptoolpath=D:\_BackupRestore\7za
set backupRestoreDir01=D:\_BackupRestore
set backupRestoreDir02=C:\_BackupRestore
set backupspath01=D:\Archive\_BackUps
set backupspath02=G:\Archive\Sys\_BackUps\AppData
set restorepath01="C:\Program Files"
set restorepath02="C:\Program Files (x86)"
set restorepath03=C:\ProgramData
set restorepath04=%userprofile%\AppData
set restorepath05=%userprofile%
set backupTool=7za.exe
Rem Create folders
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
Rem Starting copy BackUp files 1
ROBOCOPY "%backupRestoreDir01%" /E /Z /R:3 /W:2 "%backupRestoreDir02%"
ROBOCOPY "%backupspath01%\Program Files" /E /Z /R:3 /W:2 "%restorepath01%"
ROBOCOPY "%backupspath01%\Program Files (x86)" /E /Z /R:3 /W:2 "%restorepath02%"
ROBOCOPY "%backupspath01%\ProgramData" /E /Z /R:3 /W:2 "%restorepath03%"
Rem Starting copy BackUp files 2
Rem ROBOCOPY "%backuptoolpath%" /E /Z /R:3 /W:2 "C:\_BackupRestore\7za"

cd /d "%backuptoolpath%"

@echo "%date% %time% ***Local Files***"

Start /B /HIGH 7za.exe x "%backupspath02%\Local\YandexDataBackup.7z" -o%restorepath04%\Local -r

Rem Start /B /HIGH 7za.exe x "%backupspath02%\Local\CloverDataBackup.7z" -o%restorepath04%\Local -r

Start /B /HIGH 7za.exe x "%backupspath02%\Local\SkyrimDataBackup.7z" -o%restorepath04%\Local -r

@echo "%date% %time% ***Roaming Files***"

Start /B /HIGH 7za.exe x "%backupspath02%\Roaming\iSendSMSDataBackup.7z" -o%restorepath04%\Roaming -r

Start /B /HIGH 7za.exe x "%backupspath02%\Roaming\NetSarangDataBackup.7z" -o%restorepath04%\Roaming -r

Rem Start /B /HIGH 7za.exe x "%backupspath02%\Roaming\LunascapeDataBackup.7z" -o%restorepath04%\Roaming -r

@echo "%date% %time% ***Desktop Files***"

Start /B /HIGH 7za.exe x "%backupspath02%\_LastDesktopBackup.7z" -o%restorepath05% -r

REM wait until started
@timeout 3
@echo "%date% %time% ***Web Server***"

@echo "%date% %time% ***Task***"
cd /d "%backupRestoreDir02%\_Tasks" && schtasks /Create /XML _BackUpFiles.xml /TN _BackUpFiles
cd /d "%backupRestoreDir02%\_Tasks" && schtasks /Create /XML _BackUpWWW.xml /TN _BackUpWWW

REM wait
@timeout 3
exit
