@Rem [ Author: [ Бурлачков Василий Александрович) ] ]
@echo off
@Title "Last Epoch MKLINK"
@rem @set dm=0
@rem @if "%dm%" == "" @echo off
@rem @if "%dm%" NEQ "" @echo on
@rem setlocal enableextensions enabledelayedexpansion
setlocal EnableExtensions
setlocal EnableDelayedExpansion
@chcp 65001>nul
@rem echo -- %dm%
@rem chcp 1251 >nul
@rem @chcp 1252 >
@rem @set Letters=0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
@rem ==========================================================================
cd /d %~dp0
@rem C:\_BackupRestore\_Utils\_for_games
@rem for %%i in ("%~dp0\..\..\..\../workshop\content\440900") do set "root_parent=%%~fi"
@rem ":\Games\Last Epoch"
@set LinkForDir=/d
@set LinkForDir02=/d /j
@set LinkForDir03=/d /h /j
@set Game=Last Epoch
@set GameDir01=Last Epoch
@set GameDir02=Last Epoch (v0.8.5f)
@set GameDir03=Last Epoch (v0.9.2)
@set LocalLowDir=%USERPROFILE%\AppData\LocalLow
@set GameSavesDir=%LocalLowDir%\Eleventh Hour Games\%Game%\Saves
@set FAQDirName=[] FAQ
@set UserFilesDirName=[] User Files
@rem ============================================================================
set sCmd0101=wmic volume where (label="Archive") get DriveLetter
set sCmd0201=wmic volume where (label="Games") get DriveLetter
set sCmd0301=wmic volume where (label="UserData") get DriveLetter
@rem ============================================================================
@if exist "%Temp%\tmpDriveLetter01.txt" ( del /f /q "%Temp%\tmpDriveLetter01.txt" )
@if exist "%Temp%\tmpDriveLetter02.txt" ( del /f /q "%Temp%\tmpDriveLetter02.txt" )
@if exist "%Temp%\tmpDriveLetter03.txt" ( del /f /q "%Temp%\tmpDriveLetter03.txt" )
@rem 
@if exist "%Temp%\tmpfDriveLetter01.txt" ( del /f /q "%Temp%\tmpfDriveLetter01.txt" )
@if exist "%Temp%\tmpfDriveLetter02.txt" ( del /f /q "%Temp%\tmpfDriveLetter02.txt" )
@if exist "%Temp%\tmpfDriveLetter03.txt" ( del /f /q "%Temp%\tmpfDriveLetter03.txt" )
@rem ============================================================================
call %sCmd0101%>%Temp%\tmpDriveLetter01.txt
call %sCmd0201%>%Temp%\tmpDriveLetter02.txt
call %sCmd0301%>%Temp%\tmpDriveLetter03.txt
@rem ============================================================================
wmic exit
@rem 
powershell -Command "(Get-Content %Temp%\tmpDriveLetter01.txt)[1].Trim() | Add-Content -Path %Temp%\tmpfDriveLetter01.txt"
powershell -Command "(Get-Content %Temp%\tmpDriveLetter02.txt)[1].Trim() | Add-Content -Path %Temp%\tmpfDriveLetter02.txt"
powershell -Command "(Get-Content %Temp%\tmpDriveLetter03.txt)[1].Trim() | Add-Content -Path %Temp%\tmpfDriveLetter03.txt"
@rem 
@FOR /F "usebackq delims=" %%A IN ("%Temp%\tmpfDriveLetter01.txt") DO ( @if not "%%~A" == "" (@set "sDriveLetter01=%%~A") )
@FOR /F "usebackq delims=" %%B IN ("%Temp%\tmpfDriveLetter02.txt") DO ( @if not "%%~B" == "" (@set "sDriveLetter02=%%~B") )
@FOR /F "usebackq delims=" %%C IN ("%Temp%\tmpfDriveLetter03.txt") DO ( @if not "%%~C" == "" (@set "sDriveLetter03=%%~C") )
@rem ============================================================================
@set SavesArchive=%sDriveLetter01%\Archive\SavedGameFiles
@set FAQ=%SavesArchive%\%Game%\%FAQDirName%
@set UserFiles=%SavesArchive%\%Game%\%UserFilesDirName%
@set MelonLoader=%SavesArchive%\%Game%\MelonLoader
@set Mods=%SavesArchive%\%Game%\Mods
@set Mods085f=%SavesArchive%\%Game%\Mods_v085f\Mods
@set Plugins=%SavesArchive%\%Game%\Plugins
@set UserData=%SavesArchive%\%Game%\UserData
@set UserLibs=%SavesArchive%\%Game%\UserLibs
@set LocalDirGameSaves=Games\%Game%
@rem ============================================================================
@if not exist "%FAQ%" mkdir "%FAQ%"
@if not exist "%UserFiles%" mkdir "%UserFiles%"
@if not exist "%MelonLoader%" mkdir "%MelonLoader%"
@if not exist "%Mods%" mkdir "%Mods%"
@if not exist "%Mods085f%" mkdir "%Mods085f%"
@if not exist "%Plugins%" mkdir "%Plugins%"
@if not exist "%UserData%" mkdir "%UserData%"
@if not exist "%UserLibs%" mkdir "%UserLibs%"
@rem ============================================================================
:DisplayEcho
@rem @echo cd - %cd%
@rem @echo sDriveLetter01 - %sDriveLetter01%
@rem @echo sDriveLetter02 - %sDriveLetter02%
@rem @echo sDriveLetter03 - %sDriveLetter03%
@rem @echo SavesArchive - %SavesArchive%
@rem @echo Saves - "%sDriveLetter02%\%LocalDirGameSaves%\Saves"
@rem @echo GameSavesDir - "%GameSavesDir%"
@rem 
cls
@rem ============================================================================
@if exist "%sDriveLetter01%\Games\%GameDir01%\" ( goto :SetPathDest0101 )
@rem @if exist "%sDriveLetter01%\Games\%GameDir03%" ( goto :SetPathDest3 )
@if exist "%sDriveLetter02%\Games\%GameDir01%\" ( goto :SetPathDest0201 )
@rem @if exist "%sDriveLetter02%\Games\%GameDir03%" ( goto :SetPathDest3 )
@if exist "%sDriveLetter03%\Games\%GameDir01%\" ( goto :SetPathDest0301 )
@rem @if exist "%sDriveLetter03%\Games\%GameDir02%" ( goto :SetPathDest2 )
@rem @if exist "%sDriveLetter03%\Games\%GameDir03%" ( goto :SetPathDest3 )

@rem >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
:SetPathDest0101
@cd /d "%sDriveLetter01%\Games\!GameDir01!\"
@rem @echo SetPathDest0101 - %cd%
@rem 
@if exist "%sDriveLetter01%\Games\%GameDir01%\" (
 @if not exist "%FAQDirName%\" (MKLINK %LinkForDir% "%FAQDirName%\" "!FAQ!")
 @if not exist "%UserFilesDirName%\" (MKLINK %LinkForDir% "%UserFilesDirName%\" "!UserFiles!")
 @if not exist "MelonLoader\" (MKLINK %LinkForDir% MelonLoader "!MelonLoader!")
 @if not exist "Mods\" (MKLINK %LinkForDir% Mods "!Mods!")
 @if not exist "Plugins\" (MKLINK %LinkForDir% Plugins "!Plugins!")
 @if not exist "UserData\" (MKLINK %LinkForDir% UserData "!UserData!")
 @if not exist "UserLibs\" (MKLINK %LinkForDir% UserLibs "!UserLibs!")
 @if not exist "%sDriveLetter01%\%LocalDirGameSaves%\Saves\" (MKLINK %LinkForDir% Saves "!GameSavesDir!")
 @if exist "!LocalLowDir!\Eleventh Hour Games\!Game!\" (MKLINK !LinkForDir! "[] LocalLow - Last Epoch" "!LocalLowDir!\Eleventh Hour Games\!Game!\")
)
@rem 
@if exist "%sDriveLetter01%\Games\%GameDir02%" ( goto :SetPathDest0102 )
@rem <<< ========================================================================
@rem ============================================================================
:SetPathDest0102
@cd /d "%sDriveLetter01%\Games\!GameDir02!\"
@rem @echo SetPathDest0201 - %cd%
@rem 
@if exist "%sDriveLetter01%\Games\%GameDir02%\" (
 @if not exist "%FAQDirName%\" ( MKLINK !LinkForDir! "%FAQDirName%\" "!FAQ!" )
 @if not exist "%UserFilesDirName%\" (MKLINK %LinkForDir% "%UserFilesDirName%\" "!UserFiles!")
 @if not exist "MelonLoader\" ( MKLINK !LinkForDir! MelonLoader "!MelonLoader!" )
 @if not exist "Mods\" ( MKLINK !LinkForDir! Mods "!Mods!" )
 @if not exist "Plugins\" ( MKLINK !LinkForDir! Plugins "!Plugins!" )
 @if not exist "UserData\" ( MKLINK !LinkForDir! UserData "!UserData!" )
 @if not exist "UserLibs\" ( MKLINK !LinkForDir! UserLibs "!UserLibs!" )
 @if not exist "!sDriveLetter01!\!LocalDirGameSaves!\Saves\" ( MKLINK !LinkForDir! Saves "!GameSavesDir!" )
 @if exist "!LocalLowDir!\Eleventh Hour Games\!Game!\" (MKLINK !LinkForDir! "[] LocalLow - Last Epoch" "!LocalLowDir!\Eleventh Hour Games\!Game!\")
)
@rem 
goto :EOF
@rem <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

@rem >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
:SetPathDest0201
@cd /d "%sDriveLetter02%\Games\!GameDir01!\"
@rem @echo SetPathDest0201 - %cd%
@rem 
@if exist "%sDriveLetter02%\Games\%GameDir01%\" (
 @if not exist "%FAQDirName%\" ( MKLINK !LinkForDir! "%FAQDirName%\" "!FAQ!" )
 @if not exist "%UserFilesDirName%\" (MKLINK %LinkForDir% "%UserFilesDirName%\" "!UserFiles!")
 @if not exist "MelonLoader\" ( MKLINK !LinkForDir! MelonLoader "!MelonLoader!" )
 @if not exist "Mods\" ( MKLINK !LinkForDir! Mods "!Mods!" )
 @if not exist "Plugins\" ( MKLINK !LinkForDir! Plugins "!Plugins!" )
 @if not exist "UserData\" ( MKLINK !LinkForDir! UserData "!UserData!" )
 @if not exist "UserLibs\" ( MKLINK !LinkForDir! UserLibs "!UserLibs!" )
 @if not exist "!sDriveLetter02!\!LocalDirGameSaves!\Saves\" ( MKLINK !LinkForDir! Saves "!GameSavesDir!" )
 @if exist "!LocalLowDir!\Eleventh Hour Games\!Game!\" (MKLINK !LinkForDir! "[] LocalLow - Last Epoch" "!LocalLowDir!\Eleventh Hour Games\!Game!\")
)
@rem 
 @rem @if not exist "Mods\" (MKLINK %LinkForDir% Mods "!Mods085f!")
@if exist "%sDriveLetter02%\Games\%GameDir02%" ( goto :SetPathDest0202 )
@rem <<< ========================================================================
@rem ============================================================================
:SetPathDest0202
@cd /d "%sDriveLetter02%\Games\!GameDir02!\"
@rem @echo SetPathDest0201 - %cd%
@rem 
@if exist "%sDriveLetter02%\Games\%GameDir02%\" (
 @if not exist "%FAQDirName%\" ( MKLINK !LinkForDir! "%FAQDirName%\" "!FAQ!" )
 @if not exist "%UserFilesDirName%\" (MKLINK %LinkForDir% "%UserFilesDirName%\" "!UserFiles!")
 @if not exist "MelonLoader\" ( MKLINK !LinkForDir! MelonLoader "!MelonLoader!" )
 @if not exist "Mods\" ( MKLINK !LinkForDir! Mods "!Mods!" )
 @if not exist "Plugins\" ( MKLINK !LinkForDir! Plugins "!Plugins!" )
 @if not exist "UserData\" ( MKLINK !LinkForDir! UserData "!UserData!" )
 @if not exist "UserLibs\" ( MKLINK !LinkForDir! UserLibs "!UserLibs!" )
 @if not exist "!sDriveLetter02!\!LocalDirGameSaves!\Saves\" ( MKLINK !LinkForDir! Saves "!GameSavesDir!" )
 @if exist "!LocalLowDir!\Eleventh Hour Games\!Game!\" (MKLINK !LinkForDir! "[] LocalLow - Last Epoch" "!LocalLowDir!\Eleventh Hour Games\!Game!\")
)
@rem 
goto :EOF
 @rem @if not exist "Mods\" (MKLINK %LinkForDir% Mods "!Mods085f!")
@rem <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

@rem ============================================================================
:SetPathDest0301
@cd /d "%sDriveLetter03%\Games\!GameDir01!\"
@rem @echo SetPathDest0301 - %cd%
@rem 
@if exist "%sDriveLetter03%\Games\%GameDir01%\" (
 @if not exist "%FAQDirName%\" (MKLINK %LinkForDir% "%FAQDirName%\" "!FAQ!")
 @if not exist "%UserFilesDirName%\" (MKLINK %LinkForDir% "%UserFilesDirName%\" "!UserFiles!")
 @if not exist "MelonLoader\" (MKLINK %LinkForDir% MelonLoader "!MelonLoader!")
 @if not exist "Mods\" (MKLINK %LinkForDir% Mods "!Mods!")
 @if not exist "Plugins\" (MKLINK %LinkForDir% Plugins "!Plugins!")
 @if not exist "UserData\" (MKLINK %LinkForDir% UserData "!UserData!")
 @if not exist "UserLibs\" (MKLINK %LinkForDir% UserLibs "!UserLibs!")
 @if not exist "!sDriveLetter03!\!LocalDirGameSaves!\Saves\" ( MKLINK !LinkForDir! Saves "!GameSavesDir!" )
 @if exist "!LocalLowDir!\Eleventh Hour Games\!Game!\" (MKLINK !LinkForDir! "[] LocalLow - Last Epoch" "!LocalLowDir!\Eleventh Hour Games\!Game!\")
)
 @rem @if not exist "Mods\" (MKLINK %LinkForDir% Mods "!Mods085f!")
@rem 
goto :EOF

:EOF
@rem @pause
@rem ============================================================================
@if exist "%Temp%\tmpDriveLetter01.txt" ( del /f /q "%Temp%\tmpDriveLetter01.txt" )
@if exist "%Temp%\tmpDriveLetter02.txt" ( del /f /q "%Temp%\tmpDriveLetter02.txt" )
@if exist "%Temp%\tmpDriveLetter03.txt" ( del /f /q "%Temp%\tmpDriveLetter03.txt" )
@rem 
@if exist "%Temp%\tmpfDriveLetter01.txt" ( del /f /q "%Temp%\tmpfDriveLetter01.txt" )
@if exist "%Temp%\tmpfDriveLetter02.txt" ( del /f /q "%Temp%\tmpfDriveLetter02.txt" )
@if exist "%Temp%\tmpfDriveLetter03.txt" ( del /f /q "%Temp%\tmpfDriveLetter03.txt" )
@rem endlocal
@rem	"MKLINK [[/D] | [/H] | [/J]] Ссылка Назначение"
@rem 
@rem	"/D				Создает символьную ссылку на каталог. По умолчанию создается символьная ссылка на файл."
@rem	"/H				Создает жесткую связь вместо символьной ссылки."
@rem	"/J				Создает соединение для каталога."
@rem	"Ссылка			Указывает имя новой символьной ссылки."
@rem	"Назначение		Указывает путь (относительный или абсолютный), на который ссылается новая ссылка."
