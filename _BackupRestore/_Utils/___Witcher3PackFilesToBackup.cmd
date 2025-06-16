@Rem [ Author: [ Бурлачков Василий Александрович) ] ]
@echo off
@rem setlocal enableextensions enabledelayedexpansion
setlocal EnableExtensions
setlocal EnableDelayedExpansion
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
@set BackupOutputDir=%Letter%\Archive\SavedGameFiles\%GameName%\_W3_Mods\%GameVersion%
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
		!7za! u -r0 !7zaKeyString4! "!BackupOutputDir!\!FileName!.7z" "%%L" -w"%Temp%" -xr@!List_ExcludeFiles_7z!
	)
)
@rem 
!7za! d -y "!BackupOutputDir!\!FileName!.7z" "Witcher Script Merger\*.txt" -r
@goto :EOF

:Message01
@chcp 65001>nul
@echo %_Normal_Red% " Целью бекапа должна быть папка. " %_col_off%
@chcp 866>nul
@rem 
@pause
@rem 
@goto :EOF

:Message02
@chcp 65001>nul
@echo %_Normal_Red% " Целью бекапа должна быть папка mods. " %_col_off%
@chcp 866>nul
@rem 
@pause
@rem 
@goto :EOF

:EOF
@del /F /S /Q %TempFile01%
@del /F /S /Q "%List_7z%"
del /f /q %temp%\tmpLetter.txt
del /f /q %temp%\Letter.txt
@rem 
"%~dp0/[]-Echo-[Archive_Packed].js"

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
@rem 