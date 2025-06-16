@echo on
setlocal enableextensions enabledelayedexpansion
@set Title=%~n1

regsvr32.exe "C:\Windows\System32\syncui.dll"