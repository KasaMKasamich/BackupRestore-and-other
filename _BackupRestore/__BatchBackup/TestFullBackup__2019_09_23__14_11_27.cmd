:: Test Full Backup
@echo on
Title "Test Full Backup"
rem MODE CON: COLS=120 LINES=55
rem MODE CON: COLS=220
setlocal enableextensions enabledelayedexpansion
:: chcp 1251 >nul
:: chcp 1252 >nul
:: chcp 866 >nul
::  Time
set digit1=%time:~0,1%
if "%digit1%"==" " (set digit1=0)
set TimeStamp=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%digit1%%TIME:~1,1%_%TIME:~3,2%_%TIME:~6,2%
::  bool
set isStep=0
set isAppRunning=2
::  int
set /A KB=1*1024
set /A MB=400*1048576
::  RoboCopy
set RCParams=/S /ZB /R:3 /W:2 /SL /MT:32 /XA:sh
set RCLocalExcludeDir="Yandex" "Vivox" "IceDragon" "Logs" "Recent" "Report*" "Temporary*" "*Crash*" "*Temp*" "*History*" "*Log*" "Application*" "Microsoft" "Diagnostics" "Packages" "Comms" "NVIDIA*" "Programs" "Publishers" "TempCheckUpdate" "fontconfig" "{*}" "*Folder" "e2eSoft" "speech" "TechSmith" "*Tile*" "Wondershare" "VirtualStore" "ConnectedDevicesPlatform"
set RCLocalExcludeFile="IconCache*" "thumbcache*" "*.cookie" "*.log" "*.tmp" "*.dmp" "*.vbs" "*.7z"
set RCYandexExcludeDirs="*Crash*" "*Temp*" "*Logs*" "*Report*" "BrowserMetrics" "Safe Browsing" "Safe Browsing Cookies" "CrashpadMetrics-active.pma" "*History*" "*Log*" "Application*" "Microsoft" "Diagnostics" "Packages" "Comms" "NVIDIA*" "Programs" "Publishers" "TempCheckUpdate" "fontconfig" "{*}" "*Folder" "e2eSoft" "speech" "TechSmith" "*Tile*" "Wondershare" "VirtualStore" "ConnectedDevicesPlatform"
set RCYandexExcludeFile="*.cookie" "*.log" "*.tmp" "*.dmp" "*.vbs"
set RCFileDataFlags=/COPYALL /DCOPY:DAT
::  7za
set 7zaKeyString=-ssw -m0=LZMA2:d128m:fb256 -myx9 -slp -mmt=32 -ms=off
set 7za=C:\_BackupRestore\7z\1900\x64\7za.exe
::  Папки
set Dir001=%userprofile%\AppData\Local
set Dir002=%userprofile%\AppData\LocalLow
set Dir003=%userprofile%\AppData\Roaming
set BackupsDir=F:\Archive\_BackUps
set TempSourceBackupDir=C:\_BR\Temp
set TempSourceBackupLSSDir=C:\_BR\TempLSS
set TempSourceBackupGTRDir=C:\_BR\TempGTR
set TempBackupDir=C:\_BR
set LogsDir=C:\_BackupRestore\__Logs
set ListDir=C:\_BackupRestore\__Lists
:: set Dir004=C:\Windows\SoftwareDistribution\Download
:: F:\Archive\_BackUps
::  Files
set FileName=TestFullBackup
set LogFile=%LogsDir%\%TimeStamp%_%FileName%.log
set RCLogFile=%LogsDir%\%TimeStamp%_%FileName%.txt
set ListLocalInclude=%ListDir%\Include.txt
set ListLocalExclude=%ListDir%\Exclude.txt
set ListRecurseExclude=%ListDir%\E_FilesList.txt
:: 
set ListFileLocal=%ListDir%\ListFileLocal.lst
::  Self Backup
:: echo %~dp0__BatchBackup\%~n0__%TimeStamp%%~x0
copy /v /y %0 %~dp0__BatchBackup\%~n0__%TimeStamp%%~x0
:: 
@timeout /t 1 >nul
cd /D %Dir001%\
echo [92m " =========================================== End init =========================================== " [0m 
:: 
:cleaning
::  DIRECTORIES FOR CLEANING
::	 команда rd удаляет только пустые папки (папки с файлами и файлы не трогает), если ее использовать без ключа /s
rem for /f "usebackq delims=" %%A in (`dir /a:d /s /b *`) do ( If %%~zA LSS 1 if exist "%%~nxA" rd /q "%%~nxA" )
::  
rem del /F /Q "%temp%\*.*"
::  FILES FOR CLEANING
rem del /F /S /Q *.tmp
rem for /f "usebackq delims=;" %%A in (`dir /s /b *.*`) do ( If %%~zA LSS 1 del /f /s /q "%%A" )
rem for /f "usebackq delims=;" %%A in (`dir /a:h-s /s /b *.*`) do ( If %%~zA LSS 1 del /f /s /q /a:h-s "%%A" )
rem for /f "usebackq delims=;" %%A in (`dir /a:hs /s /b *.*`) do ( If %%~zA LSS 1 del /f /s /q /a:hs "%%A" )
:CreateVBSScripts
echo [92m " ===================================== CREATE SCRIPT OBJECT ===================================== " [0m 
if exist %Dir001%\GetDirSize.vbs ( Del /F /Q %Dir001%\GetDirSize.vbs 1>nul 2>&1 )
if exist %TempSourceBackupDir%\GetDirSize.vbs ( Del /F /Q %TempSourceBackupDir%\GetDirSize.vbs 1>nul 2>&1 )
@timeout /t 1 >nul
Echo WScript.Echo CreateObject("Scripting.FileSystemObject").GetFolder(WScript.Arguments(0)).Size>GetDirSize.vbs
@timeout /t 1 >nul
cd /D %TempSourceBackupDir%\
Echo WScript.Echo CreateObject("Scripting.FileSystemObject").GetFolder(WScript.Arguments(0)).Size>GetDirSize.vbs
@timeout /t 2 >nul
rem if %isStep% == 0 (goto :ReCreate)
:ReCreate
echo [92m " Step = %isStep% (ReCreate) " [0m
::  CОЗДАНИЕ ВРЕМЕННОГО КАТАЛОГА ДЛЯ БЕКАПА
if not exist "%TempSourceBackupDir%" mkdir "%TempSourceBackupDir%"
if not exist "%TempSourceBackupLSSDir%" mkdir "%TempSourceBackupLSSDir%"
if not exist "%TempSourceBackupGTRDir%" mkdir "%TempSourceBackupGTRDir%"
@timeout /t 1 >nul
if exist %Dir001%\GetDirSize.vbs goto :Step2
:: 
:Step2
echo [92m " ===================================== CREATE MKLINK`S ===================================== " [0m 
echo [92m " Step = %isStep% " [0m 
cd /D %TempSourceBackupDir%\
for /d %%A In ("%Dir001%\*") Do (
	if not "%%~nxA"==!RCLocalExcludeDir[%%A]! (
		if not exist "%%~nxA" MKLINK /d /h /j "%%~nxA" "%%A"
	)
	
)
@timeout /t 2 >nul
for /f "usebackq delims=" %%A in (`dir /a:d /s /b "%TempSourceBackupDir%\*Crash*"`) do (  if exist "%%~nxA" rmdir /q "%TempSourceBackupDir%\%%~nxA" )
for /f "usebackq delims=" %%A in (`dir /a:d /s /b "%TempSourceBackupDir%\*Cache*"`) do (  if exist "%%~nxA" rmdir /q "%TempSourceBackupDir%\%%~nxA" )
for /f "usebackq delims=" %%A in (`dir /a:d /s /b "%TempSourceBackupDir%\*Tile*"`) do (  if exist "%%~nxA" rmdir /q "%TempSourceBackupDir%\%%~nxA" )
for /f "usebackq delims=" %%A in (`dir /a:d /s /b "%TempSourceBackupDir%\*Temp*"`) do (  if exist "%%~nxA" rmdir /q "%TempSourceBackupDir%\%%~nxA" )
for /f "usebackq delims=" %%A in (`dir /a:d /s /b "%TempSourceBackupDir%\*font*"`) do (  if exist "%%~nxA" rmdir /q "%TempSourceBackupDir%\%%~nxA" )
for /f "usebackq delims=" %%A in (`dir /a:d /s /b "%TempSourceBackupDir%\{*}"`) do (  if exist "%%~nxA" rmdir /q "%TempSourceBackupDir%\%%~nxA" )
rmdir /Q "Application Data"
rmdir /Q "Microsoft"
rmdir /Q "Opera Software"
rmdir /Q "Temp"
rmdir /Q "BolideLog"
rmdir /Q "speech"
rmdir /Q "TechSmith"
rmdir /Q "Wondershare"
rmdir /Q "Comms"
rmdir /Q "Packages"
rmdir /Q "ConnectedDevicesPlatform"
rmdir /Q "Diagnostics"
rmdir /Q "e2eSoft"
rmdir /Q "NVIDIA Corporation"
rmdir /Q "Publishers"
rmdir /Q "VirtualStore"
rmdir /Q "Programs"
rmdir /Q "UmmyVideoDownloader"
rmdir /Q "Comodo"
rmdir /Q "Yandex"
rem rmdir /Q "Vivox"
rem rmdir /Q "Spoon"
rem rmdir /Q "PlaceholderTileLogoFolder"
rem rmdir /Q "TempCheckUpdate"
rem rmdir /Q "{*}"
rem rmdir /Q "fontconfig"
rem rmdir /Q "TileDataLayer"
rem rmdir /Q "*Crash*"
rem rmdir /Q "CrashDumps"
rem rmdir /Q "D3DSCache"
:: 
rem pause

if %isStep% == 0 (goto :StepLSSSource)
if %isStep% == 1 (goto :StepGTRSource)
REM TempSourceBackupLSSDir=C:\_BR\TempLSS
rem TempSourceBackupGTRDir=C:\_BR\TempGTR
:StepLSSSource
echo [92m " ================================ Sort MKLINK to small size ================================ " [0m 
echo [92m " Step = %isStep% " [0m 
@timeout /t 3 >nul
For /D %%A In ("%TempSourceBackupDir%\*") Do (
	For /F "delims=" %%B In ('CScript //Nologo %TempSourceBackupDir%\GetDirSize.vbs "%%A"') Do (
		if %%B leq 1 rmdir /S /Q "%%~nxA"
		if %%B geq !MB! rmdir /S /Q "%%~nxA"
	)
)
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
@timeout /t 3 >nul
xcopy %Dir001%\NVIDIA\accounts. %TempSourceBackupLSSDir%\NVIDIA\ /R /Y /O /X
ROBOCOPY "%TempSourceBackupDir%" "%TempSourceBackupLSSDir%" %RCParams% /LOG:"%RCLogFile%" /XF %RCLocalExcludeFile% /XD %RCLocalExcludeDir% %RCFileDataFlags% /TBD
pause
rem pause
if %isStep% == 0 (goto :StepLSSPack)
:StepGTRSource
echo [92m " =========================== Sort MKLINK to medium and big size =========================== " [0m 
echo [92m " Step = %isStep% " [0m 
@timeout /t 3 >nul
For /D %%A In ("%TempSourceBackupDir%\*") Do (
	For /F "delims=" %%B In ('CScript //Nologo %TempSourceBackupDir%\GetDirSize.vbs "%%A"') Do (
		if %%B leq !MB! rmdir /S /Q "%%~nxA"
	)
)
ROBOCOPY "%TempSourceBackupDir%" "%TempSourceBackupGTRDir%" %RCParams% /LOG:"%RCLogFile%" /XF %RCLocalExcludeFile% /XD %RCLocalExcludeDir% %RCFileDataFlags% /TBD
:: "C:\Users\New\AppData\Local\Yandex\YandexBrowser\User Data"
RMDIR /S /Q "%TempSourceBackupGTRDir%\Yandex\SearchBand"
RMDIR /S /Q "%TempSourceBackupGTRDir%\Yandex\Yandex.Disk.2"
RMDIR /S /Q "%TempSourceBackupGTRDir%\Yandex\YaPin"
RMDIR /S /Q "%TempSourceBackupGTRDir%\Yandex\YaPinIcons"
@timeout /t 3 >nul
if %isStep% == 1 (goto :StepGTRPack)
:: 
:StepLSSPack
echo [92m " ===================================== Pack Step-1 ===================================== " [0m 
echo [92m " Step = %isStep% " [0m 
@timeout /t 2 >nul
rem start /b /wait 
!7za! u -y -r !7zaKeyString! "%TempBackupDir%\Local.7z" "%TempSourceBackupLSSDir%\*" -w"%Temp%" -x@"!ListLocalExclude!" -xr@"!ListRecurseExclude!"
::
if exist "%TempBackupDir%\Local.7z" if %isStep% == 0 (set isStep=1)
if %isStep% == 1 (goto :ReCreate)
:: 
:StepGTRPack
echo [92m " ===================================== Pack Step-2 ===================================== " [0m 
echo [92m " Step = %isStep% " [0m 
@timeout /t 2 >nul
For /D %%A In ("%TempSourceBackupGTRDir%\*") Do (
	!7za! u -y -r !7zaKeyString! "!TempBackupDir!\%%~nxA.7z" "%%A" -x@"!ListLocalExclude!" -xr@"!ListRecurseExclude!"
)
	rem For /F "delims=" %%B In ('CScript //Nologo %TempSourceBackupGTRDir%\GetDirSize.vbs "%%A"') Do (
	rem		if %%B geq !MB! 
	rem )

pause

rem '-xr!*.tmp' '-xr!*.dmp' '-xr!*.cookie' '-xr!*.log' '-xr!*.vbs' '-xr!*.7z'
@timeout /t 2 >nul
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
echo [92m " ========================================== End ========================================== " [0m
@timeout /t 2 >nul
Del /F /Q %Dir001%\GetDirSize.vbs 1>nul 2>&1
Del /F /Q %TempSourceBackupDir%\GetDirSize.vbs 1>nul 2>&1
:: del /F /S /Q "%TempSourceBackupDir%\*"
if exist "%TempSourceBackupDir%" rmdir /Q "%TempSourceBackupDir%"
if exist "%TempSourceBackupLSSDir%" rmdir /S /Q "%TempSourceBackupLSSDir%\"
if exist "%TempSourceBackupGTRDir%" rmdir /S /Q "%TempSourceBackupGTRDir%\"


endlocal
:: @timeout /t 2 >nul
:: exit


:: Extension Rules
:: Extension State
:: Extensions
:: Local Extension Settings
:: Managed Extension Settings
:: Sync Data
:: Sync Extension Settings
:: Web Applications


:: Bookmarks.
:: Cookies.
:: Current Session.
:: Current Tabs.
:: Extension Cookies.
:: History.
:: Last Session.
:: Last Tabs.
:: Preferences.
:: Secure Preferences.
:: Tablo.
:: Top Sites.
:: Visited Links.
:: Web Data.
:: Ya Credit Cards.
:: Ya Login Data.

:: \UserData\
:: configs\
:: HibernateSnapshots\
:: RescueTool\
:: RescueToolReport\
:: Resources\
:: ui_config\
:: YandexDictionaries\
:: YandexOfflineSpellchecker\
:: First Run.
:: Last Version.

rem F:\_BackupRestore\7z\1900\x64\7za.exe a -ssw "%TempBackupDir%\2.7z" "%TempSourceBackupDir%\*" -r0 -w"%TempBackupDir%" -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%" -bsp2 -slp -scsWIN -mmt=on -mx9 -ms=off

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

REM start /b /wait F:\_BackupRestore\7za\7za.exe a -t7z -ssw -mx9 "%TempBackupDir%\2.7z" "%TempBackupDir%\*" -r0 -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%"
rem F:\_BackupRestore\7za\
rem F:\_BackupRestore\7z\1604\x64\
rem F:\_BackupRestore\7z\1805\x64\
rem F:\_BackupRestore\7z\1900\x64\
rem ROBOCOPY "%TempSourceBackupDir%" "%TempBackupDir%" /S /ZB /R:3 /W:2 /SL /MT:32 /LOG:"%RoboCopyLogFile%" /XF "IconCache*" "*Cache*" "*.cookie" "*.LOG*" "*.tmp" /XD "Recent" "Report*" "Temporary*" "Caches" "*Cache*" "Temp" "*History*" /COPYALL /DCOPY:DAT /TBD
rem start /b /wait F:\_BackupRestore\7za\7za.exe a -t7z -ssw -mx9 "%TempBackupDir%\2.7z" "%TempSourceBackupDir%\*" -r0 -w"%TempBackupDir%" -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%"
rem start /REALTIME /wait F:\_BackupRestore\7z\1900\x64\7za.exe d -y "%TempBackupDir%\2.7z" -i@"%ListLocalInclude%" -x@"%ListLocalExclude%" -xr@"%ListRecurseExclude%" -bsp2 -slp -scsWIN -mmt=4 -mx9 -ms=off



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

