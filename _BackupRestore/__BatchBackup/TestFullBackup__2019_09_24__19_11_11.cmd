:: Test Full Backup
rem F:\_BackupRestore\TestFullBackup.cmd
@echo on
Title "Test Full Backup"
rem MODE CON: COLS=120 LINES=55
rem MODE CON: COLS=220
setlocal enableextensions enabledelayedexpansion
:: chcp 1251 >nul
:: chcp 1252 >nul
:: chcp 866 >nul
::  Time
set digit1=%time:~0,1%
if "%digit1%"==" " (set digit1=0)
set TimeStamp=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%digit1%%TIME:~1,1%_%TIME:~3,2%_%TIME:~6,2%
::  bool
set isStep=0
set isAppRunning=2
::  int
set /A KB=1*1024
set /A MB=400*1048576
::  RoboCopy
set RCParams=/S /ZB /R:3 /W:2 /SL /MT:32 /XA:sh
set RC_ExcludeDirList[0]="Yandex" "Vivox" "IceDragon" "Logs" "Recent" "Report*" "Temporary*" "*Crash*" "*Temp*" "*History*" "*Log*" "Application*" "Microsoft" "Diagnostics" "Packages" "Comms" "NVIDIA*" "Programs" "Publishers" "TempCheckUpdate" "fontconfig" "{*}" "*Folder" "e2eSoft" "speech" "TechSmith" "*Tile*" "Wondershare" "VirtualStore" "ConnectedDevicesPlatform"
rem set RC_ExcludeDirList[1]="Yandex" "Vivox" "IceDragon" "Logs" "Recent" "Report*" "Temporary*" "*Crash*" "*Temp*" "*History*" "*Log*" "Application*" "Microsoft" "Diagnostics" "Packages" "Comms" "NVIDIA*" "Programs" "Publishers" "TempCheckUpdate" "fontconfig" "{*}" "*Folder" "e2eSoft" "speech" "TechSmith" "*Tile*" "Wondershare" "VirtualStore" "ConnectedDevicesPlatform"
rem set RC_ExcludeDirList[2]="Yandex" "Vivox" "IceDragon" "Logs" "Recent" "Report*" "Temporary*" "*Crash*" "*Temp*" "*History*" "*Log*" "Application*" "Microsoft" "Diagnostics" "Packages" "Comms" "NVIDIA*" "Programs" "Publishers" "TempCheckUpdate" "fontconfig" "{*}" "*Folder" "e2eSoft" "speech" "TechSmith" "*Tile*" "Wondershare" "VirtualStore" "ConnectedDevicesPlatform"
set RC_ExcludeRecurseFileList[0]="IconCache*" "thumbcache*" "*.cookie" "*.log" "*.tmp" "*.dmp" "*.vbs" "*.7z"
rem set RC_ExcludeRecurseFileList[1]="IconCache*" "thumbcache*" "*.cookie" "*.log" "*.tmp" "*.dmp" "*.vbs" "*.7z"
rem set RC_ExcludeRecurseFileList[2]="IconCache*" "thumbcache*" "*.cookie" "*.log" "*.tmp" "*.dmp" "*.vbs" "*.7z"
rem set RCYandexExcludeDirs="*Crash*" "*Temp*" "*Logs*" "*Report*" "BrowserMetrics" "Safe Browsing" "Safe Browsing Cookies" "CrashpadMetrics-active.pma" "*History*" "*Log*" "Application*" "Microsoft" "Diagnostics" "Packages" "Comms" "NVIDIA*" "Programs" "Publishers" "TempCheckUpdate" "fontconfig" "{*}" "*Folder" "e2eSoft" "speech" "TechSmith" "*Tile*" "Wondershare" "VirtualStore" "ConnectedDevicesPlatform"
rem set RCYandexExcludeFile="*.cookie" "*.log" "*.tmp" "*.dmp" "*.vbs"
set RCFileDataFlags=/COPYALL /DCOPY:DAT
::  7za
set 7zaKeyString=-ssw -m0=LZMA2:d128m:fb256 -myx9 -slp -mmt=32 -ms=off
set 7za=C:\_BackupRestore\7z\1900\x64\7za.exe
::  Папки
set UsersDir[0]=Users\Public
set Dir[0]=%userprofile%\AppData\Local
set Dir[1]=%userprofile%\AppData\LocalLow
set Dir[2]=%userprofile%\AppData\Roaming
set BackupsDir=F:\Archive\_BackUps
set TempSourceBackupDir=C:\_BR\Temp
set TempBackupDir=C:\_BR
set TempDirNBP=C:\_BR\_NotBatchPacking
set TempAppData[0]=%TempBackupDir%\Users\%USERNAME%\AppData\Local"
set TempAppData[1]=%TempBackupDir%\Users\%USERNAME%\AppData\LocalLow"
set TempAppData[2]=%TempBackupDir%\Users\%USERNAME%\AppData\Roaming"
set TempUsersDir[0]=%TempBackupDir%\%UsersDir[0]%"
set TempDir[0]=C:\_BR\Program Files
set TempDir[1]=C:\_BR\Program Files (x86)
set TempDir[2]=C:\_BR\ProgramData
rem set TempDir[3]=%windir%\SoftwareDistribution\Download
rem set TempDir[4]=%userprofile%\AppData\Local\Packages
set LogsDir=C:\_BackupRestore\__Logs
set ListDir=C:\_BackupRestore\__Lists
:: F:\Archive\_BackUps
::  Files
set FileN[0]=Local
set FileN[1]=LocalLow
set FileN[2]=Roaming
set FileN[3]=Public
set FileName=TestFullBackup
set LogFile=%LogsDir%\%TimeStamp%_%FileName%.log
set RCLogFile=%LogsDir%\!TimeStamp!_%FileName%.txt
rem set ListLocalInclude=%ListDir%\7z_IncludeLocal.txt
set 7z_ExcludeList[0]=%ListDir%\7z_ExcludeLocal.txt
set 7z_ExcludeList[1]=%ListDir%\7z_ExcludeLocalLow.txt
set 7z_ExcludeList[2]=%ListDir%\7z_ExcludeRoaming.txt
set 7z_ExcludeRecurseList[0]=%ListDir%\7z_R_ExcludeLocal.txt
set 7z_ExcludeRecurseList[1]=%ListDir%\7z_R_ExcludeLocalLow.txt
set 7z_ExcludeRecurseList[2]=%ListDir%\7z_R_ExcludeRoaming.txt
set List_Exclude[0]=%ListDir%\ExcludeLocal.txt
set List_Exclude[1]=%ListDir%\ExcludeLocalLow.txt
set List_Exclude[2]=%ListDir%\ExcludeRoaming.txt
:: 
::  Self Backup
copy /v /y %0 %~dp0__BatchBackup\%~n0__%TimeStamp%%~x0
:: 
call :NotBatchAppDataPacking
@timeout /t 360 >nul

if %isStep% == 0 (goto :ReCreate)
:: 
rem cd /D !Dir[%isStep%]!\
:: !isStep!
echo - !Dir[%isStep%]!
echo - !Dir[0]!
echo - %Dir[0]%
rem FINDSTR /L /I /G:Label 12345
rem if not %isStep% == 99 (echo %isStep%)
:: 
rem set isStep=1
rem !TempAppData[%isStep%]!

echo [92m " =================================== End init =================================== " [0m 
:: 
:cleaning
::  DIRECTORIES FOR CLEANING
cd /D !Dir[0]!\
@timeout /t 1 >nul
rem del /F /Q "%temp%\*.*"
cd /D !TempAppData[%isStep%]!\
@timeout /t 1 >nul
::	 команда rd удаляет только пустые папки (папки с файлами и файлы не трогает), если ее использовать без ключа /s
for /f "usebackq delims=" %%A in (`dir /a:d /s /b *`) do ( If %%~zA LSS 1 if exist "%%~nxA" rd /q "%%~nxA" )
::  
::  FILES FOR CLEANING
del /F /S /Q *.tmp
del /F /S /Q *.log
del /F /S /Q *.dmp
for /f "usebackq delims=;" %%A in (`dir /s /b *.*`) do ( If %%~zA LSS 1 del /f /s /q "%%A" )
for /f "usebackq delims=;" %%A in (`dir /a:h-s /s /b *.*`) do ( If %%~zA LSS 1 del /f /s /q /a:h-s "%%A" )
rem for /f "usebackq delims=;" %%A in (`dir /a:hs /s /b *.*`) do ( If %%~zA LSS 1 del /f /s /q /a:hs "%%A" )
:: 
:ReCreate
echo [92m " Step = %isStep% (ReCreate) " [0m
::  CОЗДАНИЕ ВРЕМЕННОГО КАТАЛОГА ДЛЯ БЕКАПА
if not exist "%TempSourceBackupDir%" mkdir "%TempSourceBackupDir%"
if not exist "%TempBackupDir%\Users\%USERNAME%\AppData\Local" mkdir "%TempBackupDir%\Users\%USERNAME%\AppData\Local"
if not exist "%TempBackupDir%\Users\%USERNAME%\AppData\LocalLow" mkdir "%TempBackupDir%\Users\%USERNAME%\AppData\LocalLow"
if not exist "%TempBackupDir%\Users\%USERNAME%\AppData\Roaming" mkdir "%TempBackupDir%\Users\%USERNAME%\AppData\Roaming"
if not exist "%TempBackupDir%\Users\Public" mkdir "%TempBackupDir%\Users\Public"
if not exist "%TempDir[0]%" mkdir "%TempDir[0]%"
if not exist "%TempDir[1]%" mkdir "%TempDir[1]%"
if not exist "%TempDir[2]%" mkdir "%TempDir[2]%"
rem if not exist "%TempDir[3]%" mkdir "%TempDir[3]%"
rem if not exist "%TempDir[4]%" mkdir "%TempDir[4]%"
if not exist "%TempDirNBP%" mkdir "%TempDirNBP%"
@timeout /t 1 >nul
if exist !Dir[%isStep%]!\GetDirSize.vbs (
	goto :Pack
) else (
	goto :CreateVBSScripts
)
:: 
:CreateVBSScripts
echo [92m " =================================== CREATE SCRIPT OBJECT =================================== " [0m 
if exist !Dir[%isStep%]!\GetDirSize.vbs ( Del /F /Q !Dir[%isStep%]!\GetDirSize.vbs 1>nul 2>&1 )
if exist %TempSourceBackupDir%\GetDirSize.vbs ( Del /F /Q %TempSourceBackupDir%\GetDirSize.vbs 1>nul 2>&1 )
@timeout /t 1 >nul
cd /D !Dir[%isStep%]!\
Echo WScript.Echo CreateObject("Scripting.FileSystemObject").GetFolder(WScript.Arguments(0)).Size>GetDirSize.vbs
@timeout /t 1 >nul
cd /D %TempSourceBackupDir%\
Echo WScript.Echo CreateObject("Scripting.FileSystemObject").GetFolder(WScript.Arguments(0)).Size>GetDirSize.vbs
@timeout /t 2 >nul
:: 
:Pack
echo [92m " =================================== CREATE MKLINK`S =================================== " [0m 
echo [92m " Step = %isStep% " [0m 
cd /D %TempSourceBackupDir%\
for /d %%A In ("!Dir[%isStep%]!\*") Do (
	if not exist "%%~nxA" MKLINK /d /h /j "%%~nxA" "%%A"
)
echo [92m " =================================== Exclude MKLINK`S =================================== " [0m 
@timeout /t 2 >nul
for /f "delims=|" %%L in (!List_Exclude[%isStep%]!) Do (
	for /f "usebackq delims=" %%i in (`dir /a:d /b "%TempSourceBackupDir%\%%L"`) Do (
		if exist "%TempSourceBackupDir%\%%i" rmdir /q "%TempSourceBackupDir%\%%~nxi"
	)
)
@timeout /t 3 >nul
:: 
if not exist "%TempBackupDir%\!FileN[%isStep%]!.7z" ( call :NotBatchAppDataPacking )
:: 
echo [92m " =================================== ROBOCOPY =================================== " [0m 
ROBOCOPY "%TempSourceBackupDir%" "!TempAppData[%isStep%]!" %RCParams% /LOG:"!RCLogFile!" /XF !RC_ExcludeRecurseFileList[%isStep%]! /XD !RC_ExcludeDirList[%isStep%]! %RCFileDataFlags%


:: 
echo [92m " =================================== Pack Step =================================== " [0m 
if not %isStep% == 1 (
	For /D %%A In ("!TempAppData[%isStep%]!\*") Do (
		!7za! u -y -r !7zaKeyString! "!TempBackupDir!\%%~nxA.7z" "%%A" -x@"!7z_ExcludeList[%isStep%]!" -xr@"!7z_ExcludeRecurseList[%isStep%]!"
	)
)
:: 
goto :Switch
rem goto :NotBatchAppDataPacking
:: 
:Switch
@timeout /t 2 >nul
if not exist "%TempBackupDir%\Local.7z" if %isStep% == 0 (set isStep=1)
if not exist "%TempBackupDir%\LocalLow.7z" if %isStep% == 1 (set isStep=2)
if not exist "%TempBackupDir%\Roaming.7z" if %isStep% == 2 (set isStep=3)
rem if exist "%TempBackupDir%\Roaming.7z" if %isStep% == 2 (set isStep=3)
if not %isStep% == 99 (goto :cleaning)
:: 
:NotBatchAppDataPacking
@timeout /t 2 >nul
rem /O - Копирует сведения о владельце и данные ACL.
rem /X - Копирует параметры аудита файлов (требуется параметр /O).
rem /E - Копирует каталоги с подкаталогами, включая пустые. Эквивалент сочетания параметров /S /E. Совместим с параметром /T.
rem /K - Копирует атрибуты. При использовании команды XСOPY обычно сбрасываются атрибуты "только для чтения".
rem /Z - Копирует сетевые файлы с возобновлением.
rem /Y - Подавляет запрос на подтверждение перезаписи существующего конечного файла.
rem /R - Разрешает замену файлов, предназначенных только для чтения.
rem /S - Копирует только непустые каталоги с подкаталогами.
rem /T - Создает структуру каталогов (кроме пустых каталогов) без копирования файлов. Для создания пустых каталогов и подкаталогов
rem /U - Копирует только файлы, уже имеющиеся в конечной папке.
:: %TempDirNBP%"
:: %TempDirNBP%\%FileN[3]%
::  AppData\Local
xcopy %Dir[0]%\NVIDIA\accounts. %TempDirNBP%\%FileN[0]%\NVIDIA\ /R /Y /O /X
!7za! u -y -r !7zaKeyString! "%TempDirNBP%\%FileN[0]%\Microsoft\Credentials.7z" "%Dir[0]%\Microsoft\Credentials" -w"%Temp%"
!7za! u -y -r !7zaKeyString! "%TempDirNBP%\%FileN[2]%\Microsoft\Credentials.7z" "%Dir[2]%\Microsoft\Credentials" -w"%Temp%"
!7za! u -y -r !7zaKeyString! "%TempDirNBP%\%FileN[2]%\Microsoft\Crypto.7z" "%Dir[2]%\Microsoft\Crypto" -w"%Temp%"
cd /D %Dir[0]%\Microsoft\
@timeout /t 1 >nul
set TStamp=!TimeStamp!
set RCLogFile=%LogsDir%\!TStamp!_%FileName%.txt
set RCLogFile=!RCLogFile!
ROBOCOPY "OneDrive\settings" "%TempDirNBP%\%FileN[0]%\Microsoft\OneDrive\settings" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
rem ROBOCOPY "Credentials" "%TempDirNBP%\%FileN[0]%\Microsoft\Credentials" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
cd /D %Dir[0]%\Microsoft\Windows\
@timeout /t 1 >nul
set TStamp=!TimeStamp!
set RCLogFile=!RCLogFile!
ROBOCOPY "Themes" "%TempDirNBP%\%FileN[0]%\Microsoft\Windows\Themes" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "BackgroundSlideshow" "%TempDirNBP%\%FileN[0]%\Microsoft\Windows\BackgroundSlideshow" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
::  AppData\LocalLow
ROBOCOPY "%Dir[1]%" "%TempDirNBP%\%FileN[1]%" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
::  AppData\Roaming
cd /D %Dir[2]%\Microsoft\
@timeout /t 1 >nul
rem ROBOCOPY "Credentials" "%TempDirNBP%\%FileN[2]%\Microsoft\Credentials" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
rem ROBOCOPY "Crypto" "%TempDirNBP%\%FileN[2]%\Microsoft\Crypto" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "VisualStudio" "%TempDirNBP%\%FileN[2]%\Microsoft\VisualStudio" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "Skype for Desktop" "%TempDirNBP%\%FileN[2]%\Microsoft\Skype for Desktop" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
cd /D %Dir[2]%\Microsoft\Windows\
@timeout /t 1 >nul
ROBOCOPY "AccountPictures" "%TempDirNBP%\%FileN[2]%\Microsoft\Windows\AccountPictures" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "Themes" "%TempDirNBP%\%FileN[2]%\Microsoft\Windows\Themes" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "SendTo" "%TempDirNBP%\%FileN[2]%\Microsoft\Windows\SendTo" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "PowerShell" "%TempDirNBP%\%FileN[2]%\Microsoft\Windows\PowerShell" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "Libraries" "%TempDirNBP%\%FileN[2]%\Microsoft\Windows\Libraries" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "Network Shortcuts" "%TempDirNBP%\%FileN[2]%\Microsoft\Windows\Network Shortcuts" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
::  Users\Public
cd /D C:\%UsersDir[0]%\
@timeout /t 1 >nul
ROBOCOPY "Desktop" "%TempDirNBP%\%FileN[3]%\Desktop" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "Foxit Software" "%TempDirNBP%\%FileN[3]%\Foxit Software" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "Documents\Unity Projects" "%TempDirNBP%\%FileN[3]%\\Documents\Unity Projects" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
::  Users\UserProfile
cd /D %userprofile%\
@timeout /t 1 >nul
ROBOCOPY ".android" "%userprofile%\.android" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY ".AndroidStudio3.1" "%userprofile%\.AndroidStudio3.1" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY ".BigNox" "%userprofile%\.BigNox" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY ".fontconfig" "%userprofile%\.fontconfig" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY ".swt" "%userprofile%\.swt" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY ".thumbnails" "%userprofile%\.thumbnails" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "AndroidStudioProjects" "%userprofile%\AndroidStudioProjects" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "NCH Software Suite" "%userprofile%\NCH Software Suite" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "Nox_share" "%userprofile%\Nox_share" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "OneDrive" "%userprofile%\OneDrive" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
:: 
echo [92m " =================================== Pause =================================== " [0m 
@timeout /t 360 >nul
if not %isStep% == 1 (
	!7za! u -y -r !7zaKeyString! "%TempBackupDir%\!FileN[%isStep%]!.7z" "!TempAppData[%isStep%]!\*" -w"%Temp%"
) else (
	!7za! u -y -r !7zaKeyString! "%TempBackupDir%\!FileN[%isStep%]!.7z" "!Dir[%isStep%]!\*" -w"%Temp%"
)
:: 


rem Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\_LastDesktopBackup.7z" "%userprofile%\Desktop\"
rem Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_DesktopBackup.7z" "%userprofile%\Desktop\"


:: if %isStep% == 0 (
:: 	goto :Switch
:: )
:: if %isStep% == 1 (
:: 


:: )
:: if %isStep% == 2 (
:: )@timeout /t 2 >nul
if %isStep% == 2 (goto :End)
goto :NotBatchAppDataPacking

:COPYFILES2
:: Копирование архивов Бекапа.
rem ROBOCOPY "C:\_BR\_backups" /S /ZB /R:3 /W:2 /SL /MT:32 /LOG:"%RoboCopyLogFile%" /COPYALL /DCOPY:DAT /TBD "%BackUpStoreDir%\AppData" /XF "IconCache*" /XD "Report*" "Temporary*" "*Cache*"
rem @timeout 3

rem > позже перенести в отдельную метку, индивидуального копирования Local (также при необходимости и LocalLow b Roaming )
:: Если с исключениями:
rem !7za! u -y -r !7zaKeyString! "%TempBackupDir%\!FileN[%isStep%]!.7z" "%TempAppData[0]%\*" -w"%Temp%" -x@"!7z_ExcludeList[%isStep%]!" -xr@"!7z_ExcludeRecurseList[%isStep%]!"
rem <

rem start /b /wait 
::
rem if %isStep% == 1 (goto :ReCreate)

rem pause
rem @timeout /t 3 >nul
rem if %isStep% == 1 (goto :StepGTRPack)
:: 

:StepGTRPack
echo [92m " ===================================== Pack Step-2 ===================================== " [0m 
echo [92m " Step = %isStep% " [0m 
@timeout /t 2 >nul
For /D %%A In ("%TempBackupLocalLowDir%\*") Do (
	!7za! u -y -r !7zaKeyString! "!TempBackupDir!\%%~nxA.7z" "%%A" -x@"!7z_ExcludeList[%isStep%]!" -xr@"!7z_ExcludeRecurseList[%isStep%]!"
)
	rem For /F "delims=" %%B In ('CScript //Nologo %TempBackupLocalLowDir%\GetDirSize.vbs "%%A"') Do (
	rem		if %%B geq !MB! 
	rem )

pause

rem '-xr!*.tmp' '-xr!*.dmp' '-xr!*.cookie' '-xr!*.log' '-xr!*.vbs' '-xr!*.7z'
:: 
:End
echo [92m " ========================================== End ========================================== " [0m
@timeout /t 2 >nul
Del /F /Q !Dir[0]!\GetDirSize.vbs 1>nul 2>&1
Del /F /Q !Dir[1]!\GetDirSize.vbs 1>nul 2>&1
Del /F /Q !Dir[2]!\GetDirSize.vbs 1>nul 2>&1
Del /F /Q %TempSourceBackupDir%\GetDirSize.vbs 1>nul 2>&1
:: del /F /S /Q "%TempSourceBackupDir%\*"
if exist "%TempSourceBackupDir%" rmdir /S /Q "%TempSourceBackupDir%"
if exist "%TempAppData[0]%" rmdir /S /Q "%TempAppData[0]%\"
if exist "%TempAppData[1]%" rmdir /S /Q "%TempAppData[1]%\"
if exist "%TempAppData[2]%" rmdir /S /Q "%TempAppData[2]%\"
if exist "%TempUsersDir[0]%" rmdir /S /Q "%TempUsersDir[0]%\"
if exist "%TempDir[0]%" rmdir /S /Q "%TempDir[0]%\"
if exist "%TempDir[1]%" rmdir /S /Q "%TempDir[1]%\"
if exist "%TempDir[2]%" rmdir /S /Q "%TempDir[2]%\"
rem if exist "%TempDir[3]%" rmdir /S /Q "%TempDir[3]%\"
rem if exist "%TempDir[4]%" rmdir /S /Q "%TempDir[4]%\"
if exist "%TempDirNBP%" rmdir /S /Q "%TempDirNBP%\"


endlocal
:: @timeout /t 2 >nul
:: exit

:: !7za! u -y -r !7zaKeyString! "%TempBackupDir%\Local.7z" "%TempBackupLocalDir%\*" -w"%Temp%" -x@"!ListLocalExclude!" -xr@"!ListRecurseExclude!"
::

:: Extension Rules
:: Extension State
:: Extensions
:: Local Extension Settings
:: Managed Extension Settings
:: Sync Data
:: Sync Extension Settings
:: Web Applications


:: Bookmarks.
:: Cookies.
:: Current Session.
:: Current Tabs.
:: Extension Cookies.
:: History.
:: Last Session.
:: Last Tabs.
:: Preferences.
:: Secure Preferences.
:: Tablo.
:: Top Sites.
:: Visited Links.
:: Web Data.
:: Ya Credit Cards.
:: Ya Login Data.

:: \UserData\
:: configs\
:: HibernateSnapshots\
:: RescueTool\
:: RescueToolReport\
:: Resources\
:: ui_config\
:: YandexDictionaries\
:: YandexOfflineSpellchecker\
:: First Run.
:: Last Version.

rem xcopy %Dir[0]%\Microsoft\Windows\Themes\ %TempDirNBP%\%FileN[0]%\Microsoft\Windows\Themes\ /R /Y /O /X
rem xcopy %Dir[0]%\Microsoft\Windows\BackgroundSlideshow\ %TempDirNBP%\%FileN[0]%\Microsoft\Windows\BackgroundSlideshow\ /R /Y /O /X
rem xcopy %Dir[0]%\Microsoft\OneDrive\settings\ %TempDirNBP%\%FileN[0]%\Microsoft\OneDrive\settings\ /R /Y /O /X
rem xcopy %Dir[0]%\Microsoft\Credentials\ %TempDirNBP%\%FileN[0]%\Microsoft\Credentials\ /R /Y /O /X
:: 
rem xcopy %Dir[2]%\Microsoft\Credentials\ %TempDirNBP%\%FileN[2]%\Microsoft\Credentials\ /R /Y /O /X
rem xcopy %Dir[2]%\Microsoft\Crypto\ %TempDirNBP%\%FileN[2]%\Microsoft\Crypto\ /R /Y /O /X
rem xcopy %Dir[2]%\Microsoft\VisualStudio\ %TempDirNBP%\%FileN[2]%\Microsoft\VisualStudio\ /R /Y /O /X
rem xcopy "%Dir[2]%\Microsoft\Skype for Desktop\" "%TempDirNBP%\%FileN[2]%\Microsoft\Skype for Desktop\" /R /Y /O /X
rem xcopy %Dir[2]%\Microsoft\Windows\AccountPictures\ %TempDirNBP%\%FileN[2]%\Microsoft\Windows\AccountPictures\ /R /Y /O /X
rem xcopy %Dir[2]%\Microsoft\Windows\Themes\ %TempDirNBP%\%FileN[2]%\Microsoft\Windows\Themes\ /R /Y /O /X
rem xcopy %Dir[2]%\Microsoft\Windows\SendTo\ %TempDirNBP%\%FileN[2]%\Microsoft\Windows\SendTo\ /R /Y /O /X
rem xcopy %Dir[2]%\Microsoft\Windows\PowerShell\ %TempDirNBP%\%FileN[2]%\Microsoft\Windows\PowerShell\ /R /Y /O /X
rem xcopy %Dir[2]%\Microsoft\Windows\Libraries\ %TempDirNBP%\%FileN[2]%\Microsoft\Windows\Libraries\ /R /Y /O /X
rem xcopy "%Dir[2]%\Microsoft\Windows\Network Shortcuts\" "%TempDirNBP%\%FileN[2]%\Microsoft\Windows\Network Shortcuts\" /R /Y /O /X


:: C:\Users\Public\Desktop
:: C:\Users\Public\Foxit Software
:: C:\Users\Public\Documents\Unity Projects
:: 
:: C:\Users\New\.android
:: C:\Users\New\.AndroidStudio3.1
:: C:\Users\New\.BigNox
:: C:\Users\New\.fontconfig
:: C:\Users\New\.swt
:: C:\Users\New\.thumbnails
:: C:\Users\New\AndroidStudioProjects
:: C:\Users\New\NCH Software Suite
:: C:\Users\New\Nox_share
:: C:\Users\New\OneDrive

rem F:\_BackupRestore\7z\1900\x64\7za.exe a -ssw "%TempBackupDir%\2.7z" "%TempSourceBackupDir%\*" -r0 -w"%TempBackupDir%" -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%" -bsp2 -slp -scsWIN -mmt=on -mx9 -ms=off

::	if errorlevel 255 echo Операция была прервана пользователем.
::	if errorlevel 16 echo ***FATAL ERROR*** & goto end
::	if errorlevel 15 echo OKCOPY + FAIL + MISMATCHES + XTRA & goto end
::	if errorlevel 14 echo FAIL + MISMATCHES + XTRA & goto end
::	if errorlevel 13 echo OKCOPY + FAIL + MISMATCHES & goto end
::	if errorlevel 12 echo FAIL + MISMATCHES& goto end
::	if errorlevel 11 echo OKCOPY + FAIL + XTRA & goto end
::	if errorlevel 10 echo Нет файлов, удовлетворяющих указанной маске, и параметров.
::	if errorlevel 9 echo Ошибка при создании файла.
::	if errorlevel 8 echo Недостаточно памяти для выполнения операции.
::	if errorlevel 7 echo Ошибка при указании параметра в командной строке.
::	if errorlevel 6 echo Произошла ошибка открытия файла.
::	if errorlevel 5 echo Произошла ошибка записи на диск. Access is denied
::	if errorlevel 4 echo Предпринята попытка изменить заблокированный архив.
::	if errorlevel 3 echo Неверная контрольная сумма CRC32. Данные повреждены.
::	if errorlevel 2 echo Произошла критическая ошибка.
::	if errorlevel 1 echo Предупреждение. Произошли некритические ошибки.
::	if errorlevel 0 echo Операция успешно завершена

REM start /b /wait F:\_BackupRestore\7za\7za.exe a -t7z -ssw -mx9 "%TempBackupDir%\2.7z" "%TempBackupDir%\*" -r0 -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%"
rem F:\_BackupRestore\7za\
rem F:\_BackupRestore\7z\1604\x64\
rem F:\_BackupRestore\7z\1805\x64\
rem F:\_BackupRestore\7z\1900\x64\
rem ROBOCOPY "%TempSourceBackupDir%" "%TempBackupDir%" /S /ZB /R:3 /W:2 /SL /MT:32 /LOG:"%RoboCopyLogFile%" /XF "IconCache*" "*Cache*" "*.cookie" "*.LOG*" "*.tmp" /XD "Recent" "Report*" "Temporary*" "Caches" "*Cache*" "Temp" "*History*" /COPYALL /DCOPY:DAT /TBD
rem start /b /wait F:\_BackupRestore\7za\7za.exe a -t7z -ssw -mx9 "%TempBackupDir%\2.7z" "%TempSourceBackupDir%\*" -r0 -w"%TempBackupDir%" -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%"
rem start /REALTIME /wait F:\_BackupRestore\7z\1900\x64\7za.exe d -y "%TempBackupDir%\2.7z" -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%" -bsp2 -slp -scsWIN -mmt=4 -mx9 -ms=off



:: start /REALTIME /wait F:\_BackupRestore\7z\1900\x64\7za.exe a -ssw -y "%TempBackupDir%\2.7z" "%TempSourceBackupDir%\*" -r0 -w"%TempBackupDir%" -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%" -bsp2 -slp -scsWIN -mmt=on -mx9 -ms=off

:: For /D %%A In ("%Dir001%\*") Do (
:: 	For /F "delims=" %%B In ('CScript //Nologo GetDirSize.vbs "%%A"') Do (
:: 		Set Bytes=%%B
:: 		Set /A KB=50*1024
:: 		Set /A MB=6*1048576
:: 		Set /A FloatMB=!Bytes!%%1048576/10000
:: 		Set /A FloatKB=!Bytes!%%1024/10
:: 		if %%B geq !KB! if %%B leq !MB! F:\_BackupRestore\7z\1900\x64\7za.exe a "%BackupsDir%\%%~nxA.7z" "%%A" -r0 -w"%BackupsDir%" -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%" -bsp2 -ssw -slp -scsWIN -mmt=on -mx3 -ms=off
:: 	)
:: )

:: for /d %%A in (F:\MNM\*) do C:\arc\7za.exe a -t7z -mx=0 -r -mhe -pPASS -- "C:\MNM2\%%~nxA.7z" "%%A"
:: 
:: Set /A IntMB=!Bytes!/1048576
:: Set /A IntKB=!Bytes!/1024
:: Set /A FloatMB=!Bytes!%%1048576/10000
:: Set /A FloatKB=!Bytes!%%1024/10


:: for /d %%A in ('Dir "%Dir001%\*" /-C/S/A:D') do ( if %%~zA leq 50000 Echo Size of %%A is %%~zA Bytes. )

:: for /d %%A in ('Dir "%Dir001%\*" /-C/S/A:-D') do  if %%~zA geq 1 if %%~zA leq 50000 C:\_BackupRestore\7za\7za.exe a -t7z -ssw -mx=9 -x@%ListLocalExclude% "%BackupsDir%\%%~nxA.7z" "%%A"

