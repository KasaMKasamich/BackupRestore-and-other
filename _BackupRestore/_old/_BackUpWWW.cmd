@echo off
cls
@echo "%date% %time% ***Starting BackUp WWW Files***"
SetLocal EnableExtensions EnableDelayedExpansion
:BackUpWWW
set backupwww=7za.exe
del /F /Q "H:\_Servers\WWW\public_html.7z"

cd /d "H:\_BackupRestore\7za"

timeout 8

tasklist /FI "ImageName EQ %backupwww%" | Find /I "%backupwww%"
if errorlevel 1 (
	echo %backupwww% is not running
	Start /B 7za.exe a -ssw -mx9 "H:\_Servers\WWW\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_public_html.7z" "C:\xampp\htdocs\public_html\"
) else (
	echo %backupwww% is running
	goto BackUpWWW
)
:Watch
set backupwww=7za.exe
tasklist /FI "ImageName EQ %backupwww%" | Find /I "%backupwww%"
if errorlevel 1 (
	echo %backupwww% is not running
	goto BackUpWWW2
) else (
	echo %backupwww% is running
	goto Watch
)
:BackUpWWW2
set backupwww=7za.exe
cd /d "H:\_BackupRestore\7za"
tasklist /FI "ImageName EQ %backupwww%" | Find /I "%backupwww%"
if errorlevel 1 (
	echo %backupwww% is not running
	Start /B 7za.exe a -ssw -mx9 "H:\_Servers\WWW\public_html.7z" "C:\xampp\htdocs\public_html\"
	goto BackUpWWW3
) else (
	echo %backupwww% is running
	goto Watch
)

:BackUpWWW3
RMDIR /S /Q "H:\_Servers\WWW\htdocs\"

cd /d "C:\xampp\"
ROBOCOPY "C:\xampp\htdocs" /E /Z /R:3 /W:2 "H:\_Servers\WWW\htdocs"

goto killCMD

:killCMD
REM wait
timeout 5
Start /B /HIGH cmd /c taskkill /F /IM conhost.exe
Start /B /HIGH cmd /c taskkill /F /IM cmd.exe

