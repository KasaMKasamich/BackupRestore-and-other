@echo off
set startbackupxampp=%date% %time% Starting BackUp Xampp
echo %startbackupxampp%
SetLocal EnableExtensions EnableDelayedExpansion
set appbackup=7za.exe
set prebackupspath=C:\_BR
set prebackupsxampppath=%prebackupspath%\_Xampp
set prebackupsxampppath2=%prebackupspath%\_Xampp_backups
set backupspath=G:\_Servers\
set backupspath2=G:\_Servers\xampp
set backuptoolpath=C:\_BackupRestore\7za
set backuptoolpath2=C:\_BackupRestore
@timeout 3
RMDIR /S /Q "%prebackupsxampppath%\"
RMDIR /S /Q "%prebackupsxampppath2%\"
@timeout 3
mkdir "%prebackupsxampppath%\"
mkdir "%prebackupsxampppath%\apache\conf"
mkdir "%prebackupsxampppath%\php"
mkdir "%prebackupsxampppath%\mysql\bin"
mkdir "%prebackupsxampppath%\mysql\data\7dtd"
mkdir "%prebackupsxampppath%\mysql\data\7dtdnews"
mkdir "%prebackupsxampppath%\mysql\data\xenforum7dtd"
mkdir "%prebackupsxampppath%\mysql\data\pydio"
mkdir "%prebackupsxampppath%\phpMyAdmin"
mkdir "%prebackupsxampppath2%\"
del /F /Q "G:\_Servers\Xampp.7z"
@timeout 1
del /F /S /Q "%prebackupsxampppath%\*.7z"
@timeout 1
del /F /S /Q "%prebackupsxampppath2%\*.7z"
@timeout 1
copy /Y "D:\xampp\xampp-control.ini" "%prebackupsxampppath%\xampp-control.ini"
copy /Y "D:\xampp\mysql\bin\my.ini" "%prebackupsxampppath%\mysql\bin\my.ini"
copy /Y "D:\xampp\mysql\my-default.ini" "%prebackupsxampppath%\mysql\my-default.ini"
copy /Y "D:\xampp\php\php.ini" "%prebackupsxampppath%\php\php.ini"
copy /Y "D:\xampp\php\php.ini-development" "%prebackupsxampppath%\php\php.ini-development"
copy /Y "D:\xampp\php\php.ini-production" "%prebackupsxampppath%\php\php.ini-production"
copy /Y "D:\xampp\phpMyAdmin\config.inc.php" "%prebackupsxampppath%\phpMyAdmin\config.inc.php"
copy /Y "D:\xampp\phpMyAdmin\config.sample.inc.php" "%prebackupsxampppath%\phpMyAdmin\config.sample.inc.php"
ROBOCOPY "D:\xampp\apache\conf" /E /Z /R:3 /W:2 "%prebackupsxampppath%\apache\conf"
ROBOCOPY "D:\xampp\mysql\data\7dtd" /E /Z /R:3 /W:2 "%prebackupsxampppath%\mysql\data\7dtd"
ROBOCOPY "D:\xampp\mysql\data\7dtdnews" /E /Z /R:3 /W:2 "%prebackupsxampppath%\mysql\data\7dtdnews"
ROBOCOPY "D:\xampp\mysql\data\xenforum7dtd" /E /Z /R:3 /W:2 "%prebackupsxampppath%\mysql\data\xenforum7dtd"
ROBOCOPY "D:\xampp\mysql\data\pydio" /E /Z /R:3 /W:2 "%prebackupsxampppath%\mysql\data\pydio"
cd /d "C:\_BackupRestore\7za"
:BackUpXampp
@timeout 1
tasklist /FI "ImageName EQ %appbackup%" | Find /I "%appbackup%"
if errorlevel 1 (
	echo %appbackup% is not running
	Start /B 7za.exe a -ssw -mx9 "%prebackupsxampppath2%\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_Xampp.7z" "%prebackupsxampppath%\"
	@timeout 3
	goto Watch
) else (
	echo %appbackup% is running
	goto BackUpXampp
)
:Watch
set appbackup=7za.exe
tasklist /FI "ImageName EQ %appbackup%" | Find /I "%appbackup%"
if errorlevel 1 (
	echo %appbackup% is not running
	goto BackUpXampp2
) else (
	echo %appbackup% is running
	goto Watch
)
:BackUpXampp2
set appbackup=7za.exe
cd /d "C:\_BackupRestore\7za"
tasklist /FI "ImageName EQ %appbackup%" | Find /I "%appbackup%"
if errorlevel 1 (
	echo %appbackup% is not running
	Start /B 7za.exe a -ssw -mx9 "%prebackupsxampppath2%\Xampp.7z" "%prebackupsxampppath%\"
	@timeout 3
	goto BackUpXampp3
) else (
	echo %appbackup% is running
	goto Watch
)
:BackUpXampp3
set appbackup=7za.exe
tasklist /FI "ImageName EQ %appbackup%" | Find /I "%appbackup%"
if errorlevel 1 (
	echo %appbackup% is not running
	@timeout 1
	ROBOCOPY "%prebackupsxampppath2%" /E /Z /R:3 /W:2 "G:\_Servers"
	@timeout 3
	del /F /S /Q "%prebackupsxampppath2%\*.7z"
	@timeout 3
	goto killCMD
) else (
	echo %appbackup% is running
	goto BackUpXampp3
)
:killCMD
REM wait
@rem @timeout 5
REM Start /B /HIGH cmd /c taskkill /F /IM conhost.exe
REM Start /B /HIGH cmd /c taskkill /F /IM cmd.exe
@rem exit
