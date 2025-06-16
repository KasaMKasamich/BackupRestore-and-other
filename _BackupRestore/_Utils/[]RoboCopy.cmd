@Rem [ Author: [ Бурлачков Василий Александрович) ] ]
@echo on
@rem setlocal enableextensions enabledelayedexpansion
setlocal EnableExtensions
setlocal EnableDelayedExpansion
@chcp 65001>nul
@rem chcp 1251 >nul
@rem chcp 1252 >nul
@rem chcp 866 >nul
@Title "RoboCopy"
@set Title="RoboCopy"
@rem Time
@set digit1=%time:~0,1%
@if "%digit1%"==" " (@set digit1=0)
@set BackUpTimeStamp01=!DATE:~-4!.!DATE:~3,2!.!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!
@set BackUpTimeStamp02=!DATE:~-4!.!DATE:~3,2!.!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@set TimeStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@set DateStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!
@set OnlyTimeStamp=!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@rem @echo d1 - %~d1
@rem @echo %~d1\%~n1
@rem Чтобы не редактировать скрипты в будущем, если путь до файлов изменится, ниже вычисление корневой папки скриптов.
@cd /D %~dp0
@cd /D ..\
@echo cd - %cd%
@set ScriptsRootPath=%cd%
@rem ================================================================================================================
@rem [============][============][============]
@set LogsDir=%ScriptsRootPath%\__Logs
@set ListDir=%ScriptsRootPath%\__Lists
@set TempDir1=%ScriptsRootPath%\_Temp
@set UtilsDir=%ScriptsRootPath%\_Utils
@rem [============][============][============]
@echo ScriptsRootPath - %ScriptsRootPath%
@cd /D %~dp0
@echo cd - %cd%
@rem [============][============][============]
@set SourceDirectoryes="%*"
@Echo [] SourceDirectoryes - %SourceDirectoryes%
@Rem === RoboCopy ===
@set RCLogFile=%LogsDir%\_ROBOCOPY\%DateTimeStamp%_ROBOCOPY.txt
@if not exist "%LogsDir%\_ROBOCOPY" mkdir "%LogsDir%\_ROBOCOPY"
@set RCParams=/S /ZB /R:3 /W:2 /SL /MT:8 /XA:sh
@set RCParams2=/S /ZB /R:3 /W:2 /SL /MT:8
@set RCParams3=/S /B /Z /R:3 /W:2 /SL /MT:8
@rem set RC_ExcludeDirList[1]="Yandex" "Vivox" "IceDragon" "Logs" "Recent" "Report*" "Temporary*" "*Crash*" "*Temp*" "*History*" "*Log*" "Application*" "Microsoft" "Diagnostics" "Packages" "Comms" "NVIDIA*" "Programs" "Publishers" "TempCheckUpdate" "fontconfig" "{*}" "*Folder" "e2eSoft" "speech" "TechSmith" "*Tile*" "Wondershare" "VirtualStore" "ConnectedDevicesPlatform"
@rem set RC_ExcludeDirList[2]="Flash Player" "AMS Software" "Anvsoft" "Macromedia" "Microsoft" "tor" "Recent" "Report*" "Temporary*" "*Crash*" "*Temp*" "*History*" "*Log*" "Programs" "Publishers" "{*}" "*Folder" "speech" "TechSmith" "NVIDIA*"
@rem set RC_ExcludeRecurseFileList[1]="IconCache*" "thumbcache*" "*.cookie" "*.log" "*.tmp" "*.dmp" "*.vbs" "*.7z"
@rem set RC_ExcludePF="Common Files" "internet explorer" "MSBuild" "NVIDIA*" "Reference Assemblies" "rempl" "TechSmith" "UmmyVideoDownloader" "Uninstall Information" "Unity*" "UNP" "VK" "Windows*" "WindowsPowerShell" "Yandex"
@rem set RC_ExcludePFx86="Bandicam" "BandiMPEG1" "Common Files" "e2eSoft" "Google\CrashReports" "Intel" "Internet Explorer" "InstallShield Installation Information" "Microsoft" "Microsoft SDKs" "Microsoft Visual Studio" "Microsoft Web Tools" "Microsoft.NET" "MSBuild" "MSI Afterburner" "NVIDIA*" "Reference Assemblies" "RivaTuner Statistics Server" "Uninstall Information" "VulkanRT" "Windows*" "WindowsPowerShell" "Yandex"
@set RCFileDataFlags=/DCOPY:DAT
@set RCFileDataFlags2=/COPYALL /DCOPY:DAT
@rem 
set sDriveLetterF=
set sDriveLetterH=
set sDriveLetterI=
set sCmd0101=wmic volume where (label="Archive") get DriveLetter
set sCmd0201=wmic volume where (label="Games") get DriveLetter
set sCmd0301=wmic volume where (label="UserData") get DriveLetter
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
@rem ============================================================================================================================================
@echo %_Normal_Yellow%" =================================== %_Normal_Green%End init%_Normal_Yellow% =================================== "%_col_off%
@rem ============================================================================================================================================
@rem call %UtilsDir%\[]-Colors.cmd
@rem @echo %_Normal_Yellow%" =================================== %_Normal_Green% WMIC %_Normal_Yellow% =================================== "%_col_off%
@rem wmic /OUTPUT:%ParseDeviceIDsLogC% volume where (label="Sys") get DriveLetter
@rem ============================================================================
@if exist "%Temp%\tmpDriveLetterF.txt" ( del /f /q "%Temp%\tmpDriveLetterF.txt" )
@if exist "%Temp%\tmpDriveLetterH.txt" ( del /f /q "%Temp%\tmpDriveLetterH.txt" )
@if exist "%Temp%\tmpDriveLetterI.txt" ( del /f /q "%Temp%\tmpDriveLetterI.txt" )
@rem ============================================================================
call %sCmd0101%>%Temp%\tmpDriveLetterF.txt
call %sCmd0201%>%Temp%\tmpDriveLetterH.txt
call %sCmd0301%>%Temp%\tmpDriveLetterI.txt
@rem ============================================================================
wmic exit
@rem 
powershell -Command "(Get-Content %Temp%\tmpDriveLetterF.txt)[1].Trim() | Add-Content -Path %Temp%\tmpfDriveLetterF.txt"
powershell -Command "(Get-Content %Temp%\tmpDriveLetterH.txt)[1].Trim() | Add-Content -Path %Temp%\tmpfDriveLetterH.txt"
powershell -Command "(Get-Content %Temp%\tmpDriveLetterI.txt)[1].Trim() | Add-Content -Path %Temp%\tmpfDriveLetterI.txt"
@rem 
@FOR /F "usebackq delims=" %%F IN ("%Temp%\tmpfDriveLetterF.txt") DO ( @if not "%%~F" == "" (@set "sDriveLetterF=%%~F") )
@FOR /F "usebackq delims=" %%H IN ("%Temp%\tmpfDriveLetterH.txt") DO ( @if not "%%~H" == "" (@set "sDriveLetterH=%%~H") )
@FOR /F "usebackq delims=" %%I IN ("%Temp%\tmpfDriveLetterI.txt") DO ( @if not "%%~I" == "" (@set "sDriveLetterI=%%~I") )
@rem 
@if exist "%Temp%\tmpDriveLetterF.txt" ( del /f /q "%Temp%\tmpDriveLetterF.txt" )
@if exist "%Temp%\tmpDriveLetterH.txt" ( del /f /q "%Temp%\tmpDriveLetterH.txt" )
@if exist "%Temp%\tmpDriveLetterI.txt" ( del /f /q "%Temp%\tmpDriveLetterI.txt" )
@rem 
@if exist "%Temp%\tmpfDriveLetterF.txt" ( del /f /q "%Temp%\tmpfDriveLetterF.txt" )
@if exist "%Temp%\tmpfDriveLetterH.txt" ( del /f /q "%Temp%\tmpfDriveLetterH.txt" )
@if exist "%Temp%\tmpfDriveLetterI.txt" ( del /f /q "%Temp%\tmpfDriveLetterI.txt" )
@rem 
@if exist "%Temp%\GetFreeDiskSpaceF.js" ( del /f /q "%Temp%\GetFreeDiskSpaceF.js" )
@if exist "%Temp%\GetFreeDiskSpaceH.js" ( del /f /q "%Temp%\GetFreeDiskSpaceH.js" )
@if exist "%Temp%\GetFreeDiskSpaceI.js" ( del /f /q "%Temp%\GetFreeDiskSpaceI.js" )
@rem powershell -Command "(Clear-Content %Temp%\GetFreeDiskSpace.txt)"

:BuildJS
@rem =================================================================================================================
@Echo var FSO = WScript.CreateObject("Scripting.FileSystemObject");>>%Temp%\GetFreeDiskSpaceF.js
@Echo var WSHShell = WScript.CreateObject("WScript.Shell");>>%Temp%\GetFreeDiskSpaceF.js
@Echo Drive="%sDriveLetterF%";>>%Temp%\GetFreeDiskSpaceF.js
@Echo var D = FSO.GetDrive(Drive);>>%Temp%\GetFreeDiskSpaceF.js
@Echo TotalGb = D.FreeSpace/1024/1024/1024;>>%Temp%\GetFreeDiskSpaceF.js
@Echo Kb = D.FreeSpace/1024;>>%Temp%\GetFreeDiskSpaceF.js
@Echo FloatGb = TotalGb.toFixed(2);>>%Temp%\GetFreeDiskSpaceF.js
@Echo s=" [] 1 - "+Drive+" Free Disk Space: "+FloatGb+" Gb "+"[ "+Kb+" Kb "+"]"+"\r\n";>>%Temp%\GetFreeDiskSpaceF.js
@Echo WScript.Echo(s);>>%Temp%\GetFreeDiskSpaceF.js
@rem =================================================================================================================
@Echo var FSO = WScript.CreateObject("Scripting.FileSystemObject");>>%Temp%\GetFreeDiskSpaceH.js
@Echo var WSHShell = WScript.CreateObject("WScript.Shell");>>%Temp%\GetFreeDiskSpaceH.js
@Echo Drive="%sDriveLetterH%";>>%Temp%\GetFreeDiskSpaceH.js
@Echo var D = FSO.GetDrive(Drive);>>%Temp%\GetFreeDiskSpaceH.js
@Echo TotalGb = D.FreeSpace/1024/1024/1024;>>%Temp%\GetFreeDiskSpaceH.js
@Echo Kb = D.FreeSpace/1024;>>%Temp%\GetFreeDiskSpaceH.js
@Echo FloatGb = TotalGb.toFixed(2);>>%Temp%\GetFreeDiskSpaceH.js
@Echo s=" [] 2 - "+Drive+" Free Disk Space: "+FloatGb+" Gb "+"[ "+Kb+" Kb "+"]"+"\r\n";>>%Temp%\GetFreeDiskSpaceH.js
@Echo WScript.Echo(s);>>%Temp%\GetFreeDiskSpaceH.js
@rem =================================================================================================================
@Echo var FSO = WScript.CreateObject("Scripting.FileSystemObject");>>%Temp%\GetFreeDiskSpaceI.js
@Echo var WSHShell = WScript.CreateObject("WScript.Shell");>>%Temp%\GetFreeDiskSpaceI.js
@Echo Drive="%sDriveLetterI%";>>%Temp%\GetFreeDiskSpaceI.js
@Echo var D = FSO.GetDrive(Drive);>>%Temp%\GetFreeDiskSpaceI.js
@Echo TotalGb = D.FreeSpace/1024/1024/1024;>>%Temp%\GetFreeDiskSpaceI.js
@Echo Kb = D.FreeSpace/1024;>>%Temp%\GetFreeDiskSpaceI.js
@Echo FloatGb = TotalGb.toFixed(2);>>%Temp%\GetFreeDiskSpaceI.js
@Echo s=" [] 3 - "+Drive+" Free Disk Space: "+FloatGb+" Gb "+"[ "+Kb+" Kb "+"]"+"\r\n";>>%Temp%\GetFreeDiskSpaceI.js
@Echo WScript.Echo(s);>>%Temp%\GetFreeDiskSpaceI.js
@rem =================================================================================================================
@goto :Choice

@rem Choice =====================================================================
:Choice
@Echo  На какой диск копировать:
@rem 
@Echo.
@if exist "%sDriveLetterF%\" (
	@cscript //Nologo %Temp%\GetFreeDiskSpaceF.js
)
@rem 
@if exist "%sDriveLetterH%\" (
	@cscript //Nologo %Temp%\GetFreeDiskSpaceH.js
)
@rem 
@if exist "%sDriveLetterI%\" (
	@cscript //Nologo %Temp%\GetFreeDiskSpaceI.js
)
@rem 
echo You chose %1
@rem 
echo You chose %~nx1
@rem @Pause

set "psCommandSourceFolder="(new-object -COM 'Shell.Application').BrowseForFolder(0,'Please choose a source folder.',0,0).self.path""
set "psCommandDestFolder="(new-object -COM 'Shell.Application').BrowseForFolder(0,'Please choose a destination folder.',0,0).self.path""

for /f "usebackq delims=" %%I in (`powershell %psCommandSourceFolder%`) do set "SourceFolder=%%I"

if /i "%SourceFolder%"=="" Exit

for /f "usebackq delims=" %%I in (`powershell %psCommandDestFolder%`) do set "DestFolder=%%I"

@rem setlocal enabledelayedexpansion
@rem 
echo You chose !SourceFolder!
@rem 
echo You chose !DestFolder!
@rem @Pause

@rem if /i "%1"=="" (
@rem 	ROBOCOPY "!SourceFolder!" "!DestFolder!\_RoboCopy (%BackUpTimeStamp02%)" %RCParams3% /LOG:"!RCLogFile!" %RCFileDataFlags%
@rem 	@goto :EOF
@rem ) else (
@rem 	@goto :ROBOCOPYCoiseNotEmpty
@rem )

:ROBOCOPYCoiseNotEmpty
ROBOCOPY "!SourceFolder!" "!DestFolder!\%~nx1" %RCParams3% /LOG:"!RCLogFile!" %RCFileDataFlags%
@rem @pause

:EOF
@if exist "%ListDir%\_TempFilesList.txt" ( del /f /q "%ListDir%\_TempFilesList.txt" )
@rem 
@if exist "%ListDir%\_TempDirList.txt" ( del /f /q "%ListDir%\_TempDirList.txt" )
@if exist "%ListDir%\_TempDirNamesList.txt" ( del /f /q "%ListDir%\_TempDirNamesList.txt" )
@rem 
@if exist "%Temp%\tmpDriveLetterF.txt" ( del /f /q "%Temp%\tmpDriveLetterF.txt" )
@if exist "%Temp%\tmpDriveLetterH.txt" ( del /f /q "%Temp%\tmpDriveLetterH.txt" )
@if exist "%Temp%\tmpDriveLetterI.txt" ( del /f /q "%Temp%\tmpDriveLetterI.txt" )
@rem 
@if exist "%Temp%\tmpfDriveLetterF.txt" ( del /f /q "%Temp%\tmpfDriveLetterF.txt" )
@if exist "%Temp%\tmpfDriveLetterH.txt" ( del /f /q "%Temp%\tmpfDriveLetterH.txt" )
@if exist "%Temp%\tmpfDriveLetterI.txt" ( del /f /q "%Temp%\tmpfDriveLetterI.txt" )
@rem 
@if exist "%Temp%\GetFreeDiskSpaceF.js" ( del /f /q "%Temp%\GetFreeDiskSpaceF.js" )
@if exist "%Temp%\GetFreeDiskSpaceH.js" ( del /f /q "%Temp%\GetFreeDiskSpaceH.js" )
@if exist "%Temp%\GetFreeDiskSpaceI.js" ( del /f /q "%Temp%\GetFreeDiskSpaceI.js" )
exit
@rem @pause
@rem @timeout /t 1 >nul

@rem ROBOCOPY "Источник" "Назначение" /S /B /R:3 /W:2 /SL /MT:8 /DCOPY:DAT
@rem 
@rem "%~dp0\..\..\../workshop\content\440900
@rem "%~I" - из переменной %I удаляются обрамляющие кавычки (")
@rem "%~f0" - переменная %I расширяется до полного имени файла
@rem "%~d0" - из переменной %I выделяется только имя диска
@rem "%~p0" - из переменной %I выделяется только путь к файлу
@rem "%~n0" - из переменной %I выделяется только имя файла
@rem "%~x0" - из переменной %I выделяется расширение имени файла
@rem "%~s0" - полученный путь содержит только короткие имена
@rem "%~a0" - переменная %I расширяется до атрибутов файла
@rem "%~t0" - "переменная %I расширяется до даты /времени файла
@rem "%~z0" - "переменная %I расширяется до размера файла
@rem 
@rem При объединении нескольких операторов можно получить следующие результаты:
@rem 
@rem полученный путь содержит только короткие имена(сокращённые): "%~dps0"
@rem переменная расширяется до полного имени файла(путь и имя файла с расширением): "%~dpf0"
@rem  "~ftzaI - переменная I раскрывается в строку, подобную выдаваемой командой DIR"
