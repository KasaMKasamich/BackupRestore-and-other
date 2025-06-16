:: _SysSettings
:: 
@echo off
Title "Sys Settings"
setlocal enableextensions enabledelayedexpansion
:: chcp 1251 >nul
chcp 1252 >nul
:: chcp 866 >nul
setx YandexBrowserSwitches "--save-page-as-mhtml --user-data-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData --disk-cache-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData"
setx GoogleBrowserSwitches "--save-page-as-mhtml --user-data-dir=I:\ProgramFiles\_WebBrowserDatas\Google\Chrome\UserData --disk-cache-dir=I:\ProgramFiles\_WebBrowserDatas\Google\Chrome\UserData"
setx OperaBrowserSwitches "--save-page-as-mhtml --user-data-dir=I:\ProgramFiles\_WebBrowserDatas\OperaSoftware\OperaStable --disk-cache-dir=I:\ProgramFiles\_WebBrowserDatas\OperaSoftware\OperaStable"
setx OperaGXBrowserSwitches "--save-page-as-mhtml --user-data-dir=I:\ProgramFiles\_WebBrowserDatas\OperaSoftware\OperaGX --disk-cache-dir=I:\ProgramFiles\_WebBrowserDatas\OperaSoftware\OperaGX"
setx FirefoxBrowserSwitches "-profile "I:\ProgramFiles\_WebBrowserDatas\Mozilla\Firefox\Profiles\DefaultUser"
if not exist "I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData" mkdir "I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData"
if not exist "I:\ProgramFiles\_WebBrowserDatas\Google\Chrome\UserData" mkdir "I:\ProgramFiles\_WebBrowserDatas\Google\Chrome\UserData"
if not exist "I:\ProgramFiles\_WebBrowserDatas\OperaSoftware\OperaStable" mkdir "I:\ProgramFiles\_WebBrowserDatas\OperaSoftware\OperaStable"
if not exist "I:\ProgramFiles\_WebBrowserDatas\OperaSoftware\OperaGX" mkdir "I:\ProgramFiles\_WebBrowserDatas\OperaSoftware\OperaGX"
REM reg query HKEY_CLASSES_ROOT\YandexFB2\shell\open\command
REM if %ERRORLEVEL% EQU 0 (
	REM echo yes
REM ) else (
REM )
reg add HKEY_CLASSES_ROOT\YandexFB2\shell\open\command /ve /t REG_SZ /f /d "\"C:\Program Files (x86)\Yandex\YandexBrowser\Application\browser.exe\" --save-page-as-mhtml --user-data-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData --disk-cache-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData -- \"%1\""
reg add HKEY_CLASSES_ROOT\YandexGIF\shell\open\command /ve /t REG_SZ /f /d "\"C:\Program Files (x86)\Yandex\YandexBrowser\Application\browser.exe\" --save-page-as-mhtml --user-data-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData --disk-cache-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData -- \"%1\""
reg add HKEY_CLASSES_ROOT\YandexHTML\shell\open\command /ve /t REG_SZ /f /d "\"C:\Program Files (x86)\Yandex\YandexBrowser\Application\browser.exe\" --save-page-as-mhtml --user-data-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData --disk-cache-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData -- \"%1\""
reg add HKEY_CLASSES_ROOT\YandexJPEG\shell\open\command /ve /t REG_SZ /f /d "\"C:\Program Files (x86)\Yandex\YandexBrowser\Application\browser.exe\" --save-page-as-mhtml --user-data-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData --disk-cache-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData -- \"%1\""
reg add HKEY_CLASSES_ROOT\YandexPDF\shell\open\command /ve /t REG_SZ /f /d "\"C:\Program Files (x86)\Yandex\YandexBrowser\Application\browser.exe\" --save-page-as-mhtml --user-data-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData --disk-cache-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData -- \"%1\""
reg add HKEY_CLASSES_ROOT\YandexPNG\shell\open\command /ve /t REG_SZ /f /d "\"C:\Program Files (x86)\Yandex\YandexBrowser\Application\browser.exe\" --save-page-as-mhtml --user-data-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData --disk-cache-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData -- \"%1\""
reg add HKEY_CLASSES_ROOT\YandexSWF\shell\open\command /ve /t REG_SZ /f /d "\"C:\Program Files (x86)\Yandex\YandexBrowser\Application\browser.exe\" --save-page-as-mhtml --user-data-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData --disk-cache-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData -- \"%1\""
reg add HKEY_CLASSES_ROOT\YandexTIFF\shell\open\command /ve /t REG_SZ /f /d "\"C:\Program Files (x86)\Yandex\YandexBrowser\Application\browser.exe\" --save-page-as-mhtml --user-data-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData --disk-cache-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData -- \"%1\""
reg add HKEY_CLASSES_ROOT\YandexTXT\shell\open\command /ve /t REG_SZ /f /d "\"C:\Program Files (x86)\Yandex\YandexBrowser\Application\browser.exe\" --save-page-as-mhtml --user-data-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData --disk-cache-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData -- \"%1\""
reg add HKEY_CLASSES_ROOT\YandexWEBM\shell\open\command /ve /t REG_SZ /f /d "\"C:\Program Files (x86)\Yandex\YandexBrowser\Application\browser.exe\" --save-page-as-mhtml --user-data-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData --disk-cache-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData -- \"%1\""
reg add HKEY_CLASSES_ROOT\YandexWEBP\shell\open\command /ve /t REG_SZ /f /d "\"C:\Program Files (x86)\Yandex\YandexBrowser\Application\browser.exe\" --save-page-as-mhtml --user-data-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData --disk-cache-dir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser\UserData -- \"%1\""

reg delete hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments /v SaveZoneInformation /f
reg add hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments /v SaveZoneInformation /t reg_dword /d 1

@REM reg delete hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Associations /v LowRiskFileTypes /f
@REM reg add hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Associations /v LowRiskFileTypes /t reg_sz /d .xlsx,.docx,.xls,.doc,.ppt,.pptx,.exe,.7z,.zip,.rar
endlocal
:: @pause
@rem exit
