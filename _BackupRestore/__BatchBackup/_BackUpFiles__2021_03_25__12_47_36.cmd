@Title "Test Backup"
@rem C:\_BackupRestore\_BackUpFiles.cmd
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
set DateStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!
set OnlyTimeStamp=!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@rem 
echo %StartTimeStamp%
@rem  bool
set isStep=0
@rem  int
@rem set /A KB=1*1024
@rem set /A MB=400*1048576
@rem  RoboCopy
set RCParams=/S /ZB /R:3 /W:2 /SL /MT:8 /XA:sh
@rem set RCParams2=/S /ZB /R:3 /W:2 /SL /MT:8
@rem set RC_ExcludeDirList[1]="Yandex" "Vivox" "IceDragon" "Logs" "Recent" "Report*" "Temporary*" "*Crash*" "*Temp*" "*History*" "*Log*" "Application*" "Microsoft" "Diagnostics" "Packages" "Comms" "NVIDIA*" "Programs" "Publishers" "TempCheckUpdate" "fontconfig" "{*}" "*Folder" "e2eSoft" "speech" "TechSmith" "*Tile*" "Wondershare" "VirtualStore" "ConnectedDevicesPlatform"
@rem set RC_ExcludeDirList[2]="Flash Player" "AMS Software" "Anvsoft" "Macromedia" "Microsoft" "tor" "Recent" "Report*" "Temporary*" "*Crash*" "*Temp*" "*History*" "*Log*" "Programs" "Publishers" "{*}" "*Folder" "speech" "TechSmith" "NVIDIA*"
@rem set RC_ExcludeRecurseFileList[1]="IconCache*" "thumbcache*" "*.cookie" "*.log" "*.tmp" "*.dmp" "*.vbs" "*.7z"
@rem set RC_ExcludePF="Common Files" "internet explorer" "MSBuild" "NVIDIA*" "Reference Assemblies" "rempl" "TechSmith" "UmmyVideoDownloader" "Uninstall Information" "Unity*" "UNP" "VK" "Windows*" "WindowsPowerShell" "Yandex"
@rem set RC_ExcludePFx86="Bandicam" "BandiMPEG1" "Common Files" "e2eSoft" "Google\CrashReports" "Intel" "Internet Explorer" "InstallShield Installation Information" "Microsoft" "Microsoft SDKs" "Microsoft Visual Studio" "Microsoft Web Tools" "Microsoft.NET" "MSBuild" "MSI Afterburner" "NVIDIA*" "Reference Assemblies" "RivaTuner Statistics Server" "Uninstall Information" "VulkanRT" "Windows*" "WindowsPowerShell" "Yandex"
set RCFileDataFlags=/COPYALL /DCOPY:DAT

@rem [2020_02_29__16_43_33] [добавить - C:\ProgramData\Microsoft\Windows\Start Menu\Programs]

@rem  7za
set 7zaKeyString=-ssw -m0=LZMA2:d128m:fb256 -myx9 -mmt=8 -ms=off
set 7zaKeyString2=-ssw -mmt=8 -ms=off
set 7zaKeyString3=-ssw -mmt=8
set 7za=%~dp0\7z\1900\x64\7za.exe

set FileName=Backup

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
set TempBackupDir=C:\_BackUp

set TempOutputDir[0]=%TempBackupDir%\Users\%USERNAME%\AppData\LocalLow
set TempOutputDir[1]=%TempBackupDir%\Users\%USERNAME%\AppData\Local
set TempOutputDir[2]=%TempBackupDir%\Users\%USERNAME%\AppData\Roaming
set TempOutputDir[3]=%TempBackupDir%\%UsersDir[0]%
set TempOutputDir[4]=%TempBackupDir%\Program Files
set TempOutputDir[5]=%TempBackupDir%\Program Files (x86)
set TempOutputDir[6]=%TempBackupDir%\ProgramData

set OutputDir[0]=%BackupsDir%\%TimeStamp%_%FileName%\Users\%USERNAME%\AppData\LocalLow
set OutputDir[1]=%BackupsDir%\%TimeStamp%_%FileName%\Users\%USERNAME%\AppData\Local
set OutputDir[2]=%BackupsDir%\%TimeStamp%_%FileName%\Users\%USERNAME%\AppData\Roaming
set OutputDir[3]=%BackupsDir%\%TimeStamp%_%FileName%\%UsersDir[0]%
set OutputDir[4]=%BackupsDir%\%TimeStamp%_%FileName%\Program Files
set OutputDir[5]=%BackupsDir%\%TimeStamp%_%FileName%\Program Files (x86)
set OutputDir[6]=%BackupsDir%\%TimeStamp%_%FileName%\ProgramData

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

set LogFile=%LogsDir%\%TimeStamp%_%FileName%.log
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

set 7z_ExcludeRecurseFiles[1]=%ListDir%\ExcludeRecurse\7z_R_ExcludeFiles.txt

echo [92m " =================================== End init =================================== " [0m 
echo !TimeStamp!>>%LogFile%

rem  Self Backup
copy /v /y %0 %~dp0__BatchBackup\%~n0__%TimeStamp%%~x0

@timeout /t 1 >nul

@rem =================================================================================================================================
@rem =================================================================================================================================
@rem =================================================================================================================================

echo [92m " =================================== ReCreate =================================== " [0m 
rem  CОЗДАНИЕ ВРЕМЕННОГО КАТАЛОГА ДЛЯ БЕКАПА
@rem ==============================================================
@rem C:\_BR\_Deleted\						- %DeletedDir%
@rem ==============================================================
@rem C:\_BR\Program Files					- %TempOutputDir[4]%
@rem C:\_BR\Program Files (x86)				- %TempOutputDir[5]%
@rem C:\_BR\ProgramData						- %TempOutputDir[6]%
@rem ==============================================================
@rem 
if not exist "%BackupsDir%\%TimeStamp%_%FileName%" mkdir "%BackupsDir%\%TimeStamp%_%FileName%\"
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


if not exist "%OutputDir[0]%" mkdir "%OutputDir[0]%"
if not exist "%OutputDir[1]%" mkdir "%OutputDir[1]%"
if not exist "%OutputDir[2]%" mkdir "%OutputDir[2]%"
if not exist "%OutputDir[3]%" mkdir "%OutputDir[3]%"
if not exist "%OutputDir[4]%" mkdir "%OutputDir[4]%"
if not exist "%OutputDir[5]%" mkdir "%OutputDir[5]%"
if not exist "%OutputDir[6]%" mkdir "%OutputDir[6]%"
if not exist "%BackupsDir%\Users\%USERNAME%\AppData\Local" mkdir "%BackupsDir%\Users\%USERNAME%\AppData\Local"
if not exist "%BackupsDir%\Users\%USERNAME%\AppData\LocalLow" mkdir "%BackupsDir%\Users\%USERNAME%\AppData\LocalLow"
if not exist "%BackupsDir%\Users\%USERNAME%\AppData\Roaming" mkdir "%BackupsDir%\Users\%USERNAME%\AppData\Roaming"

@timeout /t 1 >nul

echo [92m " =================================== Pack  =================================== " [0m 

@rem Program Files
cd /D !Dir[4]!\

!7za! u !7zaKeyString2! "!OutputDir[4]!\7-Zip.7z" "!Dir[4]!\7-Zip\" -w"%Temp%"
!7za! u !7zaKeyString2! "!OutputDir[4]!\Google.7z" "!Dir[4]!\Google\" -w"%Temp%"
!7za! u !7zaKeyString2! "!OutputDir[4]!\Mem Reduct.7z" "!Dir[4]!\Mem Reduct\" -w"%Temp%"
!7za! u !7zaKeyString2! "!OutputDir[4]!\Opera.7z" "!Dir[4]!\Opera\" -w"%Temp%"
!7za! u !7zaKeyString2! "!OutputDir[4]!\simplewall.7z" "!Dir[4]!\simplewall\" -w"%Temp%"

pause

@rem Program Files (x86)
cd /D !Dir[5]!\

!7za! u !7zaKeyString2! "!TempOutputDir[5]!\SkypeForDesktop_x86.7z" "Microsoft\Skype for Desktop\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\Steam.7z" -w"%Temp%" @"%ListDir%\7z_Steam.txt"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\Google.7z" -w"%Temp%" @"%ListDir%\7z_Google_x86.txt"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\Opera.7z" "!Dir[5]!\Opera\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\TeamViewer.7z" "!Dir[5]!\TeamViewer\" -w"%Temp%"

@rem Users\Public
!7za! u !7zaKeyString2! "!TempOutputDir[3]!\!FileN[3]!.7z" -w"%Temp%" @"!7z_List[3]!"

@rem LocalLow
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[0]!\!FileN[0]!.7z" "!Dir[0]!\*" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles!"'

@rem AppData\Local
cd /D !Dir[1]!\

!7za! u -r0 !7zaKeyString2! "!TempOutputDir[1]!\4A Games.7z" "4A Games" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[1]!\ConanSandbox.7z" "ConanSandbox" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[1]!\FalloutNV.7z" "FalloutNV" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[1]!\FOMM.7z" "FOMM" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[1]!\Google.7z" "Google" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[1]!\GRAW2.7z" "GRAW2" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[1]!\LOOT.7z" "LOOT" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[1]!\Opera Software.7z" "Opera Software" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[1]!\Skype.7z" "Skype" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[1]!\SkypePlugin.7z" "SkypePlugin" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[1]!\Skyrim.7z" "Skyrim" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[1]!\Skyrim Special Edition.7z" "Skyrim Special Edition" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[1]!\SkyrimMTO.7z" "SkyrimMTO" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[1]!\Stardock.7z" "Stardock" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[1]!\Steam.7z" "Steam" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[1]!\TeamViewer.7z" "TeamViewer" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[1]!\Viber.7z" "Viber" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[1]!\Viber Media S.à r.l.7z" "Viber Media S.à r.l" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'

@rem AppData\Roaming
cd /D !Dir[2]!\
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[2]!\Azureus.7z" "Azureus" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[2]!\Microsoft-Skype for Desktop.7z" "Microsoft\Skype for Desktop" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[2]!\OpenOffice.7z" "OpenOffice" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[2]!\Opera.7z" "Opera" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[2]!\Opera Software.7z" "Opera Software" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[2]!\Skype.7z" "Skype" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[2]!\Stardock.7z" "Stardock" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[2]!\TeamViewer.7z" "TeamViewer" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[2]!\tor.7z" "tor" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[2]!\UnityHub.7z" "UnityHub" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'
!7za! u -r0 !7zaKeyString2! "!TempOutputDir[2]!\ViberPC.7z" "ViberPC" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[1]!"'

:End
echo [92m " ========================================== End ========================================== " [0m 
@timeout /t 2 >nul

ROBOCOPY "%TempBackupDir%\Users" "%BackupsDir%\%TimeStamp%_%FileName%\Users" %RCParams% /MIR %RCFileDataFlags%
move /y "%TempOutputDir[4]%" "%BackupsDir%\%TimeStamp%_%FileName%\"
move /y "%TempOutputDir[5]%" "%BackupsDir%\%TimeStamp%_%FileName%\"
move /y "%TempOutputDir[6]%" "%BackupsDir%\%TimeStamp%_%FileName%\"

pause


move /y "%TempBackupDir%\Users" "%BackupsDir%\%TimeStamp%_%FileName%\"
move /y "%TempOutputDir[4]%" "%BackupsDir%\%TimeStamp%_%FileName%\"
move /y "%TempOutputDir[5]%" "%BackupsDir%\%TimeStamp%_%FileName%\"
move /y "%TempOutputDir[6]%" "%BackupsDir%\%TimeStamp%_%FileName%\"

pause

