@echo off
cls
@echo Task
@cd /d "H:\_BackupRestore\_Tasks" && schtasks /Create /XML _BackUpFiles.xml /TN _BackUpFiles
@echo wait
timeout 1
taskkill /F /IM cmd.exe
