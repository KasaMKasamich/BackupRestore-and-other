@echo off
Title "Import Task Back Up Full"
cls
@echo Task
@cd /d "F:\_BackupRestore\_Tasks-Win10" && schtasks /Create /XML _BackUpFull.xml /TN _BackUpFull
@echo wait
timeout 1
:: @pause
exit
