@Rem [ Author: [ Бурлачков Василий Александрович) ] ]
@echo on
setlocal enableextensions enabledelayedexpansion
@chcp 65001>nul
@rem Чтобы не редактировать скрипты в будущем, если путь до файлов изменится, ниже вычисление корневой папки скриптов.
@cd /D %~dp0
@cd /D ..\
@echo cd - %cd%
@set ScriptsRootPath=%cd%
@rem ================================================================================================================
@rem  7za
set 7zaKeyString=-ssw -m0=LZMA2:d128m:fb256 -myx9 -mmt=8 -ms=off
set 7zaKeyString2=-ssw -mmt=8 -ms=off
set 7zaKeyString3=-ssw -mmt=8
set 7zaKeyString4=-ssw -mmt=8 -mx9 -ms=off
@rem set 7za=%~dp0\7z\1900\x64\7za.exe
if /i "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
	@set 7za=%ScriptsRootPath%\7za\x64\7za.exe
) else (
	@set 7za=%ScriptsRootPath%\7za\7za.exe
)
@rem ================================================================================================================
@rem  RAR
set winrar=%ScriptsRootPath%\WinRAR\winrar.exe
set RARKeysString=-dh -ed -md128m -m5 -qo+ -rr5p -y
set RARKeysString2=-dh -ed -md128m -m0 -qo+ -rr5p -y
set RARKeysString3=-dh -ed -md512m -m5 -qo+ -rr5p -y
set RARKeysString4=-dh -ed -md512m -m0 -qo+ -rr5p -y
set RARKey1=-ep1
set RARKey2=-ep2
@rem Запустить как фоновый процесс.
set RARKey3=-ibck
set RARDateTimeStampKeyString=-ag_[YYYY.MM.DD__HH_MM_SS]
@rem ================================================================================================================
@Rem === RoboCopy ===
@set RCLogFile=%LogsDir%\_ROBOCOPY\%DateTimeStamp%_ROBOCOPY.txt
@if not exist "%LogsDir%\_ROBOCOPY" mkdir "%LogsDir%\_ROBOCOPY"
@set RCParams=/S /ZB /R:3 /W:2 /SL /MT:8 /XA:sh
@set RCParams2=/S /ZB /R:3 /W:2 /SL /MT:8
@set RCParams3=/S /B /Z /R:3 /W:2 /SL /MT:8
@rem ================================================================================================================
@cd /D "%1"
@cd /D ..\
@echo "%1"
@echo "%cd%"
@echo End init
@if not exist "%cd%\[] Decrypted" mkdir "%cd%\[] Decrypted\"
@cd /D "%1"
takeown.exe /f "*" /r /d y
icacls.exe "*" /reset /T
@cd /D ..\
rem 
ROBOCOPY "%1" "[] Decrypted" %RCParams3%
rem 
%winrar% a -r %RARKey1% %RARKey3% %RARKeysString2% "%~n1.rar" %1\*
rem 
%winrar% x "%~n1.rar" "[] Decrypted\"
rem 
takeown.exe /f "[] Decrypted" /r /d y
icacls.exe "[] Decrypted" /reset /T

:EOF

@rem 
@pause

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