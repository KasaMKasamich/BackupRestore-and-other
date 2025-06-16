@echo off
chcp 1252 >nul
setlocal EnableExtensions
setlocal EnableDelayedExpansion
:: interface check
::netsh interface show interface "Ethernet" |find "Enabled" >nul && (
::  echo enabled - disabling
::  netsh interface set interface "Ethernet" disabled
::)
:: Wait
taskkill /F /IM dllhost.exe
taskkill /F /IM rundll32.exe
@timeout 3
:: Start Hibernation
powercfg -hibernate on
C:\Windows\System32\rundll32.exe powrprof.dll,SetSuspendState
@rem exit
