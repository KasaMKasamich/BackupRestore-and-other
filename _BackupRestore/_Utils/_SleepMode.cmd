@echo off
chcp 1252 >nul
setlocal EnableExtensions
setlocal EnableDelayedExpansion
:: Wait
taskkill /F /IM dllhost.exe
taskkill /F /IM rundll32.exe
@timeout 3
:: Start Sleep Mode
powercfg -hibernate off
C:\Windows\System32\rundll32.exe powrprof.dll,SetSuspendState 0,1,0
exit /b
