@echo off
setlocal EnableExtensions
setlocal EnableDelayedExpansion
set start=%date% %time% ***Starting Kill DLL's Processes***
echo %start%
@rem taskkill /f /im shellexperiencehost.exe
taskkill /F /t /IM dllhost.exe
taskkill /F /t /IM rundll32.exe
@cd /D %~dp0
@call _Kill_CMD.cmd cmd.exe
@rem @timeout 1
@rem exit