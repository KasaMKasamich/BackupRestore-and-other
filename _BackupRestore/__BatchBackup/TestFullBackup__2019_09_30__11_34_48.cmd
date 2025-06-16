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
set isExistVBS=0
set isAppRunning=2
set isCliningConplete=0
rem  int
set /A KB=1*1024
set /A MB=400*1048576
rem  RoboCopy
set RCParams=/S /ZB /R:3 /W:2 /SL /MT:8 /XA:sh
set RCParams2=/S /ZB /R:3 /W:2 /SL /MT:8
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
set Dir[3]=C:\Users\Public
set Dir[4]=%ProgramFiles%
set Dir[5]=C:\Program Files (x86)
set Dir[6]=C:\ProgramData

set BackupsDir=F:\Archive\_BackUps
set TempSourceBackupDir=C:\_BR\Temp
set TempBackupDir=C:\_BR

set TempRoboCopDir[0]=C:\_BR\_RoboTemp
set TempRoboCopDir[1]=C:\_BR\_RoboTemp\Local
set TempRoboCopDir[2]=C:\_BR\_RoboTemp\Roaming

set TempRoboCopDir[4]=C:\_BR\_RoboTemp\Program Files
set TempRoboCopDir[5]=C:\_BR\_RoboTemp\Program Files (x86)
set TempRoboCopDir[6]=C:\_BR\_RoboTemp\ProgramData

set TempOutputDir[0]=%TempBackupDir%\Users\%USERNAME%\AppData\LocalLow
set TempOutputDir[1]=%TempBackupDir%\Users\%USERNAME%\AppData\Local
set TempOutputDir[2]=%TempBackupDir%\Users\%USERNAME%\AppData\Roaming
set TempOutputDir[3]=%TempBackupDir%\%UsersDir[0]%
set TempOutputDir[4]=C:\_BR\Program Files
set TempOutputDir[5]=C:\_BR\Program Files (x86)
set TempOutputDir[6]=C:\_BR\ProgramData

@rem set TempDir[3]=%windir%\SoftwareDistribution\Download
@rem set TempDir[4]=%userprofile%\AppData\Local\Packages

set DeletedDir=C:\_BR\_Deleted\
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

set FileName=FullBackup
set LogFile=%LogsDir%\%TimeStamp%_%FileName%.log
set RCLogFile=%LogsDir%\!TimeStamp!_%FileName%.txt
rem  File Lists
set 7z_List[0]=%ListDir%\7z_UserProfile.txt
set 7z_List[1]=%ListDir%\7z_Local.txt
set 7z_List[2]=%ListDir%\7z_Roaming.txt
set 7z_List[3]=%ListDir%\7z_Public.txt
set 7z_List[4]=%ListDir%\7z_ProgramFiles.txt
set 7z_List[5]=%ListDir%\7z_ProgramFiles_x86.txt
set 7z_List[6]=%ListDir%\7z_ProgramData.txt

set 7z_ListCommonFiles[4]=%ListDir%\7z_CommonFiles.txt
set 7z_ListCommonFiles[5]=%ListDir%\7z_CommonFiles_x86.txt

set 7z_ExcludeList[1]=%ListDir%\Exclude\7z_ExcludeLocal.txt
set 7z_ExcludeList[2]=%ListDir%\Exclude\7z_ExcludeRoaming.txt

set 7z_ExcludeList[4]=%ListDir%\Exclude\7z_ExcludeProgramFiles.txt
set 7z_ExcludeList[5]=%ListDir%\Exclude\7z_ExcludeProgramFiles_x86.txt
set 7z_ExcludeList[6]=%ListDir%\Exclude\7z_ExcludeProgramData.txt

set 7z_ExcludeRecurseList[1]=%ListDir%\ExcludeRecurse\7z_R_ExcludeLocal.txt
set 7z_ExcludeRecurseList[2]=%ListDir%\ExcludeRecurse\7z_R_ExcludeLocal.txt

set 7z_ExcludeRecurseFiles[1]=%ListDir%\ExcludeRecurse\7z_R_ExcludeFiles.txt

set List_Exclude[1]=%ListDir%\ExcludeLocal.txt
set List_Exclude[2]=%ListDir%\ExcludeRoaming.txt

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
rem cd /D %TempSourceBackupDir%\
rem Echo WScript.Echo CreateObject("Scripting.FileSystemObject").GetFolder(WScript.Arguments(0)).Size>GetDirSize.vbs
REM for /f "usebackq delims=;" %%A in (`dir /b *.*`) do (
	REM For /F "delims=" %%B In ('CScript //Nologo "%TempSourceBackupDir%"\GetDirSize.vbs "%%A"') Do (
		REM Set Bytes=%%B
		REM if %%B leq 2 Echo Size of %%A is %%B MB. >> %LogFile%
	REM )
REM )
echo [92m " =================================== Sandbox =================================== " [0m 
@rem set isStep=1
set DM=1
set CleanTemp=0
set isCLS=0
set tempStep=0
if %DM% == 1 (
	if %CleanTemp% GEQ 1 if %CleanTemp% NEQ 4 ( if exist %TempSourceBackupDir% ( powershell -Command "Remove-Item -path "%TempSourceBackupDir%\*" -Recurse -Confirm:$false -Force" ))
	if %CleanTemp% == 2 ( if exist %TempRoboCopDir[0]% ( powershell -Command "Remove-Item -path "%TempRoboCopDir[0]%\*" -Recurse -Confirm:$false -Force" ))
	if %CleanTemp% == 3 ( if exist %TempBackupDir%\Users\ ( powershell -Command "Remove-Item -path "%TempBackupDir%\Users\*" -Recurse -Confirm:$false -Force" ))
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
rem >> ===================================
if %isStep% == 7 ( goto :stop )
@rem 
set /a isStep=!isStep!+1
cd /D !Dir[%isStep%]!\
call Echo WScript.Echo CreateObject('Scripting.FileSystemObject').GetFolder(WScript.Arguments(0)).Size>GetDirSize.vbs
@timeout /t 5 >nul
		@rem Users\Public
		if %isStep% == 3 (
			for /f "usebackq delims=;" %%A in (`dir /b *.*`) do (
				For /F "delims=" %%B In ('CScript //Nologo GetDirSize.vbs "%%A"') Do (
					if %%B GEQ 1 !7za! u -y !7zaKeyString! "!TempOutputDir[%isStep%]!\!FileN[%isStep%]!.7z" "%%A"
				)
			)
			@rem !7za! u -y !7zaKeyString! "!TempOutputDir[%isStep%]!\!FileN[%isStep%]!.7z" @"!7z_List[%isStep%]!"
		)
		@rem Program Files...
		!7za! u -y !7zaKeyString! "!TempOutputDir[5]!\SkypeForDesktop_x86.7z" "Microsoft\Skype for Desktop\" -w"%Temp%"
		!7za! u -y !7zaKeyString! "!TempOutputDir[5]!\Steam.7z" -w"%Temp%" @"%ListDir%\7z_Steam.txt"
		if %isStep% GEQ 4 (
			@rem Program Files...
			if %isStep% LEQ 5 (
				!7za! u -y !7zaKeyString! "!TempOutputDir[%isStep%]!\Common Files.7z" -w"%Temp%" @"!7z_ListCommonFiles[%isStep%]!"
			)
			if %isStep% LEQ 6 (
				For /D %%A In ("!Dir[%isStep%]!\*") Do (
					if "!Dir[%isStep%]!\%%~nxA" == "%%A" (
						!7za! u -y -r !7zaKeyString! "!TempOutputDir[%isStep%]!\%%~nxA.7z" "%%A" -x@"!7z_ExcludeList[%isStep%]!"
					)
				)
			)
		)
@timeout /t 5 >nul
goto :Sandbox
rem << ===================================
)
@timeout /t 3 >nul
echo [92m " =================================== Sandbox Border =================================== " [0m 
if %DM% == 1 ( goto :stop )
@rem =================================================================================================================================
@rem =================================================================================================================================
@rem =================================================================================================================================
if %isStep% == 0 (goto :ReCreate)
rem 
@timeout /t 5 >nul

:Cleaning
if %isStep% LEQ 2 (
	cd /D !TempRoboCopDir[%isStep%]!\
	del /F /S /Q *.tmp
	del /F /S /Q *.log
	del /F /S /Q *.dmp
	if not %isStep% == 0 (
		for /f "usebackq delims=;" %%A in (`dir /b *.*`) do (
			For /F "delims=" %%B In ('CScript //Nologo GetDirSize.vbs "%%A"') Do (
				if %%B LSS 1 !7za! a -y -r -sdel !7zaKeyString! "C:\_BR\_Deleted\!FileN[%isStep%]!_Deleted.7z" "%%A" >> %LogFile%
				@rem if %%B LSS 1 Echo Size of %%A is %%B MB. >> %LogFile%
				@rem move /y "%%A" "C:\_BR\_Deleted" >> %LogFile%
				@rem del /f /s /q "%%A" >> %LogFile%
			)
		)
	)
)
@timeout /t 1 >nul
goto :Pack

:ReCreate
echo [92m " =================================== ReCreate, Step = %isStep% =================================== " [0m 
rem  CОЗДАНИЕ ВРЕМЕННОГО КАТАЛОГА ДЛЯ БЕКАПА
@rem ==============================================================
@rem C:\_BR\Temp							- %TempSourceBackupDir%
@rem C:\_BR\_Deleted\						- %DeletedDir%
@rem ==============================================================
@rem C:\_BR\_RoboTemp\Local					- %TempRoboCopDir[1]%
@rem C:\_BR\_RoboTemp\Roaming				- %TempRoboCopDir[2]%
@rem C:\_BR\_RoboTemp\Program Files			- %TempRoboCopDir[3]%
@rem C:\_BR\_RoboTemp\Program Files (x86)	- %TempRoboCopDir[4]%
@rem C:\_BR\_RoboTemp\ProgramData			- %TempRoboCopDir[5]%
@rem ==============================================================
@rem C:\_BR\Program Files					- %TempOutputDir[4]%
@rem C:\_BR\Program Files (x86)				- %TempOutputDir[5]%
@rem C:\_BR\ProgramData						- %TempOutputDir[6]%
@rem ==============================================================
@rem 
if not exist "%TempSourceBackupDir%" mkdir "%TempSourceBackupDir%"
if not exist "%DeletedDir%" mkdir "%DeletedDir%"
if not exist "%TempRoboCopDir[1]%" mkdir "%TempRoboCopDir[1]%"
if not exist "%TempRoboCopDir[2]%" mkdir "%TempRoboCopDir[2]%"
if not exist "%TempRoboCopDir[3]%" mkdir "%TempRoboCopDir[3]%"
if not exist "%TempRoboCopDir[4]%" mkdir "%TempRoboCopDir[4]%"
if not exist "%TempRoboCopDir[5]%" mkdir "%TempRoboCopDir[5]%"
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
if exist !Dir[%isStep%]!\GetDirSize.vbs ( Del /F /Q !Dir[%isStep%]!\GetDirSize.vbs 1>nul 2>&1 )
if exist %TempSourceBackupDir%\GetDirSize.vbs ( Del /F /Q %TempSourceBackupDir%\GetDirSize.vbs 1>nul 2>&1 )
if exist !TempRoboCopDir[%isStep%]!\GetDirSize.vbs ( Del /F /Q !TempRoboCopDir[%isStep%]!\GetDirSize.vbs 1>nul 2>&1 )
if exist !TempOutputDir[%isStep%]!\GetDirSize.vbs ( Del /F /Q !TempOutputDir[%isStep%]!\GetDirSize.vbs 1>nul 2>&1 )
@timeout /t 1 >nul
if %isStep% LEQ 2 (
	if exist !Dir[%isStep%]!\GetDirSize.vbs (
		goto :Pack
	) else (
		goto :CreateVBSScripts
	)
)

:CreateVBSScripts
echo [92m " =================================== CREATE SCRIPT OBJECT, Step = %isStep% =================================== " [0m 
cd /D %TempSourceBackupDir%\
Echo WScript.Echo CreateObject("Scripting.FileSystemObject").GetFolder(WScript.Arguments(0)).Size>GetDirSize.vbs
cd /D !Dir[%isStep%]!\
Echo WScript.Echo CreateObject("Scripting.FileSystemObject").GetFolder(WScript.Arguments(0)).Size>GetDirSize.vbs
cd /d !TempRoboCopDir[%isStep%]!\
Echo WScript.Echo CreateObject("Scripting.FileSystemObject").GetFolder(WScript.Arguments(0)).Size>GetDirSize.vbs
@rem cd /D !TempOutputDir[%isStep%]!\
@rem Echo WScript.Echo CreateObject("Scripting.FileSystemObject").GetFolder(WScript.Arguments(0)).Size>GetDirSize.vbs
@timeout /t 1 >nul

:RoboCopy
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
if %isStep% LEQ 2 (
	cd /D !Dir[%isStep%]!\
	if not %isStep% == 0 (
		ROBOCOPY "%TempSourceBackupDir%" "!TempRoboCopDir[%isStep%]!" %RCParams% /LOG:"!RCLogFile!" /XF !RC_ExcludeRecurseFileList[1]! /XD !RC_ExcludeDirList[%isStep%]! %RCFileDataFlags%
		if %isStep% == 1 ( rmdir /Q "%Dir[1]%\Comodo\IceDragon\" )
	)
)
if %isStep% GEQ 1 ( goto :Cleaning )
@timeout /t 3 >nul
:Pack
echo [92m " =================================== Pack, Step = %isStep%  =================================== " [0m 
if %isStep% LEQ 6 (
	cd /D !Dir[%isStep%]!\
	if not %isStep% == 0 (
		if %isStep% LEQ 2 (
			@rem ROBOCOPY "%TempSourceBackupDir%" "!TempRoboCopDir[%isStep%]!" %RCParams% /LOG:"!RCLogFile!" /XF !RC_ExcludeRecurseFileList[1]! /XD !RC_ExcludeDirList[%isStep%]! %RCFileDataFlags%
			@rem if %isStep% == 1 ( rmdir /Q "%Dir[1]%\Comodo\IceDragon\" )
			For /D %%A In ("!TempRoboCopDir[%isStep%]!\*") Do (
				if "!TempRoboCopDir[%isStep%]!\%%~nxA" == "%%A" (
					!7za! u -y -r !7zaKeyString! "!TempOutputDir[%isStep%]!\%%~nxA.7z" "%%A" -x@"!7z_ExcludeList[%isStep%]!" -xr@"!7z_ExcludeRecurseList[%isStep%]!"
				)
			)
			!7za! u -y -r !7zaKeyString! "!TempOutputDir[%isStep%]!\Microsoft\Credentials.7z" "!Dir[%isStep%]!\Microsoft\Credentials" '-xr@"!7z_ExcludeRecurseFiles!"'
			@rem !7za! u -y -r !7zaKeyString! "!TempOutputDir[2]!\Microsoft\Credentials.7z" "%Dir[2]%\Microsoft\Credentials" '-xr@"!7z_ExcludeRecurseFiles!"'
			!7za! u -y -r !7zaKeyString! "!TempOutputDir[2]!\Microsoft\Crypto.7z" "%Dir[2]%\Microsoft\Crypto" '-xr@"!7z_ExcludeRecurseFiles!"'
			!7za! u -y !7zaKeyString! "!TempOutputDir[%isStep%]!\!FileN[%isStep%]!.7z" @"!7z_List[%isStep%]!"
		)
	)
	else (
		cd /D !Dir[%isStep%]!\
		@rem Users\Public
		if %isStep% == 3 ( !7za! u -y !7zaKeyString! "!TempOutputDir[%isStep%]!\!FileN[%isStep%]!.7z" @"!7z_List[%isStep%]!" )
		if %isStep% GEQ 4 (
			@rem Program Files...
			!7za! u -y !7zaKeyString! "!TempOutputDir[5]!\CommonFiles_x86.7z" -w"%Temp%" @"%ListDir%\7z_CommonFiles_x86.txt"
			!7za! u -y !7zaKeyString! "!TempOutputDir[5]!\SkypeForDesktop_x86.7z" "Microsoft\Skype for Desktop\" -w"%Temp%"
			!7za! u -y !7zaKeyString! "!TempOutputDir[5]!\Steam.7z" -w"%Temp%" @"%ListDir%\7z_Steam.txt"
			if %isStep% LEQ 6 (
				For /D %%A In ("!Dir[%isStep%]!\*") Do (
					if "!Dir[%isStep%]!\%%~nxA" == "%%A" (
						!7za! u -y -r !7zaKeyString! "!TempOutputDir[%isStep%]!\%%~nxA.7z" "%%A" -x@"!7z_ExcludeList[%isStep%]!"
					)
				)
			)
		)
		if %isStep% == 0 (
			@rem LocalLow
			!7za! u -y -r !7zaKeyString! "!TempOutputDir[%isStep%]!\!FileN[%isStep%]!.7z" "!Dir[%isStep%]!\*" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles!"'
			@rem USERNAME
			cd /D %userprofile%\
			!7za! u -y !7zaKeyString! "%TempBackupDir%\Users\%USERNAME%\%USERNAME%.7z" @"!7z_List[%isStep%]!"
		)
	)
)
@timeout /t 1 >nul

if exist "!TempOutputDir[%isStep%]!\!FileN[%isStep%]!.7z" set /a isStep=!isStep!+1

echo -- isStep = %isStep%  -- !TempOutputDir[%isStep%]!\!FileN[%isStep%]!

@rem @timeout /t 360 >nul
goto :Switch

:Switch
@timeout /t 2 >nul
if %isStep% == 1 ( goto :ReCreate )
if %isStep% GEQ 3 ( goto :DeleteFilesFromArchives )
if %isStep% == 2 ( goto :RoboCopy )
rem 
:DeleteFilesFromArchives
echo [92m " =================================== Delete Files From Archives =================================== " [0m 
@rem ! Перед удалением файлов в архивах, переместить их в другую папку или задать фильтр на .7z
@timeout /t 2 >nul
For /d %%A In ("%TempBackupDir%\Users\*") Do (
	for /f "usebackq delims=;" %%B in (`dir /a:a /s /b "%%A"`) do (
		set TimeStamp=!TimeStamp!
		!7za! d -y "%%B" desktop.ini *.tmp *.dmp *.cookie *.log -r >>%LogsDir%\%TimeStamp%_%%~nxB.log
	)
)
if %isStep% LEQ 6 ( goto :Pack )

exit /b
@timeout /t 360 >

if %isStep% GEQ 7 ( goto :End )

rem 
:End
echo [92m " ========================================== End ========================================== " [0m 
@timeout /t 2 >nul
Del /F /Q !Dir[0]!\GetDirSize.vbs 1>nul 2>&1
Del /F /Q !Dir[1]!\GetDirSize.vbs 1>nul 2>&1
Del /F /Q !Dir[2]!\GetDirSize.vbs 1>nul 2>&1
Del /F /Q %TempSourceBackupDir%\GetDirSize.vbs 1>nul 2>&1
Del /F /Q %TempOutputDir[0]%\GetDirSize.vbs 1>nul 2>&1
Del /F /Q %TempOutputDir[1]%\GetDirSize.vbs 1>nul 2>&1
Del /F /Q %TempOutputDir[2]%\GetDirSize.vbs 1>nul 2>&1
Del /F /Q %TempRoboCopDir[0]%\GetDirSize.vbs 1>nul 2>&1
Del /F /Q %TempRoboCopDir[1]%\GetDirSize.vbs 1>nul 2>&1
Del /F /Q %TempRoboCopDir[2]%\GetDirSize.vbs 1>nul 2>&1
Del /F /Q %TempRoboCopDir[3]%\GetDirSize.vbs 1>nul 2>&1
Del /F /Q %TempRoboCopDir[4]%\GetDirSize.vbs 1>nul 2>&1
Del /F /Q %TempRoboCopDir[5]%\GetDirSize.vbs 1>nul 2>&1

@rem del /F /S /Q "%TempSourceBackupDir%\*"
if exist "%TempSourceBackupDir%" rmdir /S /Q "%TempSourceBackupDir%"
if exist "%TempOutputDir[0]%" rmdir /S /Q "%TempOutputDir[0]%\"
if exist "%TempOutputDir[1]%" rmdir /S /Q "%TempOutputDir[1]%\"
if exist "%TempOutputDir[2]%" rmdir /S /Q "%TempOutputDir[2]%\"
if exist "%TempOutputDir[3]%" rmdir /S /Q "%TempOutputDir[3]%\"
if exist "%TempOutputDir[4]%" rmdir /S /Q "%TempOutputDir[4]%\"
if exist "%TempOutputDir[5]%" rmdir /S /Q "%TempOutputDir[5]%\"
if exist "%TempOutputDir[6]%" rmdir /S /Q "%TempOutputDir[6]%\"
if exist "%TempRoboCopDir[0]%" rmdir /S /Q "%TempRoboCopDir[0]%\"
if exist "%TempRoboCopDir[1]%" rmdir /S /Q "%TempRoboCopDir[1]%\"
if exist "%TempRoboCopDir[2]%" rmdir /S /Q "%TempRoboCopDir[2]%\"
if exist "%TempRoboCopDir[3]%" rmdir /S /Q "%TempRoboCopDir[3]%\"
if exist "%TempRoboCopDir[4]%" rmdir /S /Q "%TempRoboCopDir[4]%\"
if exist "%TempRoboCopDir[5]%" rmdir /S /Q "%TempRoboCopDir[5]%\"
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

