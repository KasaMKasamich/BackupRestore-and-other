rem Test Full Backup
@rem F:\_BackupRestore\TestUpdateBackup.cmd
@echo on
Title "Test Full Backup"
setlocal enableextensions
setlocal enabledelayedexpansion
@rem chcp 1251 >nul
@rem 
chcp 1252 >nul
@rem chcp 866 >nul
rem  Time
set digit1=%time:~0,1%
if "%digit1%"==" " (set digit1=0)
set StartTimeStamp=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%digit1%%TIME:~1,1%_%TIME:~3,2%_%TIME:~6,2%
set TimeStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
rem  bool
set isStep=0
rem  int
rem  RoboCopy
set RCParams=/S /ZB /R:3 /W:2 /SL /MT:8 /XA:sh /XN
set RCParams2=/S /ZB /R:3 /W:2 /SL /MT:8 /XO
set RC_ExcludeDirList[1]="Yandex" "Vivox" "IceDragon" "Logs" "Recent" "Report*" "Temporary*" "*Crash*" "*Temp*" "*History*" "*Log*" "Application*" "Microsoft" "Diagnostics" "Packages" "Comms" "NVIDIA*" "Programs" "Publishers" "TempCheckUpdate" "fontconfig" "{*}" "*Folder" "e2eSoft" "speech" "TechSmith" "*Tile*" "Wondershare" "VirtualStore" "ConnectedDevicesPlatform"
set RC_ExcludeDirList[2]="Flash Player" "AMS Software" "Anvsoft" "Macromedia" "Microsoft" "tor" "Recent" "Report*" "Temporary*" "*Crash*" "*Temp*" "*History*" "*Log*" "Programs" "Publishers" "{*}" "*Folder" "speech" "TechSmith" "NVIDIA*"
set RC_ExcludeRecurseFileList="IconCache*" "thumbcache*" "*.cookie" "*.log" "*.tmp" "*.dmp" "*.vbs" "*.7z"
@rem set RC_ExcludeRecurseFileList[1]="IconCache*" "thumbcache*" "*.cookie" "*.log" "*.tmp" "*.dmp" "*.vbs" "*.7z"
@rem set RC_ExcludeRecurseFileList[2]="IconCache*" "thumbcache*" "*.cookie" "*.log" "*.tmp" "*.dmp" "*.vbs" "*.7z"
@rem set RCYandexExcludeDirs="*Crash*" "*Temp*" "*Logs*" "*Report*" "BrowserMetrics" "Safe Browsing" "Safe Browsing Cookies" "CrashpadMetrics-active.pma" "*History*" "*Log*" "Application*" "Microsoft" "Diagnostics" "Packages" "Comms" "NVIDIA*" "Programs" "Publishers" "TempCheckUpdate" "fontconfig" "{*}" "*Folder" "e2eSoft" "speech" "TechSmith" "*Tile*" "Wondershare" "VirtualStore" "ConnectedDevicesPlatform"
@rem set RCYandexExcludeFile="*.cookie" "*.log" "*.tmp" "*.dmp" "*.vbs"
set RC_ExcludePF="Common Files" "internet explorer" "MSBuild" "NVIDIA*" "Reference Assemblies" "rempl" "TechSmith" "UmmyVideoDownloader" "Uninstall Information" "Unity*" "UNP" "VK" "Windows*" "WindowsPowerShell" "Yandex"
set RC_ExcludePFx86="Bandicam" "BandiMPEG1" "Common Files" "e2eSoft" "Google\CrashReports" "Intel" "Internet Explorer" "InstallShield Installation Information" "Microsoft" "Microsoft SDKs" "Microsoft Visual Studio" "Microsoft Web Tools" "Microsoft.NET" "MSBuild" "MSI Afterburner" "NVIDIA*" "Reference Assemblies" "RivaTuner Statistics Server" "Uninstall Information" "VulkanRT" "Windows*" "WindowsPowerShell" "Yandex"
set RCFileDataFlags=/COPYALL /DCOPY:DAT
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

set LogsDir=%~dp0\__Logs
set ListDir=%~dp0\__Lists

set FileName=TestUpdateBackup
set LogFile=%LogsDir%\%TimeStamp%_%FileName%.log
set RCLogFile=%LogsDir%\!TimeStamp!_%FileName%.txt

set TempRoboCopDir=C:\_BR\_RoboTemp

echo [92m " =================================== End init =================================== " [0m 
echo !TimeStamp!>>%LogFile%

rem  Self Backup
copy /v /y %0 %~dp0__BatchBackup\%~n0__%TimeStamp%%~x0

@rem if %isStep% == 0 ( cd /D !Dir[1]!\ )

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
rem >> ===================================
	if %isStep% == 2 (
		echo !DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!>>%LogFile%
		goto :stop
	)
	set /a isStep=!isStep!+1
	echo [92m " =================================== isStep = %isStep% =================================== " [0m 
	if %isStep% LEQ 2 (
		if not %isStep% == 0 (
			ROBOCOPY "!TempRoboCopDir!\2" "!TempRoboCopDir!\1" %RCParams% /LOG:"!RCLogFile!" /XF !RC_ExcludeRecurseFileList! /XD !RC_ExcludeDirList[%isStep%]! %RCFileDataFlags%
		)
	)
	@timeout /t 3 >nul
	goto :Sandbox
rem << ===================================
)
@timeout /t 3 >nul
echo [92m " =================================== Sandbox Border =================================== " [0m 
if %DM% == 1 ( goto :stop )
@rem =================================================================================================================================
@rem =================================================================================================================================
@rem =================================================================================================================================

if %isStep% LEQ 2 (
	cd /D !Dir[%isStep%]!\
	if not %isStep% == 0 (
		ROBOCOPY "!TempRoboCopDir[%isStep%]!\2" "!TempRoboCopDir[%isStep%]!\1" %RCParams% /LOG:"!RCLogFile!" /XF !RC_ExcludeRecurseFileList! /XD !RC_ExcludeDirList[%isStep%]! %RCFileDataFlags%
@rem		if %isStep% == 1 ( rmdir /Q "%Dir[1]%\Comodo\IceDragon\" )
	)
)




endlocal

:stop
echo [92m " =================================== Stop =================================== " [0m 
if %isCLS% == 1 ( cls )
exit /b
exit /b
@rem @timeout /t 360 >nul
