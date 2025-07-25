@echo on
@setlocal enableextensions enabledelayedexpansion
@set 7zaKeyString=-ssw -m0=LZMA2:d128m:fb256 -myx9 -mmt=8 -ms=off
@set 7zaKeyString2=-ssw -mmt=8 -ms=off
@set 7zaKeyString3=-ssw -mmt=8
@set 7zaKeyString4=-ssw -mmt=8 -mx9 -ms=off
@cd /D %~dp0
@cd /D ..\
@rem @echo cd - %cd%
@set ScriptsRootPath=%cd%
if /i "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
	@set 7za=%ScriptsRootPath%\7za\x64\7za.exe
) else (
	@set 7za=%ScriptsRootPath%\7za\7za.exe
)
@rem Time
@set digit1=%time:~0,1%
@if "%digit1%"==" " (@set digit1=0)
@set BackUpTimeStamp=!DATE:~-4!.!DATE:~3,2!.!DATE:~0,2!__!digit1!!TIME:~1,1!.!TIME:~3,2!
@set TimeStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@set DateStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!
@set OnlyTimeStamp=!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@rem 
@cd>_Temp\ScriptsRootDir.txt
@FOR /F "usebackq delims=" %%A IN ("_Temp\ScriptsRootDir.txt") DO ( @if not "%%~A" == "" (@set "ScriptsRootPath=%%~A") )
@cd /D _Temp
@cd>PathTempDir.txt
@FOR /F "usebackq delims=" %%A IN ("PathTempDir.txt") DO ( @if not "%%~A" == "" (@set "TempPath=%%~A") )
@cd /D ..\
@cd /D __Lists
@cd>..\_Temp\PathListsDir.txt
@cd /D ..\_Temp
@FOR /F "usebackq delims=" %%A IN ("PathListsDir.txt") DO ( @if not "%%~A" == "" (@set "ListDir=%%~A") )
@rem File Lists
@set List_7z=%ListDir%\7z_W3Files.txt
@set List_ExcludeModsFiles_7z=%ListDir%\Exclude\7z_ExcludeW3ModsFiles.txt
@set List_ExcludeFiles_7z=%ListDir%\Exclude\7z_ExcludeW3ScriptMergerFiles.txt
@rem 
@set TempFile01="%TempPath%\%~n1.tmp"
@set FileName=%~n1 (%BackUpTimeStamp%)
@cd /D %~dp1
@set OutputDir=%cd%
@set GameName=The Witcher 3
@set Game=The Witcher 3 Wild Hunt
@set Suffix01= (v1.32)
@set Suffix02= (v4.01)
@set Suffix03= (v4.02)
@rem ============================================== Init End ====================================================================
@rem 
@set sCmd=wmic volume where "label='Archive'" get DriveLetter
@call %sCmd%>%temp%\tmpLetter.txt
powershell -Command "(Get-Content %temp%\tmpLetter.txt)[1].Trim()">%temp%\Letter.txt
@call wmic exit
@FOR /F "usebackq delims=" %%A IN ("%temp%\Letter.txt") DO ( if not "%%~A" == "" (@set "Letter=%%~A") )
@rem ============================================================================================================================
@rem 
@if exist "%OutputDir%" ( goto :VerificationPath )

:VerificationPath
@if "%cd%" == "%~d1\Games\%Game%" (
@set GameVersion=v1_31
@goto :NextStep
)

@if "%cd%" == "%~d1\Games\%Game%%Suffix01%" (
@set GameVersion=v1_32
@goto :NextStep
)

@if "%cd%" == "%~d1\Games\%Game%%Suffix02%" (
@set GameVersion=v4_01
@goto :NextStep
)

@if "%cd%" == "%~d1\Games\%Game%%Suffix03%" (
@set GameVersion=v4_02
@goto :NextStep
)

:NextStep
@set BackupOutputDir=%Letter%\Archive\SavedGameFiles\%GameName%\_W3_Mods\%GameVersion%\mods
@echo %BackupOutputDir%

@rem 
@pause


@set W3ScriptMergerDir=%OutputDir%\Witcher Script Merger\
@rem "переменная %~a1 расширяется до атрибутов файла, например если нужно определить является цель файлом или папкой"
@set "p=%~a1"
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
@rem 
@echo %_Normal_Yellow%" =================================== %_Normal_Green%End init%_Normal_Yellow% =================================== "%_col_off%
@if not exist "%TempPath%" mkdir "%TempPath%"
@cd /D %~dp1
@rem Create .tmp
@del /F /S /Q %TempFile01%
@del /F /S /Q "%List_7z%"
@rem 
@chcp 65001>nul
if /i "%p:~0,1%"=="d" (
	@set SourceScriptTarget=%OutputDir%\%~n1
    @echo %~n1>>%TempFile01%
    @echo Witcher Script Merger>>%TempFile01%
) else (
	@set SourceScriptTarget=%OutputDir%\%~nx1
    @echo %~nx1>>%TempFile01%
)
@rem 
@chcp 866>nul
@copy %TempFile01% "%List_7z%"
@timeout /t 1 >nul
if /i "%p:~0,1%"=="d" (
	if /i "%~n1"=="mods" (
		@goto :Folder
	) else (
		@goto :Message02
	)
) else (
    @goto :File
)

:Folder
@echo %_Normal_Green% Folder = %SourceScriptTarget% %_col_off%
@goto :Continue

:File
@echo %_Normal_Green% File = %SourceScriptTarget% %_col_off%
@goto :Message01

:Continue
@echo Continue
for /f "delims=|" %%L in (%List_7z%) Do (
	if exist "!OutputDir!\%%L" (
		!7za! u -r0 !7zaKeyString4! "!OutputDir!\!FileName!.7z" "%%L" -w"%Temp%" -xr@!List_ExcludeFiles_7z!
	)
)
@rem 
!7za! d -y "!OutputDir!\!FileName!.7z" "Witcher Script Merger\*.txt" -r
@goto :End

:Message01
@chcp 65001>nul
@echo %_Normal_Red% " Целью бекапа должна быть папка. " %_col_off%
@chcp 866>nul
@rem 
@pause
@rem 
@goto :End

:Message02
@chcp 65001>nul
@echo %_Normal_Red% " Целью бекапа должна быть папка mods. " %_col_off%
@chcp 866>nul
@rem 
@pause
@rem 
@goto :End

:End
@del /F /S /Q %TempFile01%
@del /F /S /Q "%List_7z%"
del /f /q %temp%\tmpLetter.txt
del /f /q %temp%\Letter.txt

@rem @echo Dir 1 - "%~dp1"
@rem @echo "FullPath =" %1
@rem @echo "FullPath, FileName, FileName&FileTip & FileTip =" (%1) (%~n1) (%~nx1) (%~x1)
@rem @echo (%BackUpTimeStamp%)
@rem @echo %FileName%
@rem @echo "n1 =" "%Temp%\%~n1"
@rem @echo "n1 =" "%~n1"
@rem 
@rem "%~dp0\..\..\../workshop\content\440900
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
@rem 
@rem chcp 1251 >nul
@rem chcp 1252 >nul
@rem chcp 866 >nul
@rem                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ====================================================
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
if %isStep% LEQ 6 (
	if not %isStep% == 0 (
		if %isStep% LEQ 2 (
			for /f "delims=|" %%L in (!7z_List[%isStep%]!) Do (
				if exist "!Dir[%isStep%]!\%%L" (
					!7za! u -r0 !7zaKeyString4! "!OutputDir[%isStep%]!\%%L.7z" "%%L" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles[%isStep%]!"'
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
		)
	) else (
		if %isStep% == 0 (
			powershell -Command Export-StartLayout –path "%BackupsDir%\%TimeStamp%_%FileName%\Users\%USERNAME%\DefaultLayouts.xml"
			copy /v /y C:\_BackupRestore\_Utils\_RestoreBackup.cmd "%BackupsDir%\%TimeStamp%_%FileName%\_RestoreBackup.cmd"
			@rem Desktop
			!7za! u -r0 !7zaKeyString4! "%BackupsDir%\%TimeStamp%_%FileName%\Desktop.7z" "I:\Users\New\Desktop\*" -w"%Temp%"
			!7za! d -y "%BackupsDir%\%TimeStamp%_%FileName%\Desktop.7z" desktop.ini *.tmp *.dmp *.cookie *.log -r
			@rem LocalLow
			!7za! u -r0 !7zaKeyString4! "!OutputDir[%isStep%]!\!FileN[%isStep%]!.7z" "!Dir[%isStep%]!\*" -w"%Temp%" '-xr@"!7z_ExcludeRecurseFiles!"'
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
if %isStep% LEQ 6 ( goto :Pack )

@rem exit /b
@rem @timeout /t 360 >

if %isStep% GEQ 7 ( goto :End )
 
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
