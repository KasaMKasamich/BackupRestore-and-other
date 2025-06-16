rem Test Full Backup
@rem F:\_BackupRestore\TestFullBackup.cmd
@echo on
Title "Test Full Backup"
@rem MODE CON: COLS=120 LINES=55
@rem MODE CON: COLS=220
setlocal enableextensions enabledelayedexpansion
@rem chcp 1251 >nul
@rem 
chcp 1252 >nul
@rem chcp 866 >nul
rem  Time
set digit1=%time:~0,1%
if "%digit1%"==" " (set digit1=0)
set TimeStamp=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%digit1%%TIME:~1,1%_%TIME:~3,2%_%TIME:~6,2%
rem  bool
set isStep=0
set isAppRunning=2
set isCliningConplete=0
rem  int
set /A KB=1*1024
set /A MB=400*1048576
rem  RoboCopy
set RCParams=/S /ZB /R:3 /W:2 /SL /MT:8 /XA:sh
set RCParams2=/S /ZB /R:3 /W:2 /SL /MT:8
set RC_ExcludeDirList[0]=""
set RC_ExcludeDirList[1]="Yandex" "Vivox" "IceDragon" "Logs" "Recent" "Report*" "Temporary*" "*Crash*" "*Temp*" "*History*" "*Log*" "Application*" "Microsoft" "Diagnostics" "Packages" "Comms" "NVIDIA*" "Programs" "Publishers" "TempCheckUpdate" "fontconfig" "{*}" "*Folder" "e2eSoft" "speech" "TechSmith" "*Tile*" "Wondershare" "VirtualStore" "ConnectedDevicesPlatform"
set RC_ExcludeDirList[2]="Flash Player" "AMS Software" "Anvsoft" "Macromedia" "Microsoft" "tor" "Recent" "Report*" "Temporary*" "*Crash*" "*Temp*" "*History*" "*Log*" "Programs" "Publishers" "{*}" "*Folder" "speech" "TechSmith" "NVIDIA*"
set RC_ExcludeRecurseFileList[1]="IconCache*" "thumbcache*" "*.cookie" "*.log" "*.tmp" "*.dmp" "*.vbs" "*.7z"
@rem set RC_ExcludeRecurseFileList[1]="IconCache*" "thumbcache*" "*.cookie" "*.log" "*.tmp" "*.dmp" "*.vbs" "*.7z"
@rem set RC_ExcludeRecurseFileList[2]="IconCache*" "thumbcache*" "*.cookie" "*.log" "*.tmp" "*.dmp" "*.vbs" "*.7z"
@rem set RCYandexExcludeDirs="*Crash*" "*Temp*" "*Logs*" "*Report*" "BrowserMetrics" "Safe Browsing" "Safe Browsing Cookies" "CrashpadMetrics-active.pma" "*History*" "*Log*" "Application*" "Microsoft" "Diagnostics" "Packages" "Comms" "NVIDIA*" "Programs" "Publishers" "TempCheckUpdate" "fontconfig" "{*}" "*Folder" "e2eSoft" "speech" "TechSmith" "*Tile*" "Wondershare" "VirtualStore" "ConnectedDevicesPlatform"
@rem set RCYandexExcludeFile="*.cookie" "*.log" "*.tmp" "*.dmp" "*.vbs"
set RCFileDataFlags=/COPYALL /DCOPY:DAT
rem  7za
set 7zaKeyString=-ssw -m0=LZMA2:d128m:fb256 -myx9 -slp -mmt=8 -ms=off
set 7za=%~dp0\7z\1900\x64\7za.exe
rem  Папки
set UsersDir[0]=Users\Public
set Dir[0]=%userprofile%\AppData\LocalLow
set Dir[1]=%userprofile%\AppData\Local
set Dir[2]=%userprofile%\AppData\Roaming
set Dir[3]=%ProgramFiles%
set Dir[4]=C:\Program Files (x86)
set Dir[5]=C:\ProgramData
set BackupsDir=F:\Archive\_BackUps
set TempSourceBackupDir=C:\_BR\Temp
set TempBackupDir=C:\_BR
set TempRoboCopDir[0]=C:\_BR\_RoboTemp
set TempRoboCopDir[1]=C:\_BR\_RoboTemp\Local
set TempRoboCopDir[2]=C:\_BR\_RoboTemp\Roaming
set TempAppData[0]=%TempBackupDir%\Users\%USERNAME%\AppData\LocalLow
set TempAppData[1]=%TempBackupDir%\Users\%USERNAME%\AppData\Local
set TempAppData[2]=%TempBackupDir%\Users\%USERNAME%\AppData\Roaming
set TempUsersDir[0]=%TempBackupDir%\%UsersDir[0]%
set TempDir[0]=C:\_BR\Program Files
set TempDir[1]=C:\_BR\Program Files (x86)
set TempDir[2]=C:\_BR\ProgramData
@rem set TempDir[3]=%windir%\SoftwareDistribution\Download
@rem set TempDir[4]=%userprofile%\AppData\Local\Packages

set CleaningDir=%TempSourceBackupDir%
set LogsDir=%~dp0\__Logs
set ListDir=%~dp0\__Lists
rem F:\Archive\_BackUps
rem  Files
set FileN[0]=LocalLow
set FileN[1]=Local
set FileN[2]=Roaming
set FileN[3]=Public

set FileName=FullBackup
set LogFile=%LogsDir%\%TimeStamp%_%FileName%.log
set RCLogFile=%LogsDir%\!TimeStamp!_%FileName%.txt
rem  File Lists
set 7z_List[0]=""
set 7z_List[1]=%ListDir%\7z_Local.txt
set 7z_List[2]=%ListDir%\7z_Roaming.txt
set 7z_List[3]=%ListDir%\7z_UserProfile.txt
set 7z_List[4]=%ListDir%\7z_Public.txt

set 7z_ExcludeList[0]=""
set 7z_ExcludeList[1]=%ListDir%\7z_ExcludeLocal.txt
set 7z_ExcludeList[2]=%ListDir%\7z_ExcludeRoaming.txt

set 7z_ExcludeRecurseList[0]=""
set 7z_ExcludeRecurseList[1]=%ListDir%\7z_R_ExcludeLocal.txt
set 7z_ExcludeRecurseList[2]=%ListDir%\7z_R_ExcludeLocal.txt

set 7z_ExcludeRecurseFiles[0]=""
set 7z_ExcludeRecurseFiles[1]=%ListDir%\7z_R_ExcludeFiles.txt

set List_Exclude[0]=""
set List_Exclude[1]=%ListDir%\ExcludeLocal.txt
set List_Exclude[2]=%ListDir%\ExcludeRoaming.txt

set List_Delete[0]=""
set List_Delete[1]=%ListDir%\PS_DeleteLocal.txt
set List_Delete[2]=%ListDir%\PS_DeleteRoaming.txt

echo [92m " =================================== End init =================================== " [0m 

rem  Self Backup
copy /v /y %0 %~dp0__BatchBackup\%~n0__%TimeStamp%%~x0

if %isStep% == 0 ( cd /D !Dir[1]!\ )
@timeout /t 1 >nul
@rem del /F /Q "%temp%\*.*"
@rem =================================================================================================================================
@rem =================================================================================================================================
@rem =================================================================================================================================
:Sandbox
cd /D %TempSourceBackupDir%\
rem powershell -noprofile -command "ls -r|measure -s Length"
Echo WScript.Echo Round(CreateObject("Scripting.FileSystemObject").GetFolder(WScript.Arguments(0)).Size/2^^20,6)>GetDirSize.vbs
for /f "usebackq delims=;" %%A in (`dir /b *.*`) do (
	For /F "delims=" %%B In ('CScript //Nologo "%TempSourceBackupDir%"\GetDirSize.vbs "%%A"') Do (
		Set Bytes=%%B
		set /A "fBytes=!Bytes!+0,000008"
		Set /A IntMB=!Bytes!/1048576
		Set /A IntKB=!Bytes!/1024
		Set /A FloatMB=!Bytes!%%1048576/10000
		Set /A FloatKB=!Bytes!%%1024/10
		if %%B geq "0,000001" Echo Size of %%A is !fBytes! MB. >> %LogFile%
	)
)
echo [92m " =================================== Sandbox =================================== " [0m 
set DM=1
set CleanTemp=0
set isCLS=0
set tempStep=0
if %DM% == 1 (
	if %CleanTemp% GEQ 1 if %CleanTemp% NEQ 4 ( if exist %TempSourceBackupDir% ( powershell -Command "Remove-Item -path "%TempSourceBackupDir%\*" -Recurse -Confirm:$false -Force" ))
	if %CleanTemp% == 2 ( if exist %TempRoboCopDir[0]% ( powershell -Command "Remove-Item -path "%TempRoboCopDir[0]%\*" -Recurse -Confirm:$false -Force" ))
	if %CleanTemp% == 3 ( if exist %TempBackupDir%\Users\ ( powershell -Command "Remove-Item -path "%TempBackupDir%\Users\*" -Recurse -Confirm:$false -Force" ))
	@rem set %isStep%=1
	@timeout /t 3 >nul
	if %CleanTemp% == 4 (
		set /a isStep=!isStep!+1
		if not %isStep% == 0 (
			if %isStep% == 1 ( set %tempStep%=2 )
			if %isStep% == 2 ( set %tempStep%=1 )
			for /f "delims=|" %%L in (!List_Exclude[%isStep%]!) Do (
				for /f "usebackq delims=" %%i in (`dir /a:d /b "%TempRoboCopDir[!tempStep!]%\%%L"`) Do (
					if exist "%TempRoboCopDir[!tempStep!]%\%%i" rmdir /q "%TempRoboCopDir[!tempStep!]%\%%~nxi"
				)
			)
		)
		if %isStep% == 2 ( goto :stop )
		goto :Sandbox
	)
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
@rem >> ===================================
	rem @echo on
REM cd /D %TempSourceBackupDir%\
REM for /f "usebackq delims=;" %%A in (`dir /b *.*`) do (
	REM echo -- %%~nxA	--	%%~zA			%%A
	REM if "!Dir[1]!\%~n0" == "!Dir[1]!\%%A" (
		REM @rem If %%~zA LSS 1
		echo -- Y -- %%~nxA	--			%%A
	REM )
REM )
@rem
REM For /D %%A In ("!Dir[1]!\*") Do (
	REM if "%Dir[1]%\%%~nxA" == "%%A" (
		REM echo -- Y -- %Dir[1]%\%%~nxA	--			%%A
	REM ) else (
		REM echo -- N -- %Dir[1]%\%%~nxA	--			%%A
	REM )
REM )
echo rem =============================================================================================================================
REM For /D %%A In ("!Dir[2]!\*") Do (
	REM if "%Dir[2]%\%%~nxA" == "%%A" ( echo -- Y -- %Dir[2]%\%%~nxA				%%A 
	REM ) else ( echo -- N -- %Dir[2]%\%%~nxA				%%A )
REM )


@rem << ===================================
)
@timeout /t 3 >nul
echo [92m " =================================== Sandbox Border =================================== " [0m 
if %DM% == 1 ( goto :stop )
@rem =================================================================================================================================
@rem =================================================================================================================================
@rem =================================================================================================================================
if %isStep% == 0 (goto :ReCreate)
rem 
:CheckCleaning
rmdir /Q "%CleaningDir%\"
if errorlevel 1 (
	if %isCliningConplete% GEQ 2 ( goto :ReCreate )
	set /a isCliningConplete=!isCliningConplete!+1
	set CleaningDir=!TempAppData[%isStep%]!
	if %isCliningConplete% LSS 2 ( call :Cleaning )
) else (
	goto :CheckCleaning
)
@timeout /t 5 >nul

:Cleaning
if not %isStep% == 0 (
	@rem powershell -Command "Get-ChildItem -Path "%TempSourceBackupDir%\*" -Directory  | foreach { $_.Delete()}"
)
if %isStep% LEQ 2 ( cd /D !TempAppData[%isStep%]!\ )
@timeout /t 1 >nul
@rem очищать все линки перед созданием, с условием isStep
rem  DIRECTORIES FOR CLEANING
@rem	 команда rd удаляет только пустые папки, если ее использовать без ключа /s
for /f "usebackq delims=" %%A in (`dir /a:d /s /b *`) do ( If %%~zA LSS 1 if exist "%%~nxA" rd /q "%%~nxA" )  
rem  FILES FOR CLEANING
del /F /S /Q *.tmp
del /F /S /Q *.log
del /F /S /Q *.dmp
for /f "usebackq delims=;" %%A in (`dir /s /b *.*`) do (
	if "%%~nxA" == "%%A" (
		If %%~zA LSS 1 del /f /s /q "%%A"
	)
)
for /f "usebackq delims=;" %%A in (`dir /a:h-s /s /b *.*`) do (
	if "%%~nxA" == "%%A" (
		If %%~zA LSS 1 del /f /s /q /a:h-s "%%A"
	)
)
rem for /f "usebackq delims=;" %%A in (`dir /a:hs /s /b *.*`) do ( If %%~zA LSS 1 del /f /s /q /a:hs "%%A" )
@timeout /t 1 >nul
@rem goto :CheckCleaning
rem 
:ReCreate
@rem set isCliningConplete=0
echo [92m " =================================== ReCreate, Step = %isStep% =================================== " [0m 
rem  CОЗДАНИЕ ВРЕМЕННОГО КАТАЛОГА ДЛЯ БЕКАПА
if not exist "%TempSourceBackupDir%" mkdir "%TempSourceBackupDir%"
if not exist "%TempRoboCopDir[1]%" mkdir "%TempRoboCopDir[1]%"
if not exist "%TempRoboCopDir[2]%" mkdir "%TempRoboCopDir[2]%"
if not exist "%TempBackupDir%\Users\%USERNAME%\AppData\Local" mkdir "%TempBackupDir%\Users\%USERNAME%\AppData\Local"
if not exist "%TempBackupDir%\Users\%USERNAME%\AppData\LocalLow" mkdir "%TempBackupDir%\Users\%USERNAME%\AppData\LocalLow"
if not exist "%TempBackupDir%\Users\%USERNAME%\AppData\Roaming" mkdir "%TempBackupDir%\Users\%USERNAME%\AppData\Roaming"
if not exist "%TempDir[0]%" mkdir "%TempDir[0]%"
if not exist "%TempDir[1]%" mkdir "%TempDir[1]%"
if not exist "%TempDir[2]%" mkdir "%TempDir[2]%"
rem if not exist "%TempDir[3]%" mkdir "%TempDir[3]%"
rem if not exist "%TempDir[4]%" mkdir "%TempDir[4]%"
@timeout /t 1 >nul
if %isStep% LEQ 2 (
	if exist !Dir[%isStep%]!\GetDirSize.vbs (
		goto :Pack
	) else (
		goto :CreateVBSScripts
	)
)
rem 
:CreateVBSScripts
echo [92m " =================================== CREATE SCRIPT OBJECT, Step = %isStep% =================================== " [0m 
if exist !Dir[%isStep%]!\GetDirSize.vbs ( Del /F /Q !Dir[%isStep%]!\GetDirSize.vbs 1>nul 2>&1 )
if exist %TempSourceBackupDir%\GetDirSize.vbs ( Del /F /Q %TempSourceBackupDir%\GetDirSize.vbs 1>nul 2>&1 )
@timeout /t 1 >nul
cd /D !Dir[%isStep%]!\
Echo WScript.Echo CreateObject("Scripting.FileSystemObject").GetFolder(WScript.Arguments(0)).Size>GetDirSize.vbs
@timeout /t 1 >nul
cd /D %TempSourceBackupDir%\
Echo WScript.Echo CreateObject("Scripting.FileSystemObject").GetFolder(WScript.Arguments(0)).Size>GetDirSize.vbs
@timeout /t 2 >nul
rem 
:Pack
echo [92m " =================================== CREATE MKLINK`S, Step = %isStep% =================================== " [0m 
if not %isStep% == 0 (
	powershell -Command "Get-ChildItem -Path "%TempSourceBackupDir%\*" -Directory  | foreach { $_.Delete()}"
)
@timeout /t 2 >nul
cd /D %TempSourceBackupDir%\
if not %isStep% == 0 (
	for /d %%A In ("!Dir[%isStep%]!\*") Do (
		if not exist "%%~nxA" MKLINK /d /h /j "%%~nxA" "%%A"
	)
)
echo [92m " =================================== Exclude MKLINK`S, Step = %isStep% =================================== " [0m 
@timeout /t 2 >nul
if not %isStep% == 0 (
	for /f "delims=|" %%L in (!List_Exclude[%isStep%]!) Do (
		for /f "usebackq delims=" %%B in (`dir /a:d /b "%TempSourceBackupDir%\%%L"`) Do (
			if "%%~nxB" == "%%B" (
				if exist "%TempSourceBackupDir%\%%B" rmdir /q "%TempSourceBackupDir%\%%~nxB"
			)
		)
	)
)
@timeout /t 3 >nul
echo [92m " =================================== ROBOCOPY & Pack, Step = %isStep%  =================================== " [0m 
if %isStep% LEQ 2 (
	@rem if not exist "!TempAppData[%isStep%]!\!FileN[%isStep%]!.7z" ( call :NotBatchAppDataPacking )
	cd /D !Dir[%isStep%]!\
	if not %isStep% == 0 (
		ROBOCOPY "%TempSourceBackupDir%" "!TempRoboCopDir[%isStep%]!" %RCParams% /LOG:"!RCLogFile!" /XF !RC_ExcludeRecurseFileList[1]! /XD !RC_ExcludeDirList[%isStep%]! %RCFileDataFlags%
		if %isStep% == 1 ( rmdir /Q "%Dir[1]%\Comodo\IceDragon\" )
		For /D %%A In ("!TempRoboCopDir[%isStep%]!\*") Do (
			if "!TempRoboCopDir[%isStep%]!\%%~nxA" == "%%A" (
				!7za! u -y -r !7zaKeyString! "!TempAppData[%isStep%]!\%%~nxA.7z" "%%A" -x@"!7z_ExcludeList[%isStep%]!" -xr@"!7z_ExcludeRecurseList[%isStep%]!"
			)
		)
		if %isStep% LEQ 2 (
			!7za! u -y -r !7zaKeyString! "!TempAppData[%isStep%]!\Microsoft\Credentials.7z" "!Dir[%isStep%]!\Microsoft\Credentials" '-xr@"!7z_ExcludeRecurseFiles!"'
			@rem !7za! u -y -r !7zaKeyString! "!TempAppData[2]!\Microsoft\Credentials.7z" "%Dir[2]%\Microsoft\Credentials" '-xr@"!7z_ExcludeRecurseFiles!"'
			!7za! u -y -r !7zaKeyString! "!TempAppData[2]!\Microsoft\Crypto.7z" "%Dir[2]%\Microsoft\Crypto" '-xr@"!7z_ExcludeRecurseFiles!"'
			!7za! u -y !7zaKeyString! "!TempAppData[%isStep%]!\!FileN[%isStep%]!.7z" @"!7z_List[%isStep%]!"
		)
	) else (
		!7za! u -y -r !7zaKeyString! "%TempAppData[0]%\%FileN[0]%.7z" "%Dir[0]%\*" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles!"'
	)
)
if %isStep% == 0 (
	cd /D %userprofile%\
	!7za! u -y !7zaKeyString! "%TempBackupDir%\Users\%USERNAME%\%USERNAME%.7z" @"!7z_List[3]!"
	cd /D C:\%UsersDir[0]%\
	!7za! u -y !7zaKeyString! "%TempBackupDir%\%UsersDir[0]%\Public.7z" @"!7z_List[4]!"
)
@timeout /t 1 >nul
@rem @timeout /t 360 >nul
rem 
goto :Switch
rem 
:Switch
@timeout /t 2 >nul
if exist "!TempAppData[%isStep%]!\!FileN[%isStep%]!.7z" ( set /a isStep=!isStep!+1 )
@rem if not exist "!TempAppData[0]!\LocalLow.7z" if %isStep% == 1 (set isStep=2)
@rem if not exist "!TempAppData[1]!\Local.7z" if %isStep% == 1 (set isStep=1)
@rem if not exist "!TempAppData[2]!\Roaming.7z" if %isStep% == 2 (set isStep=2)
rem if exist "%TempBackupDir%\Roaming.7z" if %isStep% == 2 (set isStep=3)
if %isStep% == 1 (goto :Pack)
if %isStep% GEQ 3 (goto :DeleteFilesFromArchives)
if %isStep% GEQ 2 (
	@rem set CleaningDir=%TempSourceBackupDir%
	goto :Cleaning
)
rem 
:DeleteFilesFromArchives
echo [92m " =================================== Delete Files From Archives =================================== " [0m 
@rem ! Перед удалением файлов в архивах, переместить их в другую папку или задать фильтр на .7z
@timeout /t 2 >nul
For /d %%A In ("%TempBackupDir%\Users\*") Do (
	for /f "usebackq delims=;" %%B in (`dir /a:a /s /b "%%A"`) do (
		set TimeStamp=%TimeStamp%
		!7za! d -y "%%B" desktop.ini *.tmp *.dmp *.cookie *.log -r >>%LogsDir%\%TimeStamp%_%%~nxB.log
	)
)
exit /b
@timeout /t 360 >nul
rem 

rem 
:End
echo [92m " ========================================== End ========================================== " [0m
@timeout /t 2 >nul
Del /F /Q !Dir[0]!\GetDirSize.vbs 1>nul 2>&1
Del /F /Q !Dir[1]!\GetDirSize.vbs 1>nul 2>&1
Del /F /Q !Dir[2]!\GetDirSize.vbs 1>nul 2>&1
Del /F /Q %TempSourceBackupDir%\GetDirSize.vbs 1>nul 2>&1
@rem del /F /S /Q "%TempSourceBackupDir%\*"
if exist "%TempSourceBackupDir%" rmdir /S /Q "%TempSourceBackupDir%"
if exist "%TempAppData[0]%" rmdir /S /Q "%TempAppData[0]%\"
if exist "%TempAppData[1]%" rmdir /S /Q "%TempAppData[1]%\"
if exist "%TempAppData[2]%" rmdir /S /Q "%TempAppData[2]%\"
if exist "%TempDir[0]%" rmdir /S /Q "%TempDir[0]%\"
if exist "%TempDir[1]%" rmdir /S /Q "%TempDir[1]%\"
if exist "%TempDir[2]%" rmdir /S /Q "%TempDir[2]%\"
@rem if exist "%TempDir[3]%" rmdir /S /Q "%TempDir[3]%\"
@rem if exist "%TempDir[4]%" rmdir /S /Q "%TempDir[4]%\"
if exist "%TempRoboCopDir[0]%" rmdir /S /Q "%TempRoboCopDir[0]%\"
if exist "%TempRoboCopDir[1]%" rmdir /S /Q "%TempRoboCopDir[1]%\"
if exist "%TempRoboCopDir[2]%" rmdir /S /Q "%TempRoboCopDir[2]%\"
endlocal
rem @timeout /t 2 >nul
rem exit
:stop
echo [92m " =================================== Stop =================================== " [0m 
@rem 
if %isCLS% == 1 ( cls )
exit /b
exit /b
@rem @timeout /t 360 >nul
rem 
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
@rem   
@rem   
@rem   
@rem   
@rem   
@rem   
@rem   
@rem   
@rem   
@rem   
@rem   
@rem   
@rem   
@rem > ==============================================================================================




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

@rem xcopy %Dir[1]%\Microsoft\Windows\Themes\ %TempDirNBP%\%FileN[0]%\Microsoft\Windows\Themes\ /R /Y /O /X

@rem xcopy %Dir[1]%\NVIDIA\accounts. %TempDirNBP%\%FileN[0]%\NVIDIA\ /R /Y /O /X

	@rem !7za! u -y !7zaKeyString! "!TempAppData[%isStep%]!\!FileN[%isStep%]!.7z" @"!7z_List[%isStep%]!"
	@rem !7za! u -y -r !7zaKeyString! "!TempAppData[%isStep%]!\!FileN[%isStep%]!.7z" "%TempDirNBP%\!FileN[%isStep%]!\*"
	@rem !7za! u -y -r !7zaKeyString! "!TempAppData[%isStep%]!\!FileN[%isStep%]!.7z" "%TempDirNBP%\!FileN[%isStep%]!\*" '@"%7z_List[!isStep!]%"'
@rem if not %isStep% == 0 (
@rem )
@rem !7za! u -y -r !7zaKeyString! "!TempAppData[%isStep%]!\!FileN[%isStep%]!.7z" "%TempDirNBP%\!FileN[%isStep%]!\*" -w"%Temp%"
@rem !7za! u -y -r !7zaKeyString! "!TempAppData[%isStep%]!\!FileN[%isStep%]!.7z" "%TempDirNBP%\!FileN[%isStep%]!\*" -w"%Temp%" '-x@"!ListLocalExclude!"' '-xr@"!ListRecurseExclude!"'


rem Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\_LastDesktopBackup.7z" "%userprofile%\Desktop\"
rem Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_DesktopBackup.7z" "%userprofile%\Desktop\"


rem if %isStep% == 0 (
rem 	goto :Switch
rem )
rem if %isStep% == 1 (
rem 


rem )
rem if %isStep% == 2 (
rem )@timeout /t 2 >nul

rem Копирование архивов Бекапа.
rem ROBOCOPY "C:\_BR\_backups" /S /ZB /R:3 /W:2 /SL /MT:32 /LOG:"%RoboCopyLogFile%" /COPYALL /DCOPY:DAT /TBD "%BackUpStoreDir%\AppData" /XF "IconCache*" /XD "Report*" "Temporary*" "*Cache*"
rem @timeout 3

rem > позже перенести в отдельную метку, индивидуального копирования Local (также при необходимости и LocalLow b Roaming )
rem Если с исключениями:
rem !7za! u -y -r !7zaKeyString! "%TempBackupDir%\!FileN[%isStep%]!.7z" "%TempAppData[0]%\*" -w"%Temp%" -x@"!7z_ExcludeList[%isStep%]!" -xr@"!7z_ExcludeRecurseList[%isStep%]!"
rem <

rem start /b /wait 
rem
rem if %isStep% == 1 (goto :ReCreate)

rem pause
rem @timeout /t 3 >nul
rem if %isStep% == 1 (goto :StepGTRPack)
rem 
@rem !7za! u -y -r !7zaKeyString! "%TempBackupDir%\Local.7z" "%TempBackupLocalDir%\*" -w"%Temp%" -x@"!ListLocalExclude!" -xr@"!ListRecurseExclude!"


@rem F:\_BackupRestore\7z\1900\x64\7za.exe a -ssw "%TempBackupDir%\2.7z" "%TempSourceBackupDir%\*" -r0 -w"%TempBackupDir%" -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%" -bsp2 -slp -scsWIN -mmt=on -mx9 -ms=off

rem	if errorlevel 255 echo Операция была прервана пользователем.
rem	if errorlevel 16 echo ***FATAL ERROR*** & goto end
rem	if errorlevel 15 echo OKCOPY + FAIL + MISMATCHES + XTRA & goto end
rem	if errorlevel 14 echo FAIL + MISMATCHES + XTRA & goto end
rem	if errorlevel 13 echo OKCOPY + FAIL + MISMATCHES & goto end
rem	if errorlevel 12 echo FAIL + MISMATCHES& goto end
rem	if errorlevel 11 echo OKCOPY + FAIL + XTRA & goto end
rem	if errorlevel 10 echo Нет файлов, удовлетворяющих указанной маске, и параметров.
rem	if errorlevel 9 echo Ошибка при создании файла.
rem	if errorlevel 8 echo Недостаточно памяти для выполнения операции.
rem	if errorlevel 7 echo Ошибка при указании параметра в командной строке.
rem	if errorlevel 6 echo Произошла ошибка открытия файла.
rem	if errorlevel 5 echo Произошла ошибка записи на диск. Access is denied
rem	if errorlevel 4 echo Предпринята попытка изменить заблокированный архив.
rem	if errorlevel 3 echo Неверная контрольная сумма CRC32. Данные повреждены.
rem	if errorlevel 2 echo Произошла критическая ошибка.
rem	if errorlevel 1 echo Предупреждение. Произошли некритические ошибки.
rem	if errorlevel 0 echo Операция успешно завершена

REM start /b /wait F:\_BackupRestore\7za\7za.exe a -t7z -ssw -mx9 "%TempBackupDir%\2.7z" "%TempBackupDir%\*" -r0 -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%"
rem F:\_BackupRestore\7za\
rem F:\_BackupRestore\7z\1604\x64\
rem F:\_BackupRestore\7z\1805\x64\
rem F:\_BackupRestore\7z\1900\x64\
rem ROBOCOPY "%TempSourceBackupDir%" "%TempBackupDir%" /S /ZB /R:3 /W:2 /SL /MT:32 /LOG:"%RoboCopyLogFile%" /XF "IconCache*" "*Cache*" "*.cookie" "*.LOG*" "*.tmp" /XD "Recent" "Report*" "Temporary*" "Caches" "*Cache*" "Temp" "*History*" /COPYALL /DCOPY:DAT /TBD
rem start /b /wait F:\_BackupRestore\7za\7za.exe a -t7z -ssw -mx9 "%TempBackupDir%\2.7z" "%TempSourceBackupDir%\*" -r0 -w"%TempBackupDir%" -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%"
rem start /REALTIME /wait F:\_BackupRestore\7z\1900\x64\7za.exe d -y "%TempBackupDir%\2.7z" -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%" -bsp2 -slp -scsWIN -mmt=4 -mx9 -ms=off



rem start /REALTIME /wait F:\_BackupRestore\7z\1900\x64\7za.exe a -ssw -y "%TempBackupDir%\2.7z" "%TempSourceBackupDir%\*" -r0 -w"%TempBackupDir%" -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%" -bsp2 -slp -scsWIN -mmt=on -mx9 -ms=off

rem For /D %%A In ("%Dir001%\*") Do (
rem 	For /F "delims=" %%B In ('CScript //Nologo GetDirSize.vbs "%%A"') Do (
rem 		Set Bytes=%%B
rem 		Set /A KB=50*1024
rem 		Set /A MB=6*1048576
rem 		Set /A FloatMB=!Bytes!%%1048576/10000
rem 		Set /A FloatKB=!Bytes!%%1024/10
rem 		if %%B geq !KB! if %%B leq !MB! F:\_BackupRestore\7z\1900\x64\7za.exe a "%BackupsDir%\%%~nxA.7z" "%%A" -r0 -w"%BackupsDir%" -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%" -bsp2 -ssw -slp -scsWIN -mmt=on -mx3 -ms=off
rem 	)
rem )

rem for /d %%A in (F:\MNM\*) do C:\arc\7za.exe a -t7z -mx=0 -r -mhe -pPASS -- "C:\MNM2\%%~nxA.7z" "%%A"
rem 
rem Set /A IntMB=!Bytes!/1048576
rem Set /A IntKB=!Bytes!/1024
rem Set /A FloatMB=!Bytes!%%1048576/10000
rem Set /A FloatKB=!Bytes!%%1024/10


rem for /d %%A in ('Dir "%Dir001%\*" /-C/S/A:D') do ( if %%~zA leq 50000 Echo Size of %%A is %%~zA Bytes. )

rem for /d %%A in ('Dir "%Dir001%\*" /-C/S/A:-D') do  if %%~zA geq 1 if %%~zA leq 50000 C:\_BackupRestore\7za\7za.exe a -t7z -ssw -mx=9 -x@%ListLocalExclude% "%BackupsDir%\%%~nxA.7z" "%%A"

