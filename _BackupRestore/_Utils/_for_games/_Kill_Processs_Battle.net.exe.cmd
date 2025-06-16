@echo off
SetLocal EnableExtensions EnableDelayedExpansion
taskkill /F /IM Agent.exe
taskkill /F /IM Battle.net.exe
EndLocal
exit /b
exit
