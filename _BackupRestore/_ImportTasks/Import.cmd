@echo off
cls
@echo Task
@cd /d "D:\_BackupRestore\_Tasks" && schtasks /Create /XML _BackUpFiles.xml /TN _BackUpFiles
@echo wait
timeout 1
exit
