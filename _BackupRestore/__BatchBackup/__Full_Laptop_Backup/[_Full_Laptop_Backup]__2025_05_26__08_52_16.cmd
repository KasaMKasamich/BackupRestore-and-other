@Rem [ Author: [ Бурлачков Василий Александрович) ] ]
@Title "Full Laptop Backup"
@if "%dm%" == "" echo off
@if "%dm%" NEQ "" echo on
echo -- %dm%
setlocal enableextensions
setlocal enabledelayedexpansion
@rem chcp 1251 >nul
@rem 
chcp 1252 >nul
@rem chcp 866 >nul
@rem Чтобы не редактировать скрипты в будущем, если путь до файлов изменится, ниже вычисление корневой папки скриптов.
@cd /D %~dp0
@cd /D ..\
@echo cd - %cd%
@set ScriptsRootPath=%cd%
@rem ================================================================================================================
@rem  Time
set digit1=%time:~0,1%
if "%digit1%"==" " (set digit1=0)
set StartTimeStamp=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%digit1%%TIME:~1,1%_%TIME:~3,2%_%TIME:~6,2%
set TimeStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
set DateStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!
set OnlyTimeStamp=!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@rem 
echo %StartTimeStamp%
@rem  bool
set isStep=0
set sDriveLetter=
set sCmd=wmic volume where "label='Storage'" get DriveLetter
@rem ======================================================================
call %sCmd%>%temp%\tmpDriveLetter.txt
powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt)[1].Trim()">%temp%\fDriveLetter.txt

powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt)[0,1].Trim()"

FOR /F "usebackq delims=" %%A IN ("%temp%\fDriveLetter.txt") DO ( if not "%%~A" == "" (@set "sDriveLetter=%%~A") )

wmic exit
@rem  Проверить пустая переменная или нет, если да то выход >>>>>>>>>>>>>>>>>>>>>>>>>> >>
@if "%sDriveLetter%" == "" (
	echo DriveLetter not found
	exit /b
)
@rem  << <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
@rem  int
@rem set /A KB=1*1024
@rem set /A MB=400*1048576
@Rem === RoboCopy ===
@set RCLogFile=%LogsDir%\_ROBOCOPY\%DateTimeStamp%_ROBOCOPY.txt
@if not exist "%LogsDir%\_ROBOCOPY" mkdir "%LogsDir%\_ROBOCOPY"
@set RCParams=/S /ZB /R:3 /W:2 /SL /MT:8 /XA:sh
@set RCParams2=/S /ZB /R:3 /W:2 /SL /MT:8
@set RCParams3=/S /B /Z /R:3 /W:2 /SL /MT:8
@set RCFileDataFlags=/COPYALL /DCOPY:DAT
@rem set RC_ExcludeDirList[1]="Yandex" "Vivox" "IceDragon" "Logs" "Recent" "Report*" "Temporary*" "*Crash*" "*Temp*" "*History*" "*Log*" "Application*" "Microsoft" "Diagnostics" "Packages" "Comms" "NVIDIA*" "Programs" "Publishers" "TempCheckUpdate" "fontconfig" "{*}" "*Folder" "e2eSoft" "speech" "TechSmith" "*Tile*" "Wondershare" "VirtualStore" "ConnectedDevicesPlatform"
@rem set RC_ExcludeDirList[2]="Flash Player" "AMS Software" "Anvsoft" "Macromedia" "Microsoft" "tor" "Recent" "Report*" "Temporary*" "*Crash*" "*Temp*" "*History*" "*Log*" "Programs" "Publishers" "{*}" "*Folder" "speech" "TechSmith" "NVIDIA*"
@rem set RC_ExcludeRecurseFileList[1]="IconCache*" "thumbcache*" "*.cookie" "*.log" "*.tmp" "*.dmp" "*.vbs" "*.7z"
@rem set RC_ExcludePF="Common Files" "internet explorer" "MSBuild" "NVIDIA*" "Reference Assemblies" "rempl" "TechSmith" "UmmyVideoDownloader" "Uninstall Information" "Unity*" "UNP" "VK" "Windows*" "WindowsPowerShell" "Yandex"
@rem set RC_ExcludePFx86="Bandicam" "BandiMPEG1" "Common Files" "e2eSoft" "Google\CrashReports" "Intel" "Internet Explorer" "InstallShield Installation Information" "Microsoft" "Microsoft SDKs" "Microsoft Visual Studio" "Microsoft Web Tools" "Microsoft.NET" "MSBuild" "MSI Afterburner" "NVIDIA*" "Reference Assemblies" "RivaTuner Statistics Server" "Uninstall Information" "VulkanRT" "Windows*" "WindowsPowerShell" "Yandex"

@rem [2020_02_29__16_43_33] [добавить - C:\ProgramData\Microsoft\Windows\Start Menu\Programs]

@rem  7za
set 7zaKeyString=-ssw -m0=LZMA2:d128m:fb256 -myx9 -mmt=8 -ms=off
set 7zaKeyString2=-ssw -mmt=8 -ms=off
set 7zaKeyString3=-ssw -mmt=8
set 7zaKeyString4=-ssw -mmt=8 -mx9 -ms=off
@rem set 7za=%~dp0\7z\1900\x64\7za.exe
if /i "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
	@set 7za=%ScriptsRootPath%\7za\x64\7za.exe
) else (
	@set 7za=%ScriptsRootPath%\7za\7za.exe
)
@rem  RAR
set winrar=%ScriptsRootPath%\WinRAR\winrar.exe
set RARKeysString=-dh -ed -md128m -m5 -qo+ -rr5p -y
set RARKeysString2=-dh -ed -md128m -m0 -qo+ -rr5p -y
set RARKey1= -ep1
set RARKey2= -ep2
@rem Запустить как фоновый процесс.
set RARKey3= -ibck
set RARDateTimeStampKeyString=-agYYYY-MM-DD--HH-MM-SS

set FileName=%USERNAME%_Backup_Full
@rem  Папки
set UsersDir[0]=Users\Public
set Dir[0]=%userprofile%\AppData\LocalLow
set Dir[1]=%userprofile%\AppData\Local
set Dir[2]=%userprofile%\AppData\Roaming
set Dir[3]=C:\Users\Public
set Dir[4]=%ProgramFiles%
set Dir[5]=C:\Program Files (x86)
set Dir[6]=C:\ProgramData
set Dir[7]=C:\[]TempDownloads
set Dir[8]=%sDriveLetter%\LSS\[]Torrents
set Dir[9]=%sDriveLetter%\LSS\[]RestoreWin
set Dir[10]=%userprofile%\AppData\Roaming\Microsoft\Windows\SendTo

set BackupsDir=%sDriveLetter%\___OS_BackUps\_BackupsArchive

set OutputDir[0]=%BackupsDir%\%TimeStamp%_%FileName%\Users\%USERNAME%\AppData\LocalLow
set OutputDir[1]=%BackupsDir%\%TimeStamp%_%FileName%\Users\%USERNAME%\AppData\Local
set OutputDir[2]=%BackupsDir%\%TimeStamp%_%FileName%\Users\%USERNAME%\AppData\Roaming
set OutputDir[3]=%BackupsDir%\%TimeStamp%_%FileName%\%UsersDir[0]%
set OutputDir[4]=%BackupsDir%\%TimeStamp%_%FileName%\Program Files
set OutputDir[5]=%BackupsDir%\%TimeStamp%_%FileName%\Program Files (x86)
set OutputDir[6]=%BackupsDir%\%TimeStamp%_%FileName%\ProgramData

@rem set TempDir[3]=%windir%\SoftwareDistribution\Download
@rem set TempDir[4]=%userprofile%\AppData\Local\Packages

set LogsDir=%ScriptsRootPath%\__Logs
set ListDir=%ScriptsRootPath%\__Lists
rem F:\Archive\_BackUps
rem  Files
set FileN[0]=LocalLow
set FileN[1]=Local
set FileN[2]=Roaming
set FileN[3]=Public
set FileN[4]=ProgramFiles
set FileN[5]=ProgramFiles_x86
set FileN[6]=ProgramData
rem  Ext
set FileExt[0]=torrent

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
@rem Colors
@set _Red=[91m
@set _Yellow=[93m
@set _Green=[92m
@set _White=[97m
@set _Normal_Red=[31m
@set _Normal_Yellow=[33m
@set _Normal_Green=[32m
@set _Normal_White=[37m
@set _Inverse=[7m
@set _col_off=[0m
 
@echo %_Normal_Yellow%" =================================== %_Normal_Green%End init%_Normal_Yellow% =================================== "%_col_off%
echo !TimeStamp!>>%LogFile%

@rem  Self Backup
@rem copy /v /y %0 %~dp0__BatchBackup\%~n0__%TimeStamp%%~x0
@set SelfBackupDir=%ScriptsRootPath%\__BatchBackup
@if not exist "%SelfBackupDir%\_%~n0" mkdir "%SelfBackupDir%\_%~n0"
@FOR /F "usebackq delims=" %%A IN ("%SelfBackupDir%\_Temp\tmpPrevSelfBackupDateTimeStamp(%~n0).txt") DO ( @if not "%%~A" == "" (@set "PrevSelfBackupDateTimeStamp=%%~A") )
@for %%i in (%0) do (
	@for /f "tokens=1-5 delims=.: " %%j in ("%%~ti") do (
		@if "%PrevSelfBackupDateTimeStamp%" == "" (@copy /v /y %0 "%SelfBackupDir%\_%~n0\[%~n0]__%TimeStamp%%~x0")
		@if "%%l%%k%%j%%m%%n" EQU "%PrevSelfBackupDateTimeStamp%" (@echo %_Normal_Red%"%_Normal_Yellow%The date and time of the file is equal to the previous entry. %_White%( %_Green% %%l%%k%%j%%m%%n %_White%= %_Green%%PrevSelfBackupDateTimeStamp% %_White%)%_Normal_Red%"%_col_off% )
		@if "%%l%%k%%j%%m%%n" NEQ "%PrevSelfBackupDateTimeStamp%" (
			@if "%%l%%k%%j%%m%%n" GTR "%PrevSelfBackupDateTimeStamp%" (
				@echo [92m " The date and time of the file is not equal to the previous entry. " [0m 
				@if not exist "%SelfBackupDir%\_%~n0\[%~n0]__%TimeStamp%%~x0" @copy /v /y %0 "%SelfBackupDir%\_%~n0\[%~n0]__%TimeStamp%%~x0"
			)
		)
	)
)
 
@for %%i in (%0) do (@for /f "tokens=1-5 delims=.: " %%j in ("%%~ti") do @echo %%l%%k%%j%%m%%n>"%SelfBackupDir%\_Temp\tmpPrevSelfBackupDateTimeStamp(%~n0).txt")
@rem @echo "Previous entry of File Date Time Stamp: %PrevSelfBackupDateTimeStamp%"
 
if %isStep% == 0 ( cd /D !Dir[1]!\ )
@timeout /t 1 >nul
@rem del /F /Q "%temp%\*.*"
@rem =================================================================================================================================
@rem =================================================================================================================================
@rem =================================================================================================================================
:Sandbox
echo [92m " =================================== Sandbox =================================== " [0m 
@rem set isStep=1
set CleanTemp=0
set isCLS=0
set tempStep=0
@if "%dm%" == 1 (
	@echo on
	@if %CleanTemp% == 5 (
		@cd /D "!Dir[1]!\"
		del /F /S /Q *.tmp
		del /F /S /Q *.log
		del /F /S /Q *.dmp
		@cd /D "!Dir[2]!\"
		del /F /S /Q *.tmp
		del /F /S /Q *.log
		del /F /S /Q *.dmp
	)
	@if %CleanTemp% == 6 (
		@cd /D "!Dir[1]!\"
		del /F /S /Q *.7z
		@cd /D "!Dir[2]!\"
		del /F /S /Q *.7z
	)
	@if %isStep% == 8 (
		@echo !DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!>>%LogFile%
		@goto :stop
	)
	@rem >> ===================================
	@rem << ===================================
	@rem set /a isStep=!isStep!+1
	@rem @timeout /t 3 >nul
	@rem 
	@goto :Sandbox
)
echo -- %dm% --
@timeout /t 3 >nul
echo [92m " =================================== Sandbox Border =================================== " [0m 
@if "%dm%" GEQ 1 ( goto :stop )
@rem =================================================================================================================================
@rem =================================================================================================================================
@rem =================================================================================================================================

:ReCreate
echo [92m " =================================== ReCreate, Step = %isStep% =================================== " [0m 
rem  CОЗДАНИЕ КАТАЛОГА ДЛЯ БЕКАПА
@rem ==============================================================
@rem Program Files					- %OutputDir[4]%
@rem Program Files (x86)			- %OutputDir[5]%
@rem ProgramData					- %OutputDir[6]%
@rem ==============================================================
@rem 
if not exist "%BackupsDir%\%TimeStamp%_%FileName%" mkdir "%BackupsDir%\%TimeStamp%_%FileName%\"
if not exist "%OutputDir[0]%" mkdir "%OutputDir[0]%"
if not exist "%OutputDir[1]%" mkdir "%OutputDir[1]%"
if not exist "%OutputDir[2]%" mkdir "%OutputDir[2]%"
if not exist "%OutputDir[3]%" mkdir "%OutputDir[3]%"
if not exist "%OutputDir[4]%" mkdir "%OutputDir[4]%"
if not exist "%OutputDir[5]%" mkdir "%OutputDir[5]%"
if not exist "%OutputDir[6]%" mkdir "%OutputDir[6]%"
if not exist "%BackupsDir%\%TimeStamp%_%FileName%\Users\%USERNAME%\AppData\Local" mkdir "%BackupsDir%\%TimeStamp%_%FileName%\Users\%USERNAME%\AppData\Local"
if not exist "%BackupsDir%\%TimeStamp%_%FileName%\Users\%USERNAME%\AppData\LocalLow" mkdir "%BackupsDir%\%TimeStamp%_%FileName%\Users\%USERNAME%\AppData\LocalLow"
if not exist "%BackupsDir%\%TimeStamp%_%FileName%\Users\%USERNAME%\AppData\Roaming" mkdir "%BackupsDir%\%TimeStamp%_%FileName%\Users\%USERNAME%\AppData\Roaming"
@timeout /t 1 >nul

:Pack
echo [92m " =================================== Pack, Step = %isStep%  =================================== " [0m 
cd /D !Dir[%isStep%]!\
if %isStep% LEQ 7 (
	if not %isStep% == 0 (
		if %isStep% LEQ 2 (
			for /f "delims=|" %%L in (!7z_List[%isStep%]!) Do (
				if exist "!Dir[%isStep%]!\%%L" (
					!7za! u -r0 !7zaKeyString4! "!OutputDir[%isStep%]!\%%L.7z" "%%L" -w"%Temp%" -xr@"!7z_ExcludeRecurseFiles[1]!"
				)
			)
			@rem !7za! u -r0 !7zaKeyString4! "!OutputDir[%isStep%]!\Microsoft\Credentials.7z" "!Dir[%isStep%]!\Microsoft\Credentials" '-xr@"!7z_ExcludeRecurseFiles!"'
			@rem !7za! u -r0 !7zaKeyString4! "!OutputDir[2]!\Microsoft\Crypto.7z" "%Dir[2]%\Microsoft\Crypto" '-xr@"!7z_ExcludeRecurseFiles!"'
			!7za! u !7zaKeyString4! "!OutputDir[%isStep%]!\!FileN[%isStep%]!.7z" @"!7z_List2[%isStep%]!"
		)
		@rem Users\Public
		if %isStep% == 3 ( !7za! u !7zaKeyString4! "!OutputDir[%isStep%]!\!FileN[%isStep%]!.7z" -w"%Temp%" @"!7z_List[%isStep%]!" )
		@rem Program Files...
		if %isStep% GEQ 4 (
			@rem Common Files...
			if %isStep% LEQ 5 (
				!7za! u !7zaKeyString4! "!OutputDir[%isStep%]!\Common Files.7z" -w"%Temp%" @"!7z_ListCommonFiles[%isStep%]!"
			)
			if %isStep% == 5 (
				!7za! u !7zaKeyString4! "!OutputDir[5]!\SkypeForDesktop_x86.7z" "Microsoft\Skype for Desktop\" -w"%Temp%"
				!7za! u !7zaKeyString4! "!OutputDir[5]!\Steam.7z" -w"%Temp%" @"%ListDir%\7z_Steam.txt"
				!7za! u !7zaKeyString4! "!OutputDir[5]!\Google.7z" -w"%Temp%" @"%ListDir%\7z_Google_x86.txt"
				@rem !7za! u -y !7zaKeyString4! "!OutputDir[5]!\Microsoft Visual Studio.7z" "!Dir[%isStep%]!\Microsoft Visual Studio\" -w"%Temp%"
				@rem !7za! u -y !7zaKeyString4! "!OutputDir[5]!\Nox.7z" "!Dir[%isStep%]!\Nox\" -w"%Temp%"
			)
			if %isStep% LEQ 6 (
				for /f "delims=|" %%L in (!7z_List[%isStep%]!) Do (
					if exist "!Dir[%isStep%]!\%%L" (
						!7za! u !7zaKeyString4! "!OutputDir[%isStep%]!\%%L.7z" "%%L" -w"%Temp%"
					)
				)
			)
			if %isStep% == 7 (
				xcopy * "!Dir[%isStep%]!\Torrents\*.!FileExt[0]!" /Y /Z /K /E
				xcopy /S/V/Z/I/Y "!Dir[%isStep%]!\*" "!Dir[8]!\"
				xcopy /S/V/Z/I/Y "!Dir[%isStep%]!\Torrents\*" "!Dir[8]!\"
			)
		)
	) else (
		if %isStep% == 0 (
			ROBOCOPY "%Dir[10]%\*" "%Dir[9]%\SendTo" %RCParams3% /LOG:"!RCLogFile!" %RCFileDataFlags%
			ROBOCOPY "C:\LSS\Users" "%sDriveLetter%\LSS\Users" %RCParams3% /LOG:"!RCLogFile!" %RCFileDataFlags%
			ROBOCOPY "C:\[]ProgramFiles" "%sDriveLetter%\LSS\[]ProgramFiles" %RCParams3% /LOG:"!RCLogFile!" %RCFileDataFlags%
			powershell -Command Export-StartLayout –path "%BackupsDir%\%TimeStamp%_%FileName%\Users\%USERNAME%\DefaultLayouts.xml"
			copy /v /y C:\_BackupRestore\[]Laptop\_RestoreBackupForLaptop.cmd "%BackupsDir%\%TimeStamp%_%FileName%\_RestoreBackupForLaptop.cmd"
			@rem Desktop
			!7za! u -r0 !7zaKeyString4! "%BackupsDir%\%TimeStamp%_%FileName%\Desktop.7z" "C:\LSS\Users\New\Desktop\*" -w"%Temp%"
			!7za! d -y "%BackupsDir%\%TimeStamp%_%FileName%\Desktop.7z" desktop.ini *.tmp *.dmp *.cookie *.log -r
			@rem LocalLow
			!7za! u -r0 !7zaKeyString4! "!OutputDir[%isStep%]!\!FileN[%isStep%]!.7z" "!Dir[%isStep%]!\*" -w"%Temp%" -xr@"!7z_ExcludeRecurseFiles[1]!"
			@rem USERNAME
			cd /D %userprofile%\
			!7za! u !7zaKeyString4! "%BackupsDir%\%TimeStamp%_%FileName%\Users\%USERNAME%\%USERNAME%.7z" -w"%Temp%" @"!7z_List[%isStep%]!"
		)
	)
)
@timeout /t 1 >nul

set /a isStep=!isStep!+1

if %isStep% GEQ 3 ( goto :DeleteFilesFromArchives )
if %isStep% LEQ 3 ( goto :Pack )
@REM if exist "!OutputDir[%isStep%]!\!FileN[%isStep%]!.7z" set /a isStep=!isStep!+1

@rem @timeout /t 360 >nul

:DeleteFilesFromArchives
echo [92m " =================================== Delete Files From Archives =================================== " [0m 
For /d %%A In ("%BackupsDir%\%TimeStamp%_%FileName%\Users\*") Do (
	for /f "usebackq delims=;" %%B in (`dir /a:a /s /b "%%A"`) do (
		!7za! d -y "%%B" desktop.ini *.tmp *.dmp *.cookie *.log -r
	)
)
if %isStep% LEQ 7 ( goto :Pack )

@rem exit /b
@rem @timeout /t 360 >

if %isStep% GEQ 8 ( goto :End )
 
:End
echo [92m " ========================================== End ========================================== " [0m 
@timeout /t 2 >nul
rem move /y "%BackupsDir%\Users" "%BackupsDir%\%TimeStamp%_%FileName%\"
rem move /y "%OutputDir[4]%" "%BackupsDir%\%TimeStamp%_%FileName%\"
rem move /y "%OutputDir[5]%" "%BackupsDir%\%TimeStamp%_%FileName%\"
rem move /y "%OutputDir[6]%" "%BackupsDir%\%TimeStamp%_%FileName%\"
REM if exist "%OutputDir[0]%" rmdir /S /Q "%OutputDir[0]%\"
REM if exist "%OutputDir[1]%" rmdir /S /Q "%OutputDir[1]%\"
REM if exist "%OutputDir[2]%" rmdir /S /Q "%OutputDir[2]%\"
REM if exist "%OutputDir[3]%" rmdir /S /Q "%OutputDir[3]%\"
REM if exist "%OutputDir[4]%" rmdir /S /Q "%OutputDir[4]%\"
REM if exist "%OutputDir[5]%" rmdir /S /Q "%OutputDir[5]%\"
REM if exist "%OutputDir[6]%" rmdir /S /Q "%OutputDir[6]%\"
endlocal
@rem 
exit /b
@rem 
@rem @timeout /t 2 >nul
@rem 
@rem exit
@rem 
:stop
echo [92m " =================================== Stop =================================== " [0m 
@rem 
if %isCLS% == 1 ( cls )
exit /b
@rem exit /b
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
