@rem Full Backup
@rem C:\_BackupRestore\_Backup_Full.cmd
@if "%DM%" == "" @echo off
@Title "Test Full Backup"
@rem MODE CON: COLS=120 LINES=55
@rem MODE CON: COLS=220
setlocal enableextensions
setlocal enabledelayedexpansion
@rem chcp 1251 >nul
@rem 
chcp 1252 >nul
@rem chcp 866 >nul
@rem  Time
set digit1=%time:~0,1%
if "%digit1%"==" " (set digit1=0)
set StartTimeStamp=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%digit1%%TIME:~1,1%_%TIME:~3,2%_%TIME:~6,2%
set TimeStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@rem  bool
set isStep=0
@rem  int
@rem set /A KB=1*1024
@rem set /A MB=400*1048576
@rem  RoboCopy
@rem set RCParams=/S /ZB /R:3 /W:2 /SL /MT:8 /XA:sh
@rem set RCParams2=/S /ZB /R:3 /W:2 /SL /MT:8
@rem set RC_ExcludeDirList[1]="Yandex" "Vivox" "IceDragon" "Logs" "Recent" "Report*" "Temporary*" "*Crash*" "*Temp*" "*History*" "*Log*" "Application*" "Microsoft" "Diagnostics" "Packages" "Comms" "NVIDIA*" "Programs" "Publishers" "TempCheckUpdate" "fontconfig" "{*}" "*Folder" "e2eSoft" "speech" "TechSmith" "*Tile*" "Wondershare" "VirtualStore" "ConnectedDevicesPlatform"
@rem set RC_ExcludeDirList[2]="Flash Player" "AMS Software" "Anvsoft" "Macromedia" "Microsoft" "tor" "Recent" "Report*" "Temporary*" "*Crash*" "*Temp*" "*History*" "*Log*" "Programs" "Publishers" "{*}" "*Folder" "speech" "TechSmith" "NVIDIA*"
@rem set RC_ExcludeRecurseFileList[1]="IconCache*" "thumbcache*" "*.cookie" "*.log" "*.tmp" "*.dmp" "*.vbs" "*.7z"
@rem set RC_ExcludePF="Common Files" "internet explorer" "MSBuild" "NVIDIA*" "Reference Assemblies" "rempl" "TechSmith" "UmmyVideoDownloader" "Uninstall Information" "Unity*" "UNP" "VK" "Windows*" "WindowsPowerShell" "Yandex"
@rem set RC_ExcludePFx86="Bandicam" "BandiMPEG1" "Common Files" "e2eSoft" "Google\CrashReports" "Intel" "Internet Explorer" "InstallShield Installation Information" "Microsoft" "Microsoft SDKs" "Microsoft Visual Studio" "Microsoft Web Tools" "Microsoft.NET" "MSBuild" "MSI Afterburner" "NVIDIA*" "Reference Assemblies" "RivaTuner Statistics Server" "Uninstall Information" "VulkanRT" "Windows*" "WindowsPowerShell" "Yandex"
@rem set RCFileDataFlags=/COPYALL /DCOPY:DAT

@rem  7za
set 7zaKeyString=-ssw -m0=LZMA2:d128m:fb256 -myx9 -mmt=8 -ms=off
set 7zaKeyString2=-ssw -mmt=8 -ms=off
set 7zaKeyString3=-ssw -mmt=8
set 7za=%~dp0\7z\1900\x64\7za.exe
@rem  Папки
set UsersDir[0]=Users\Public
set Dir[0]=%userprofile%\AppData\LocalLow
set Dir[1]=%userprofile%\AppData\Local
set Dir[2]=%userprofile%\AppData\Roaming
set Dir[3]=C:\Users\Public
set Dir[4]=%ProgramFiles%
set Dir[5]=C:\Program Files (x86)
set Dir[6]=C:\ProgramData

set BackupsDir=F:\Archive\_BackUps
set TempBackupDir=C:\_BR

set TempOutputDir[0]=%TempBackupDir%\Users\%USERNAME%\AppData\LocalLow
set TempOutputDir[1]=%TempBackupDir%\Users\%USERNAME%\AppData\Local
set TempOutputDir[2]=%TempBackupDir%\Users\%USERNAME%\AppData\Roaming
set TempOutputDir[3]=%TempBackupDir%\%UsersDir[0]%
set TempOutputDir[4]=C:\_BR\Program Files
set TempOutputDir[5]=C:\_BR\Program Files (x86)
set TempOutputDir[6]=C:\_BR\ProgramData

@rem set TempDir[3]=%windir%\SoftwareDistribution\Download
@rem set TempDir[4]=%userprofile%\AppData\Local\Packages

set LogsDir=%~dp0\__Logs
set ListDir=%~dp0\__Lists
rem F:\Archive\_BackUps
rem  Files
set FileN[0]=LocalLow
set FileN[1]=Local
set FileN[2]=Roaming
set FileN[3]=Public
set FileN[4]=ProgramFiles
set FileN[5]=ProgramFiles_x86
set FileN[6]=ProgramData

set FileName=Backup_Full
set LogFile=%LogsDir%\%TimeStamp%_%FileName%.log
rem  File Lists
set 7z_List[0]=%ListDir%\7z_UserProfile.txt
set 7z_List[1]=%ListDir%\7z_Local.txt
set 7z_List[2]=%ListDir%\7z_Roaming.txt
set 7z_List[3]=%ListDir%\7z_Public.txt
set 7z_List[4]=%ListDir%\7z_ProgramFiles.txt
set 7z_List[5]=%ListDir%\7z_ProgramFiles_x86.txt
set 7z_List[6]=%ListDir%\7z_ProgramData.txt

set 7z_List2[1]=%ListDir%\7z_Local_2.txt
set 7z_List2[2]=%ListDir%\7z_Roaming_2.txt

set 7z_ListCommonFiles[4]=%ListDir%\7z_CommonFiles.txt
set 7z_ListCommonFiles[5]=%ListDir%\7z_CommonFiles_x86.txt

set 7z_ExcludeRecurseFiles[1]=%ListDir%\ExcludeRecurse\7z_R_ExcludeFiles.txt

echo [92m " =================================== End init =================================== " [0m 
echo !TimeStamp!>>%LogFile%

rem  Self Backup
copy /v /y %0 %~dp0__BatchBackup\%~n0__%TimeStamp%%~x0

if %isStep% == 0 ( cd /D !Dir[1]!\ )
@timeout /t 1 >nul
@rem del /F /Q "%temp%\*.*"
@rem =================================================================================================================================
@rem =================================================================================================================================
@rem =================================================================================================================================
:Sandbox
echo [92m " =================================== Sandbox =================================== " [0m 
@rem set isStep=1
@rem set DM=0
set CleanTemp=0
set isCLS=0
set tempStep=0
@rem if defined
if defined %DM% if %DM% == 1 (
	if %CleanTemp% == 5 (
		cd /D "!Dir[1]!\"
		del /F /S /Q *.tmp
		del /F /S /Q *.log
		del /F /S /Q *.dmp
		cd /D "!Dir[2]!\"
		del /F /S /Q *.tmp
		del /F /S /Q *.log
		del /F /S /Q *.dmp
	)
	if %CleanTemp% == 6 (
		cd /D "!Dir[1]!\"
		del /F /S /Q *.7z
		cd /D "!Dir[2]!\"
		del /F /S /Q *.7z
	)
	if %isStep% == 7 (
		echo !DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!>>%LogFile%
		goto :stop
	)
	@rem >> ===================================
	echo 1
	@rem << ===================================
	@rem set /a isStep=!isStep!+1
	@rem @timeout /t 3 >nul
	@rem 
	goto :Sandbox
)
@timeout /t 3 >nul
echo [92m " =================================== Sandbox Border =================================== " [0m 
if %DM% == 1 ( goto :stop )
@rem =================================================================================================================================
@rem =================================================================================================================================
@rem =================================================================================================================================

:ReCreate
echo [92m " =================================== ReCreate, Step = %isStep% =================================== " [0m 
rem  CОЗДАНИЕ ВРЕМЕННОГО КАТАЛОГА ДЛЯ БЕКАПА
@rem ==============================================================
@rem C:\_BR\_Deleted\						- %DeletedDir%
@rem ==============================================================
@rem C:\_BR\Program Files					- %TempOutputDir[4]%
@rem C:\_BR\Program Files (x86)				- %TempOutputDir[5]%
@rem C:\_BR\ProgramData						- %TempOutputDir[6]%
@rem ==============================================================
@rem 
if not exist "%TempBackupDir%\%TimeStamp%_%FileName%" mkdir "%TempBackupDir%\%TimeStamp%_%FileName%\"
if not exist "%TempOutputDir[0]%" mkdir "%TempOutputDir[0]%"
if not exist "%TempOutputDir[1]%" mkdir "%TempOutputDir[1]%"
if not exist "%TempOutputDir[2]%" mkdir "%TempOutputDir[2]%"
if not exist "%TempOutputDir[3]%" mkdir "%TempOutputDir[3]%"
if not exist "%TempOutputDir[4]%" mkdir "%TempOutputDir[4]%"
if not exist "%TempOutputDir[5]%" mkdir "%TempOutputDir[5]%"
if not exist "%TempOutputDir[6]%" mkdir "%TempOutputDir[6]%"
if not exist "%TempBackupDir%\Users\%USERNAME%\AppData\Local" mkdir "%TempBackupDir%\Users\%USERNAME%\AppData\Local"
if not exist "%TempBackupDir%\Users\%USERNAME%\AppData\LocalLow" mkdir "%TempBackupDir%\Users\%USERNAME%\AppData\LocalLow"
if not exist "%TempBackupDir%\Users\%USERNAME%\AppData\Roaming" mkdir "%TempBackupDir%\Users\%USERNAME%\AppData\Roaming"
@timeout /t 1 >nul

:Pack
echo [92m " =================================== Pack, Step = %isStep%  =================================== " [0m 
cd /D !Dir[%isStep%]!\
if %isStep% LEQ 6 (
	if not %isStep% == 0 (
		if %isStep% LEQ 2 (
			for /f "delims=|" %%L in (!7z_List[%isStep%]!) Do (
				if exist "!Dir[%isStep%]!\%%L" (
					!7za! u -r0 !7zaKeyString2! "!TempOutputDir[%isStep%]!\%%L.7z" "%%L" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[%isStep%]!"'
				)
			)
			!7za! u -r0 !7zaKeyString2! "!TempOutputDir[%isStep%]!\Microsoft\Credentials.7z" "!Dir[%isStep%]!\Microsoft\Credentials" '-xr@"!7z_ExcludeRecurseFiles!"'
			!7za! u -r0 !7zaKeyString2! "!TempOutputDir[2]!\Microsoft\Crypto.7z" "%Dir[2]%\Microsoft\Crypto" '-xr@"!7z_ExcludeRecurseFiles!"'
			!7za! u !7zaKeyString2! "!TempOutputDir[%isStep%]!\!FileN[%isStep%]!.7z" @"!7z_List2[%isStep%]!"
		)
		@rem Users\Public
		if %isStep% == 3 ( !7za! u !7zaKeyString2! "!TempOutputDir[%isStep%]!\!FileN[%isStep%]!.7z" -w"%Temp%" @"!7z_List[%isStep%]!" )
		@rem Program Files...
		if %isStep% GEQ 4 (
			@rem Common Files...
			if %isStep% LEQ 5 (
				!7za! u !7zaKeyString2! "!TempOutputDir[%isStep%]!\Common Files.7z" -w"%Temp%" @"!7z_ListCommonFiles[%isStep%]!"
			)
			if %isStep% == 5 (
				!7za! u !7zaKeyString2! "!TempOutputDir[5]!\SkypeForDesktop_x86.7z" "Microsoft\Skype for Desktop\" -w"%Temp%"
				!7za! u !7zaKeyString2! "!TempOutputDir[5]!\Steam.7z" -w"%Temp%" @"%ListDir%\7z_Steam.txt"
				!7za! u !7zaKeyString2! "!TempOutputDir[5]!\Google.7z" -w"%Temp%" @"%ListDir%\7z_Google_x86.txt"
				@rem !7za! u -y !7zaKeyString2! "!TempOutputDir[5]!\Microsoft Visual Studio.7z" "!Dir[%isStep%]!\Microsoft Visual Studio\" -w"%Temp%"
				@rem !7za! u -y !7zaKeyString2! "!TempOutputDir[5]!\Nox.7z" "!Dir[%isStep%]!\Nox\" -w"%Temp%"
			)
			if %isStep% LEQ 6 (
				for /f "delims=|" %%L in (!7z_List[%isStep%]!) Do (
					if exist "!Dir[%isStep%]!\%%L" (
						!7za! u !7zaKeyString2! "!TempOutputDir[%isStep%]!\%%L.7z" "%%L" -w"%Temp%"
					)
				)
			)
		)
	)
	else (
		if %isStep% == 0 (
			@rem LocalLow
			!7za! u -r0 !7zaKeyString2! "!TempOutputDir[%isStep%]!\!FileN[%isStep%]!.7z" "!Dir[%isStep%]!\*" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles!"'
			@rem USERNAME
			cd /D %userprofile%\
			!7za! u !7zaKeyString2! "%TempBackupDir%\Users\%USERNAME%\%USERNAME%.7z" -w"%Temp%" @"!7z_List[%isStep%]!"
		)
	)
)
@timeout /t 1 >nul

set /a isStep=!isStep!+1

if %isStep% GEQ 3 ( goto :DeleteFilesFromArchives )
if %isStep% LEQ 3 ( goto :Pack )
@REM if exist "!TempOutputDir[%isStep%]!\!FileN[%isStep%]!.7z" set /a isStep=!isStep!+1

@rem @timeout /t 360 >nul

:DeleteFilesFromArchives
echo [92m " =================================== Delete Files From Archives =================================== " [0m 
For /d %%A In ("%TempBackupDir%\Users\*") Do (
	for /f "usebackq delims=;" %%B in (`dir /a:a /s /b "%%A"`) do (
		!7za! d -y "%%B" desktop.ini *.tmp *.dmp *.cookie *.log -r
	)
)
if %isStep% LEQ 6 ( goto :Pack )

@rem exit /b
@rem @timeout /t 360 >

if %isStep% GEQ 7 ( goto :End )
 
:End
echo [92m " ========================================== End ========================================== " [0m 
@timeout /t 2 >nul
move /y "%TempBackupDir%\Users" "%TempBackupDir%\%TimeStamp%_%FileName%\"
move /y "%TempOutputDir[4]%" "%TempBackupDir%\%TimeStamp%_%FileName%\"
move /y "%TempOutputDir[5]%" "%TempBackupDir%\%TimeStamp%_%FileName%\"
move /y "%TempOutputDir[6]%" "%TempBackupDir%\%TimeStamp%_%FileName%\"
REM if exist "%TempOutputDir[0]%" rmdir /S /Q "%TempOutputDir[0]%\"
REM if exist "%TempOutputDir[1]%" rmdir /S /Q "%TempOutputDir[1]%\"
REM if exist "%TempOutputDir[2]%" rmdir /S /Q "%TempOutputDir[2]%\"
REM if exist "%TempOutputDir[3]%" rmdir /S /Q "%TempOutputDir[3]%\"
REM if exist "%TempOutputDir[4]%" rmdir /S /Q "%TempOutputDir[4]%\"
REM if exist "%TempOutputDir[5]%" rmdir /S /Q "%TempOutputDir[5]%\"
REM if exist "%TempOutputDir[6]%" rmdir /S /Q "%TempOutputDir[6]%\"
endlocal
@rem 
exit /b
@rem 
@timeout /t 2 >nul
@rem 
exit
@rem 
:stop
echo [92m " =================================== Stop =================================== " [0m 
@rem 
if %isCLS% == 1 ( cls )
exit /b
exit /b
@rem @timeout /t 360 >nul 
@rem > ==============================================================================================
@rem > ===================================         Yandex         ===================================
@rem > ==============================================================================================
@rem Extension Rules
@rem Extension State
@rem Extensions
@rem Local Extension Settings
@rem Managed Extension Settings
@rem Sync Data
@rem Sync Extension Settings
@rem Web Applications
@rem 
@rem 
@rem Bookmarks.
@rem Cookies.
@rem Current Session.
@rem Current Tabs.
@rem Extension Cookies.
@rem History.
@rem Last Session.
@rem Last Tabs.
@rem Preferences.
@rem Secure Preferences.
@rem Tablo.
@rem Top Sites.
@rem Visited Links.
@rem Web Data.
@rem Ya Credit Cards.
@rem Ya Login Data.
@rem 
@rem 
@rem \UserData\
@rem configs\
@rem HibernateSnapshots\
@rem RescueTool\
@rem RescueToolReport\
@rem Resources\
@rem ui_config\
@rem YandexDictionaries\
@rem YandexOfflineSpellchecker\
@rem First Run.
@rem Last Version.
@rem < ==============================================================================================

@rem > ==============================================================================================
@rem > =================================== NotBatchAppDataPacking ===================================
@rem > ==============================================================================================
@rem "AppData /Local"
@rem Microsoft\Windows\Themes\
@rem Microsoft\Windows\BackgroundSlideshow\
@rem Microsoft\OneDrive\settings\
@rem Microsoft\Credentials\
@rem 
@rem "AppData /Roaming"
@rem Microsoft\Credentials\
@rem Microsoft\Crypto\
@rem Microsoft\VisualStudio\
@rem Microsoft\Skype for Desktop\
@rem Microsoft\Windows\AccountPictures\
@rem Microsoft\Windows\Themes\
@rem Microsoft\Windows\SendTo\
@rem Microsoft\Windows\PowerShell\
@rem Microsoft\Windows\Libraries\
@rem Microsoft\Windows\Network Shortcuts\
@rem 
@rem "Public"
@rem C:\Users\Public\Desktop
@rem C:\Users\Public\Foxit Software
@rem C:\Users\Public\Documents\Unity Projects
@rem "User Profile"
@rem C:\Users\New\.android
@rem C:\Users\New\.AndroidStudio3.1
@rem C:\Users\New\.BigNox
@rem C:\Users\New\.fontconfig
@rem C:\Users\New\.swt
@rem C:\Users\New\.thumbnails
@rem C:\Users\New\AndroidStudioProjects
@rem C:\Users\New\NCH Software Suite
@rem C:\Users\New\Nox_share
@rem C:\Users\New\OneDrive
@rem < ==============================================================================================

@rem > ==============================================================================================
@rem > =================================== Roaming ===================================
@rem > ==============================================================================================
@rem   C:\Users\New\AppData\Roaming\Adobe\Flash Player\
@rem   C:\Users\New\AppData\Roaming\AMS Software
@rem   C:\Users\New\AppData\Roaming\Anvsoft
@rem   C:\Users\New\AppData\Roaming\Macromedia
@rem   C:\Users\New\AppData\Roaming\Microsoft\
@rem   C:\Users\New\AppData\Roaming\tor
@rem < ==============================================================================================

@rem > ==============================================================================================
@rem > =================================== Program Files ===================================
@rem > ==============================================================================================
REM 7-Zip
REM Android
REM Blender Foundation
REM Blizzard
REM Calibre2
REM Common Files\VMware\
REM DAEMON Tools Lite
REM GIMP 2
REM Google
REM KMPlayer
REM Lightworks
REM Mem Reduct
REM Mozilla Firefox
REM Nexus Mod Manager
REM Opera
REM paint.net
REM ShaderMap 3
REM ShaderMap 4
REM Shark007
REM simplewall
REM SoftMaker Office 2018
REM Unity
REM Unity Hub
REM Vuze

@rem > ==============================================================================================
@rem > =================================== C:\Program Files (x86) ===================================
@rem > ==============================================================================================
@rem 
@rem < ==============================================================================================


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
