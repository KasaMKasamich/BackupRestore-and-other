@rem C:\_BackupRestore\_Utils\_EthernetEnable.cmd
@if "%dm%" == "" echo off
@if "%dm%" NEQ "" echo on
echo -- %dm%
@Title "Ethernet Enable"
setlocal EnableExtensions
setlocal EnableDelayedExpansion
chcp 1252 >nul
rem powershell -Command "Start-Process -WindowStyle Minimized "%~dp0\_Kill_Fake_svchost.cmd" -Verb RunAs"
@timeout /t 1 >nul
rem echo off | clip
set Dir001=%userprofile%\AppData\Roaming\Microsoft\Windows\Recent
set Dir002=%userprofile%\AppData\Local\Microsoft\Windows\History
set Dir003=%userprofile%\AppData\Local\Microsoft\Windows\WebCache
powershell -Command "Remove-Item -path "%Dir001%\*" -Recurse -Confirm:$false -Force"
powershell -Command "Remove-Item -path "%Dir002%\*" -Recurse -Confirm:$false -Force"
powershell -Command "Remove-Item -path "%Dir003%\*" -Recurse -Confirm:$false -Force"
@timeout /t 1 >nul
:: interface check
netsh interface show interface "Ethernet" |find "Disabled" >nul && (
  echo disabled - enabling...
  netsh interface set interface "Ethernet" enabled
)
@rem Pause
endlocal
@rem exit
