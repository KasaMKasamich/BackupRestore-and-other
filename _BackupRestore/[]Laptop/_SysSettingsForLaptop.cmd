:: _SysSettings
:: 
@echo off
Title "Sys Settings"
setlocal enableextensions enabledelayedexpansion
:: chcp 1251 >nul
chcp 1252 >nul
:: chcp 866 >nul
set WebBrowsersData=D:\[]WebBrowsersData
setx OperaGXBrowserSwitches "--save-page-as-mhtml --user-data-dir=%WebBrowsersData%\OperaGX --disk-cache-dir=%WebBrowsersData%\OperaGX"
if not exist "%WebBrowsersData%\OperaGX" mkdir "%WebBrowsersData%\OperaGX"
REM reg query HKEY_CLASSES_ROOT\YandexFB2\shell\open\command
REM if %ERRORLEVEL% EQU 0 (
	REM echo yes
REM ) else (
REM )
reg delete hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments /v SaveZoneInformation /f
reg add hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments /v SaveZoneInformation /t reg_dword /d 1
reg IMPORT "C:\_BackupRestore\[]Reg\Laptop\User Shell Folders.reg" /reg:64

@REM reg delete hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Associations /v LowRiskFileTypes /f
@REM reg add hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Associations /v LowRiskFileTypes /t reg_sz /d .xlsx,.docx,.xls,.doc,.ppt,.pptx,.exe,.7z,.zip,.rar
endlocal
:: @pause
@rem exit
