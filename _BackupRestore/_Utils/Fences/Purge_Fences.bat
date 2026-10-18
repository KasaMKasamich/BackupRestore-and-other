@echo off

:: 7/19/17 - Commented out SAS deactivation - awk


:: BatchGotAdmin (Credit: https://sites.google.com/site/eneerge/scripts/batchgotadmin)
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

::Kill explorer
taskkill /f /im explorer.exe

::Wipe the registry
reg query HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /v Fences
if not ErrorLevel 1 (
  reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /v Fences /f
) else (
  echo.
)

reg query HKEY_CURRENT_USER\Software\Stardock\Fences
if not ErrorLevel 1 (
  reg delete HKEY_CURRENT_USER\Software\Stardock\Fences /f
) else (
  echo.
)

reg query HKEY_LOCAL_MACHINE\Software\Stardock\Misc\Fences
if not ErrorLevel 1 (
  reg delete HKEY_LOCAL_MACHINE\Software\Stardock\Misc\Fences /f
) else (
  echo.
) 


reg query HKEY_LOCAL_MACHINE\Software\Wow6432Node\Stardock\Misc\Fences
if not ErrorLevel 1 (
  reg delete HKEY_LOCAL_MACHINE\Software\Wow6432Node\Stardock\Misc\Fences /f
) else (
  echo.
)

reg query HKEY_LOCAL_MACHINE\Software\Stardock\ObjectDesktop\FencesPro
if not ErrorLevel 1 (
  reg delete HKEY_LOCAL_MACHINE\Software\Stardock\ObjectDesktop\FencesPro /f
) else (
  echo.
) 

reg query HKEY_LOCAL_MACHINE\Software\Wow6432Node\Stardock\ObjectDesktop\FencesPro
if not ErrorLevel 1 (
  reg delete HKEY_LOCAL_MACHINE\Software\Wow6432Node\Stardock\ObjectDesktop\FencesPro /f
) else (
  echo.
)

reg query HKEY_CURRENT_USER\Software\Stardock\Fences2
if not ErrorLevel 1 (
  reg delete HKEY_CURRENT_USER\Software\Stardock\Fences2 /f
) else (
  echo.
)

reg query HKEY_LOCAL_MACHINE\Software\Stardock\Misc\Fences2
if not ErrorLevel 1 (
  reg delete HKEY_LOCAL_MACHINE\Software\Stardock\Misc\Fences2 /f
) else (
  echo.
) 


reg query HKEY_LOCAL_MACHINE\Software\Wow6432Node\Stardock\Misc\Fences2
if not ErrorLevel 1 (
  reg delete HKEY_LOCAL_MACHINE\Software\Wow6432Node\Stardock\Misc\Fences2 /f
) else (
  echo.
)

reg query HKEY_CURRENT_USER\Software\Stardock\Fences3
if not ErrorLevel 1 (
  reg delete HKEY_CURRENT_USER\Software\Stardock\Fences3 /f
) else (
  echo.
)

reg query HKEY_LOCAL_MACHINE\Software\Stardock\Misc\Fences3
if not ErrorLevel 1 (
  reg delete HKEY_LOCAL_MACHINE\Software\Stardock\Misc\Fences3 /f
) else (
  echo.
) 


reg query HKEY_LOCAL_MACHINE\Software\Wow6432Node\Stardock\Misc\Fences3
if not ErrorLevel 1 (
  reg delete HKEY_LOCAL_MACHINE\Software\Wow6432Node\Stardock\Misc\Fences3 /f
) else (
  echo.
)


::Unregister DLLs

taskkill /im fences.exe 2> nul
taskkill /im rundll32.exe 2> nul
::IF EXIST "%programfiles(x86)%\Stardock\Fences\ "%programfiles(x86)%\Stardock\Fences\fences.exe" /unlockbinaries
::IF EXIST "%programfiles%\Stardock\Fences\ "%programfiles%\Stardock\Fences\fences.exe" /unlockbinaries

IF EXIST "%programfiles(x86)%\Stardock\Fences\DesktopDock64.dll" regsvr32 /s /u "%programfiles(x86)%\Stardock\Fences\DesktopDock64.dll"
IF EXIST "%programfiles%\Stardock\Fences\DesktopDock64.dll" regsvr32 /s /u "%programfiles%\Stardock\Fences\DesktopDock64.dll"
IF EXIST "%programfiles(x86)%\Stardock\Fences\FencesMenu64.dll" regsvr32 /s /u "%programfiles(x86)%\Stardock\Fences\FencesMenu64.dll"
IF EXIST "%programfiles%\Stardock\Fences\FencesMenu64.dll" regsvr32 /s /u "%programfiles%\Stardock\Fences\FencesMenu64.dll"
IF EXIST "%programfiles(x86)%\Stardock\Fences\DesktopDock.dll" regsvr32 /s /u "%programfiles(x86)%\Stardock\Fences\DesktopDock.dll"
IF EXIST "%programfiles%\Stardock\Fences\DesktopDock.dll" regsvr32 /s /u "%programfiles%\Stardock\Fences\DesktopDock.dll"
IF EXIST "%programfiles(x86)%\Stardock\Fences\FencesMenu.dll" regsvr32 /s /u "%programfiles(x86)%\Stardock\Fences\FencesMenu.dll"
IF EXIST "%programfiles%\Stardock\Fences\FencesMenu.dll" regsvr32 /s /u "%programfiles%\Stardock\Fences\FencesMenu.dll"


::Clean license data
::IF EXIST "%programfiles(x86)%\Stardock\Fences" "%programfiles(x86)%\Stardock\Fences\SdDisplay.exe" -deactivate -prodID=2240 -prodName="Fences" -company="Stardock" -prodVer="2.08"
::IF EXIST "%programfiles%\Stardock\Fences" "%programfiles%\Stardock\Fences\SdDisplay.exe" -deactivate -prodID=2240 -prodName="Fences" -company="Stardock" -prodVer="2.08"
::IF EXIST "%programfiles(x86)%\Stardock\Fences" "%programfiles(x86)%\Stardock\Fences\SdDisplay.exe" -deactivate -prodID=2628 -prodName="Fences" -company="Stardock" -prodVer="3.00"
::IF EXIST "%programfiles%\Stardock\Fences" "%programfiles%\Stardock\Fences\SdDisplay.exe" -deactivate -prodID=2628 -prodName="Fences" -company="Stardock" -prodVer="3.00"
IF EXIST "%programdata%\Stardock\Fences2\*.*" del "%programdata%\Stardock\Fences2\*.*" /q
IF EXIST "%programdata%\Stardock\Fences2" RMDIR "%programdata%\Stardock\Fences2" /s /q
IF EXIST "%programdata%\Stardock\Registrations\Fences2\*.*" del "%programdata%\Stardock\Registrations\Fences2\*.*" /q
IF EXIST "%programdata%\Stardock\Registrations\Fences2" RMDIR "%programdata%\Stardock\Registrations\Fences2" /s /q
IF EXIST "%programdata%\Stardock\Registrations\Fences\*.*" del "%programdata%\Stardock\Registrations\Fences\*.*" /q
IF EXIST "%programdata%\Stardock\Registrations\Fences" RMDIR "%programdata%\Stardock\Registrations\Fences" /s /q
IF EXIST "%programdata%\Stardock\Fences\*.*" del "%programdata%\Stardock\Fences\*.*" /q
IF EXIST "%programdata%\Stardock\Fences" RMDIR "%programdata%\Stardock\Fences" /s /q
IF EXIST "%programdata%\Stardock\Fences3\*.*" del "%programdata%\Stardock\Fences3\*.*" /q
IF EXIST "%programdata%\Stardock\Fences3" RMDIR "%programdata%\Stardock\Fences3" /s /q

::Call Fences uninstaller
(
echo MSGBOX "Fences is about to uninstall. If asked to reboot, select 'No'. Select [OK] to continue." > %temp%\TEMPmessage.vbs
call %temp%\TEMPmessage.vbs
del %temp%\TEMPmessage.vbs /f /q
)

IF EXIST "%programfiles(x86)%\Stardock\Fences" "%programfiles(x86)%\Stardock\Fences\uninstall.exe" /u:"%programfiles(x86)%\Stardock\Fences\uninstall\uninstall.xml"
IF EXIST "%programfiles%\Stardock\Fences" "%programfiles%\Stardock\Fences\uninstall.exe" /u:"%programfiles%\Stardock\Fences\uninstall\uninstall.xml"


::Remove program files
IF EXIST "%programfiles(x86)%\Stardock\Fences\*.*" del "%programfiles(x86)%\Stardock\Fences\*.*" /q
IF EXIST "%programfiles(x86)%\Stardock\Fences" RMDIR "%programfiles(x86)%\Stardock\Fences" /s /q

IF EXIST "%programfiles%\Stardock\Fences\*.*" del "%programfiles%\Stardock\Fences\*.*" /q
IF EXIST "%programfiles%\Stardock\Fences" RMDIR "%programfiles%\Stardock\Fences" /s /q

::Rename Roaming
::IF EXIST %appdata%\Stardock\Fences move %appdata%\Stardock\Fences %appdata%\Stardock\Fences_old
::IF EXIST %appdata%\Stardock\Fences\*.*" del %appdata%\Stardock\Fences\*.*" /q
::IF EXIST %appdata%\Stardock\Fences RMDIR %appdata%\Stardock\Fences
IF EXIST %appdata%\Stardock\Fences\TroubleshootingLog move %appdata%\Stardock\Fences\TroubleshootingLog %appdata%\Stardock\Fences\TroubleshootingLog_old
IF EXIST %appdata%\Stardock\Fences\TroubleshootingLog\*.*" del %appdata%\Stardock\Fences\TroubleshootingLog\*.*" /q
IF EXIST %appdata%\Stardock\Fences\TroubleshootingLog RMDIR %appdata%\Stardock\Fences\TroubleshootingLog

::CLean start menu
IF EXIST "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Stardock\Fences.lnk" del "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Stardock\Fences.lnk"

start explorer.exe
(
echo MSGBOX "Reboot your PC to complete the purge. Select [OK] to continue." > %temp%\TEMPmessage.vbs
call %temp%\TEMPmessage.vbs
del %temp%\TEMPmessage.vbs /f /q
)
