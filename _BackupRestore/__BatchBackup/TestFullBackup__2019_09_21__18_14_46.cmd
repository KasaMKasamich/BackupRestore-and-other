:: Test Full Backup
@echo on
Title "Test Full Backup"
setlocal enableextensions enabledelayedexpansion
:: chcp 1251 >nul
:: chcp 1252 >nul
:: chcp 866 >nul
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
@timeout /t 5 >nul
:: 
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
@timeout /t 2 >nul
:: del /F /S /Q "%TempSourceBackupDir%\*"
if exist "%TempSourceBackupDir%" rmdir /Q "%TempSourceBackupDir%"
@timeout /t 2 >nul
if not exist "%TempSourceBackupDir%" mkdir "%TempSourceBackupDir%"
@timeout /t 1 >nul
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
@timeout /t 1 >nul
cd /D %TempSourceBackupDir%\
Echo WScript.Echo CreateObject("Scripting.FileSystemObject").GetFolder(WScript.Arguments(0)).Size>GetDirSize.vbs
@timeout /t 2 >nul
if %isStep% == 0 (goto :Step2)
:: 
:Step2
echo ===============================================================================================================
cd /D %TempSourceBackupDir%\
echo Step = %isStep% (Create MKLINK)
for /d %%A In ("%Dir001%\*") Do (
	if not exist "%%~nxA" MKLINK /d /h /j "%%~nxA" "%%A"
)
@timeout /t 5 >nul
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
@timeout /t 3 >nul
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
@timeout /t 3 >nul
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
rem pause
::  -md=1g -mfb64
::  -myx9
::  -m9=LZMA2:d64k:fb32
:: 
::  -y -ssw -r- -m0=LZMA2:d128m:fb256 -myx9 -slp -mmt=32 -ms=off
rem start /b /wait 
:: %7zaKeyString%
!7za! u !7zaKeyString! "%TempBackupDir%\Local.7z" "%TempSourceBackupDir%\*" -w"%Temp%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%"
:: if errorlevel 255 echo [92mUser_stopped_the_process[0m rem goto:user_stopped_the_process
if errorlevel 6 echo [92m "Произошла ошибка открытия файла./Access is denied." [0m rem goto:user_stopped_the_process
if errorlevel 5 echo [92m "Произошла ошибка записи на диск./Access is denied." [0m rem goto:user_stopped_the_process
if errorlevel 8 echo [95m "Not_enough_memory" [0m rem goto:not_enough_memory
if errorlevel 7 echo [94m Command_line_error [0m rem goto:command_line_error
if errorlevel 2 echo [91m Fatal_Error [0m rem goto:fatal_error
if errorlevel 1 echo [93m Ok_Warnings [0m rem goto:ok_warnings


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
@timeout /t 2 >nul
ROBOCOPY "%TempSourceBackupDir%" "%TempBackupDir%" %RoboCopyParams% /LOG:"%RoboCopyLogFile%" /XA:S /XF %RoboCopyLocalExcludeFile% /XD %RoboCopyLocalExcludeDir% %RoboCopyFileDataFlags% /TBD
:: 
For /D %%A In ("%TempSourceBackupDir%\*") Do (
	For /F "delims=" %%B In ('CScript //Nologo %TempSourceBackupDir%\GetDirSize.vbs "%%A"') Do (
		if %%B geq !MB! start /b /wait !7za! u !7zaKeyString! "%TempBackupDir%\%%~nxA.7z" "%%A" -w"%Temp%" -x@"!ListLocalExclude!" -xr@"!ListRecurseExclude!"
	)
	
)
@timeout /t 2 >nul
rem F:\_BackupRestore\7z\1900\x64\7za.exe a -ssw "%TempBackupDir%\2.7z" "%TempSourceBackupDir%\*" -r0 -w"%TempBackupDir%" -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%" -bsp2 -slp -scsWIN -mmt=on -mx9 -ms=off
if %isStep% == 1 (set isStep=2)
if %isStep% == 2 (goto :End)
:: 
:: goto :log
:: 
:log
For /D %%A In ("%Dir001%\*") Do (
	For /F "delims=" %%B In ('CScript //Nologo %Dir001%\GetDirSize.vbs "%%A"') Do (
		Set Bytes=%%B
		Set /A IntMB=!Bytes!/1048576
		Set /A IntKB=!Bytes!/1024
		Set /A FloatMB=!Bytes!%%1048576/10000
		Set /A FloatKB=!Bytes!%%1024/10
		if !FloatMB! geq 100 Echo Size of %%A is !FloatMB! MB. >> %ListDir%\ListFileLocal.txt
	)
)
:End
Del /F /Q GetDirSize.vbs 1>nul 2>&1
endlocal
:: @timeout /t 2 >nul
:: exit



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

