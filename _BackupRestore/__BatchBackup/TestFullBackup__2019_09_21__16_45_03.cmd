:: Test Full Backup
@echo on
Title "Test Full Backup"
setlocal enableextensions enabledelayedexpansion
:: chcp 1251 >nul
:: chcp 1252 >nul
chcp 866 >nul
:: echo %USERNAME%
set digit1=%time:~0,1%
if "%digit1%"==" " (set digit1=0)
set isStep=0
set isAppRunning=2
set tmp=.tmp
set /A KB=1*1024
set /A MB=400*1048576
:: 
set RoboCopyParams=/S /ZB /R:3 /W:2 /SL /MT:32
set RoboCopyLocalExcludeDir="Recent" "Report*" "Temporary*" "Caches" "*Cache*" "*Crash*" "*Temp*" "*History*" "*Log*" "Application*" "Microsoft" "Diagnostics" "Packages" "Comms" "NVIDIA*" "Programs" "Publishers" "TempCheckUpdate" "*font*" "{*}" "*Folder" "e2eSoft" "speech" "TechSmith" "*Tile*" "Wondershare" "VirtualStore" "ConnectedDevicesPlatform"
set RoboCopyLocalExcludeFile="IconCache*" "*Cache*" "*.cookie" "*.LOG*" "*.tmp" "*.db" "*.dmp" "*.vbs" "*.7z"
set RoboCopyFileDataFlags=/COPYALL /DCOPY:DAT
set 7zaKeyString=-y -ssw -r- -m0=LZMA2:d128m:fb256 -myx9 -slp -mmt=32 -ms=off
:: 
set Explorer=explorer.exe
set 7za=F:\_BackupRestore\7z\1900\x64\7za.exe
set Dir001=%userprofile%\AppData\Local
set Dir002=%userprofile%\AppData\LocalLow
set Dir003=%userprofile%\AppData\Roaming
:: set TestDir=F:\NewFolder(2)
:: set Dir004=C:\Windows\SoftwareDistribution\Download
set BackupsDir=C:\Temp\1
set TempSourceBackupDir=C:\_BR\Temp
set TempBackupDir=C:\_BR
:: F:\Archive\_BackUps
set LogsDir=C:\_BackupRestore\__Logs
set ListDir=C:\_BackupRestore\__Lists
set FileName=TestFullBackup
set FileNameSec01=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%digit1%%TIME:~1,1%_%TIME:~3,2%_%TIME:~6,2%
set LogFile=%LogsDir%\%FileNameSec01%_%FileName%.log
set RoboCopyLogFile=%LogsDir%\%FileNameSec01%_%FileName%.txt
set ListLocalInclude=%ListDir%\Exclude.txt
set ListLocalExclude=%ListDir%\Exclude.txt
set ListRecurseExclude=%ListDir%\E_FilesList.txt
:: 
set ListFileLocal=%ListDir%\ListFileLocal.lst
:: 
echo %~dp0__BatchBackup\%~n0__%FileNameSec01%%~x0
copy /v /y %0 %~dp0__BatchBackup\%~n0__%FileNameSec01%%~x0
@timeout 5 >nul
:: 
goto :log
cd /D %Dir001%\
:: 
:cleaning
:: DIRECTORIES FOR CLEANING
rem команда rd удаляет только пустые папки (папки с файлами и файлы не трогает), если ее использовать без ключа /s
:: for /f "usebackq delims=" %%A in (`dir /a:d /s /b *`) do ( If %%~zA LSS 1 if exist "%%~nxA" rd /q "%%~nxA" )
:: del /F /Q "%temp%\*.*"
:: FILES FOR CLEANING
Del /F /Q %Dir001%\GetDirSize.vbs 1>nul 2>&1
Del /F /Q %TempSourceBackupDir%\GetDirSize.vbs 1>nul 2>&1
:: del /F /S /Q *%tmp%
:: for /f "usebackq delims=;" %%A in (`dir /s /b *.*`) do ( If %%~zA LSS 1 del /f /s /q "%%A" )
:: for /f "usebackq delims=;" %%A in (`dir /a:h-s /s /b *.*`) do ( If %%~zA LSS 1 del /f /s /q /a:h-s "%%A" )
:: for /f "usebackq delims=;" %%A in (`dir /a:hs /s /b *.*`) do ( If %%~zA LSS 1 del /f /s /q /a:hs "%%A" )
if %isStep% == 0 (goto :ReCreate)
:: 
:ReCreate
echo Step = %isStep% (ReCreate)
:: УДАЛЕНИЕ И CОЗДАНИЕ ВРЕМЕННОГО КАТАЛОГА ДЛЯ БЕКАПА
@timeout 2 >nul
:: del /F /S /Q "%TempSourceBackupDir%\*"
if exist "%TempSourceBackupDir%" rmdir /Q "%TempSourceBackupDir%"
@timeout 2 >nul
if not exist "%TempSourceBackupDir%" mkdir "%TempSourceBackupDir%"
@timeout 1 >nul
if not exist %Dir001%\GetDirSize.vbs goto :Step1
if exist %Dir001%\GetDirSize.vbs goto :Step2
:: 
:: @echo on
:: goto :Pack
:: 
:Step1
echo Step = %isStep% (CreateScriptObject)
cd /D %Dir001%\
Echo WScript.Echo CreateObject("Scripting.FileSystemObject").GetFolder(WScript.Arguments(0)).Size>GetDirSize.vbs
@timeout 1 >nul
cd /D %TempSourceBackupDir%\
Echo WScript.Echo CreateObject("Scripting.FileSystemObject").GetFolder(WScript.Arguments(0)).Size>GetDirSize.vbs
@timeout 2 >nul
if %isStep% == 0 (goto :Step2)
:: 
:Step2
echo ===============================================================================================================
cd /D %TempSourceBackupDir%\
echo Step = %isStep% (Create MKLINK)
for /d %%A In ("%Dir001%\*") Do (
	if not exist "%%~nxA" MKLINK /d /h /j "%%~nxA" "%%A"
)
@timeout 5 >nul
rmdir /Q "Application Data"
rmdir /Q "Microsoft"
rmdir /Q "Opera Software"
rmdir /Q "History"
rmdir /Q "Temp"
rmdir /Q "Temporary Internet Files"
rmdir /Q "BolideLog"
rmdir /Q "speech"
rmdir /Q "TechSmith"
rmdir /Q "TileDataLayer"
rmdir /Q "Wondershare"
rmdir /Q "Comms"
rmdir /Q "CrashDumps"
rmdir /Q "Packages"
rmdir /Q "ConnectedDevicesPlatform"
rmdir /Q "D3DSCache"
rmdir /Q "Diagnostics"
rmdir /Q "e2eSoft"
rmdir /Q "fontconfig"
rmdir /Q "NVIDIA Corporation"
rmdir /Q "PlaceholderTileLogoFolder"
rmdir /Q "Publishers"
rmdir /Q "TempCheckUpdate"
rmdir /Q "VirtualStore"
:: 
REM pause
if %isStep% == 0 (goto :Step3)
if %isStep% == 1 (goto :Step4)
:Step3
echo Step = %isStep% (Sort MKLINK to small size)
@timeout 3 >nul
For /D %%A In ("%TempSourceBackupDir%\*") Do (
	For /F "delims=" %%B In ('CScript //Nologo %TempSourceBackupDir%\GetDirSize.vbs "%%A"') Do (
		if %%B leq 1 rmdir /S /Q "%%~nxA"
		if %%B geq !MB! rmdir /S /Q "%%~nxA"
	)
)
rem pause
if %isStep% == 0 (goto :StepPack1)
:Step4
echo Step = %isStep% (Sort MKLINK to medium and big size)
@timeout 3 >nul
For /D %%A In ("%TempSourceBackupDir%\*") Do (
	For /F "delims=" %%B In ('CScript //Nologo %TempSourceBackupDir%\GetDirSize.vbs "%%A"') Do (
		if %%B leq !MB! rmdir /S /Q "%%~nxA"
	)
)
if %isStep% == 1 (goto :StepPack2)
:: 
:StepPack1
echo Step = %isStep% (Pack 1)
@timeout /t 2 >nul
ROBOCOPY "%TempSourceBackupDir%" "%TempBackupDir%" %RoboCopyParams% /LOG:"%RoboCopyLogFile%" /XA:S /XF %RoboCopyLocalExcludeFile% /XD %RoboCopyLocalExcludeDir% %RoboCopyFileDataFlags% /TBD
pause
::  -md=1g -mfb64
::  -myx9
::  -m9=LZMA2:d64k:fb32
:: 
::  -y -ssw -r- -m0=LZMA2:d128m:fb256 -myx9 -slp -mmt=32 -ms=off
rem start /b /wait 
:: %7zaKeyString%
cd /d "F:\_BackupRestore\7z\1900\x64\"
7za.exe u !7zaKeyString! "%TempBackupDir%\Local.7z" "%TempSourceBackupDir%\*" -w"%Temp%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%"
:: 
pause

REM start /b /wait F:\_BackupRestore\7za\7za.exe a -t7z -ssw -mx9 "%TempBackupDir%\2.7z" "%TempBackupDir%\*" -r0 -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%"
rem F:\_BackupRestore\7za\
rem F:\_BackupRestore\7z\1604\x64\
rem F:\_BackupRestore\7z\1805\x64\
rem F:\_BackupRestore\7z\1900\x64\
rem ROBOCOPY "%TempSourceBackupDir%" "%TempBackupDir%" /S /ZB /R:3 /W:2 /SL /MT:32 /LOG:"%RoboCopyLogFile%" /XF "IconCache*" "*Cache*" "*.cookie" "*.LOG*" "*.tmp" /XD "Recent" "Report*" "Temporary*" "Caches" "*Cache*" "Temp" "*History*" /COPYALL /DCOPY:DAT /TBD
rem start /b /wait F:\_BackupRestore\7za\7za.exe a -t7z -ssw -mx9 "%TempBackupDir%\2.7z" "%TempSourceBackupDir%\*" -r0 -w"%TempBackupDir%" -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%"
rem start /REALTIME /wait F:\_BackupRestore\7z\1900\x64\7za.exe d -y "%TempBackupDir%\2.7z" -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%" -bsp2 -slp -scsWIN -mmt=4 -mx9 -ms=off
if %isStep% == 0 (set isStep=1)
if %isStep% == 1 (goto :ReCreate)
:: 
:StepPack2
echo Step = %isStep% (Pack 2)
@timeout 2 >nul
ROBOCOPY "%TempSourceBackupDir%" "%TempBackupDir%" %RoboCopyParams% /LOG:"%RoboCopyLogFile%" /XA:S /XF %RoboCopyLocalExcludeFile% /XD %RoboCopyLocalExcludeDir% %RoboCopyFileDataFlags% /TBD

pause

For /D %%A In ("%TempSourceBackupDir%\*") Do (
	For /F "delims=" %%B In ('CScript //Nologo %TempSourceBackupDir%\GetDirSize.vbs "%%A"') Do (
		if %%B geq !MB! start /b /wait F:\_BackupRestore\7z\1900\x64\7za.exe u %7zaKeyString% "%TempBackupDir%\%%~nxA.7z" "%%A" -w"%Temp%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%"
	)
	
)
@timeout 2 >nul
rem F:\_BackupRestore\7z\1900\x64\7za.exe a -ssw "%TempBackupDir%\2.7z" "%TempSourceBackupDir%\*" -r0 -w"%TempBackupDir%" -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%" -bsp2 -slp -scsWIN -mmt=on -mx9 -ms=off
if %isStep% == 1 (set isStep=2)
if %isStep% == 2 (goto :End)
:: 
goto :log
:: 
:log
cd /D C:\_BR\Viber\
rem Echo WScript.Echo CreateObject("Scripting.FileSystemObject").GetFolder(WScript.Arguments(0)).Size>GetDirSize.vbs
Echo Do WScript.StdIn.AtEndOfStream::WScript.Echo Round(CreateObject("Scripting.FileSystemObject").GetFolder(WScript.StdIn.ReadLine).Size/2^^20,2)::Loop>GetDirSize.vbs
rem Echo WScript.StdIn.AtEndOfStream::WScript.Echo Round(CreateObject("Scripting.FileSystemObject").GetFolder(WScript.StdIn.ReadLine).Size/2^^20,2)>GetDirSize.vbs
For /D %%A In ("C:\_BR\Viber\*") Do (
	For /F "delims=" %%B In ('CScript //Nologo C:\_BR\Viber\GetDirSize.vbs "%%A"') Do (
		Set Bytes=%%B
		Set /A IntMB=!Bytes!/1048576
		Set /A IntKB=!Bytes!/1024
		Set /A FloatMB=!Bytes!%%1048576/10000
		Set /A FloatKB=!Bytes!%%1024/10
		if !FloatMB! leq 100 Echo Size of %%A is !FloatMB! MB. >> %ListDir%\ListFileViber.txt
	)
)
:End
Del /F /Q GetDirSize.vbs 1>nul 2>&1
endlocal



:: start /REALTIME /wait F:\_BackupRestore\7z\1900\x64\7za.exe a -ssw -y "%TempBackupDir%\2.7z" "%TempSourceBackupDir%\*" -r0 -w"%TempBackupDir%" -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%" -bsp2 -slp -scsWIN -mmt=on -mx9 -ms=off

:: @timeout 2 >nul
:: exit
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


:: F:\_BackupRestore\7z\1900\x64\7za.exe a -ssw "%BackupsDir%\1.7z" "%Dir001%\*" -r0 -w"%BackupsDir%\" -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%" -bsp2 -slp -scsWIN -mmt=on -mx9 -ms=off

:: Echo Do While Not WScript.StdIn.AtEndOfStream::WScript.Echo Round(CreateObject("Scripting.FileSystemObject").GetFolder(WScript.StdIn.ReadLine).Size/2^^20,2)::Loop>GetDirSize.vbs

:: Del /F /Q %ListDir%\ListFileLocal.txt 1>nul 2>&1
:: Del /F /Q %ListDir%\TempExcludeListLocal.txt 1>nul 2>&1

:: DIR C:\Users\New\AppData\Local /a /b /-p /o:gen >> %ListFileLocal%
:: for /d %%A in (F:\MNM\*) do C:\arc\7za.exe a -t7z -mx=0 -r -mhe -pPASS -- "C:\MNM2\%%~nxA.7z" "%%A"
:: For /F %%a IN ('Dir "%Dir001%\*" /-C/S/A:-D') Do Set DirSize=!n2!& Set n2=%%c
:: 
:: Set /A IntMB=!Bytes!/1048576
:: Set /A IntKB=!Bytes!/1024
:: Set /A FloatMB=!Bytes!%%1048576/10000
:: Set /A FloatKB=!Bytes!%%1024/10

:: '-xr@\path\to\backup_daily_exclude.lst'

:: if %%B leq 1048576 Echo Size of %%A is !FloatKB! KB. >> %ListDir%\ListFileLocal.txt
:: if %%B leq 1024 Echo Size of %%A is !Bytes! Bytes. >> %ListDir%\ListFileLocal.txt
:: Echo Size of %%A is %%B Bytes. >> %ListDir%\ListFileLocal.txt
:: Echo Size of %%A is %%B Bytes.

:: for /d %%A in ('Dir "%Dir001%\*" /-C/S/A:D') do ( if %%~zA leq 50000 Echo Size of %%A is %%~zA Bytes. )

:: for /d %%A in ('Dir "%Dir001%\*" /-C/S/A:-D') do  if %%~zA geq 1 if %%~zA leq 50000 C:\_BackupRestore\7za\7za.exe a -t7z -ssw -mx=9 -x@%ListLocalExclude% "%BackupsDir%\%%~nxA.7z" "%%A"


:: for /d "usebackq delims=;" %%A in (%Dir001%\*) do If %%~zA LSS 50000 %7za% u -t7z -ssw -mx=9 '-x!@%ListLocalExclude%' -- "C:\Temp\1\%%~nxA.7z" "%%A"

:: @timeout 2 >nul
:: 