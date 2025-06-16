@echo off
color 0A
set string=Start simple task list
echo %string%
SetLocal EnableExtensions EnableDelayedExpansion
cd
Start /B /HIGH C:\Python27\python.exe "H:\_BackupRestore\Python\simple_tasklist.py"
@timeout 3
