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
@rem set RCParams=/S /ZB /R:3 /W:2 /SL /MT:8 /XA:sh
@rem set RCParams2=/S /ZB /R:3 /W:2 /SL /MT:8
@rem set RC_ExcludeDirList[1]="Yandex" "Vivox" "IceDragon" "Logs" "Recent" "Report*" "Temporary*" "*Crash*" "*Temp*" "*History*" "*Log*" "Application*" "Microsoft" "Diagnostics" "Packages" "Comms" "NVIDIA*" "Programs" "Publishers" "TempCheckUpdate" "fontconfig" "{*}" "*Folder" "e2eSoft" "speech" "TechSmith" "*Tile*" "Wondershare" "VirtualStore" "ConnectedDevicesPlatform"
@rem set RC_ExcludeDirList[2]="Flash Player" "AMS Software" "Anvsoft" "Macromedia" "Microsoft" "tor" "Recent" "Report*" "Temporary*" "*Crash*" "*Temp*" "*History*" "*Log*" "Programs" "Publishers" "{*}" "*Folder" "speech" "TechSmith" "NVIDIA*"
@rem set RC_ExcludeRecurseFileList[1]="IconCache*" "thumbcache*" "*.cookie" "*.log" "*.tmp" "*.dmp" "*.vbs" "*.7z"
@rem set RC_ExcludePF="Common Files" "internet explorer" "MSBuild" "NVIDIA*" "Reference Assemblies" "rempl" "TechSmith" "UmmyVideoDownloader" "Uninstall Information" "Unity*" "UNP" "VK" "Windows*" "WindowsPowerShell" "Yandex"
@rem set RC_ExcludePFx86="Bandicam" "BandiMPEG1" "Common Files" "e2eSoft" "Google\CrashReports" "Intel" "Internet Explorer" "InstallShield Installation Information" "Microsoft" "Microsoft SDKs" "Microsoft Visual Studio" "Microsoft Web Tools" "Microsoft.NET" "MSBuild" "MSI Afterburner" "NVIDIA*" "Reference Assemblies" "RivaTuner Statistics Server" "Uninstall Information" "VulkanRT" "Windows*" "WindowsPowerShell" "Yandex"
@rem set RCFileDataFlags=/COPYALL /DCOPY:DAT

@rem [2020_02_29__16_43_33] [добавить - C:\ProgramData\Microsoft\Windows\Start Menu\Programs]

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
set TempBackupDir=C:\_BackUp

set TempOutputDir[0]=%TempBackupDir%\Users\%USERNAME%\AppData\LocalLow
set TempOutputDir[1]=%TempBackupDir%\Users\%USERNAME%\AppData\Local
set TempOutputDir[2]=%TempBackupDir%\Users\%USERNAME%\AppData\Roaming
set TempOutputDir[3]=%TempBackupDir%\%UsersDir[0]%
set TempOutputDir[4]=C:\_BackUp\Program Files
set TempOutputDir[5]=C:\_BackUp\Program Files (x86)
set TempOutputDir[6]=C:\_BackUp\ProgramData

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

set FileName=Backup
set LogFile=%LogsDir%\%TimeStamp%_%FileName%.log
rem  File Lists

set 7z_ListCommonFiles[4]=%ListDir%\7z_CommonFiles.txt
set 7z_ListCommonFiles[5]=%ListDir%\7z_CommonFiles_x86.txt

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

echo [92m " =================================== Pack  =================================== " [0m 
cd /D !Dir[4]!\

@rem Program Files
!7za! u !7zaKeyString2! "!TempOutputDir[4]!\7-Zip.7z" "!Dir[4]!\7-Zip\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[4]!\Common Files.7z" "!Dir[4]!\Common Files\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[4]!\Google.7z" "!Dir[4]!\Google\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[4]!\Mem Reduct.7z" "!Dir[4]!\Mem Reduct\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[4]!\Mozilla Firefox.7z" "!Dir[4]!\Mozilla Firefox\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[4]!\Opera.7z" "!Dir[4]!\Opera\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[4]!\simplewall.7z" "!Dir[4]!\simplewall\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[4]!\Vuze.7z" "!Dir[4]!\Vuze\" -w"%Temp%"

@rem Program Files (x86)
cd /D !Dir[5]!\

!7za! u !7zaKeyString2! "!TempOutputDir[5]!\SkypeForDesktop_x86.7z" "Microsoft\Skype for Desktop\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\Steam.7z" -w"%Temp%" @"%ListDir%\7z_Steam.txt"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\Google.7z" -w"%Temp%" @"%ListDir%\7z_Google_x86.txt"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\Battle.net.7z" "!Dir[5]!\Battle.net\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\Common Files.7z" "!Dir[5]!\Common Files\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\Epic Games.7z" "!Dir[5]!\Epic Games\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\FFDec.7z" "!Dir[5]!\FFDec\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\GECK Script Editor.7z" "!Dir[5]!\GECK Script Editor\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\GeMM.7z" "!Dir[5]!\GeMM\" -w"%Temp%"
@rem !7za! u !7zaKeyString2! "!TempOutputDir[5]!\Google.7z" "!Dir[5]!\Google\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\LOOT.7z" "!Dir[5]!\LOOT\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\Mozilla Firefox.7z" "!Dir[5]!\Mozilla Firefox\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\NCH Software.7z" "!Dir[5]!\NCH Software\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\NetSarang.7z" "!Dir[5]!\NetSarang\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\obs-studio.7z" "!Dir[5]!\obs-studio\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\Opera.7z" "!Dir[5]!\Opera\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\TeamViewer.7z" "!Dir[5]!\TeamViewer\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\Ubisoft.7z" "!Dir[5]!\Ubisoft\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\Universal Extractor.7z" "!Dir[5]!\Universal Extractor\" -w"%Temp%"
!7za! u !7zaKeyString2! "!TempOutputDir[5]!\VMware.7z" "!Dir[5]!\VMware\" -w"%Temp%"

rem Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\_LastDesktopBackup.7z" "%userprofile%\Desktop\"