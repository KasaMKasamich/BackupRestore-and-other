@echo off
chcp 1252 >nul
setlocal EnableExtensions
setlocal EnableDelayedExpansion
:: interface check
netsh interface show interface "Ethernet" |find "Enabled" >nul && (
  echo enabled - disabling
  netsh interface set interface "Ethernet" disabled
)
endlocal
@rem exit
