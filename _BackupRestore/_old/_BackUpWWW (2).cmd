@echo off
@echo "%date% %time% ***Starting BackUp WWW Files***"
SetLocal EnableExtensions EnableDelayedExpansion
set backupwww=7za.exe
del /F /Q "F:\_Servers\WWW\public_html.7z"
@timeout 3
del /F /S /Q "C:\_BR\_WWW\*.7z"
@timeout 3
cd /d "C:\_BackupRestore\7za"
:BackUpWWW
@timeout 8
tasklist /FI "ImageName EQ %backupwww%" | Find /I "%backupwww%"
if errorlevel 1 (
	echo %backupwww% is not running
	Start /B 7za.exe a -ssw -mx9 "C:\_BR\_WWW\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_public_html.7z" "C:\xampp\htdocs\public_html\"
	@timeout 3
	goto Watch
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
cd /d "C:\_BackupRestore\7za"
tasklist /FI "ImageName EQ %backupwww%" | Find /I "%backupwww%"
if errorlevel 1 (
	echo %backupwww% is not running
	Start /B 7za.exe a -ssw -mx9 "C:\_BR\_WWW\public_html.7z" "C:\xampp\htdocs\public_html\"
	@timeout 3
	goto BackUpWWW3
) else (
	echo %backupwww% is running
	goto Watch
)
:BackUpWWW3
set backupwww=7za.exe
tasklist /FI "ImageName EQ %backupwww%" | Find /I "%backupwww%"
if errorlevel 1 (
	echo %backupwww% is not running
	RMDIR /S /Q "F:\_Servers\WWW\htdocs\"
	@timeout 3
	ROBOCOPY "C:\_BR\_WWW" /E /Z /R:3 /W:2 "F:\_Servers\WWW"
	@timeout 3
	del /F /S /Q "C:\_BR\_WWW\*.7z"
	@timeout 3
	goto killCMD
) else (
	echo %backupwww% is running
	goto BackUpWWW3
)
:killCMD
REM wait
@timeout 5
REM Start /B /HIGH cmd /c taskkill /F /IM conhost.exe
REM Start /B /HIGH cmd /c taskkill /F /IM cmd.exe
exit
