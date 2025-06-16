@echo off
Title "Import Task Back Up Full"
cls
@echo Task
@cd /d "C:\_BackupRestore\_Tasks-Win10" && schtasks /Create /XML _BackUpFull_Laptop.xml /TN _BackUpFull_Laptop
@echo wait
timeout 1
:: @pause
exit
