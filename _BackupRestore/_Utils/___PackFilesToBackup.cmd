@echo on
@setlocal enableextensions enabledelayedexpansion
@set 7zaKeyString=-ssw -m0=LZMA2:d128m:fb256 -myx9 -mmt=8 -ms=off
@set 7zaKeyString2=-ssw -mmt=8 -ms=off
@set 7zaKeyString3=-ssw -mmt=8
@set 7zaKeyString4=-ssw -mmt=8 -mx9 -ms=off
@rem Чтобы не редактировать скрипты в будущем, если путь до файлов изменится, ниже вычисление корневой папки скриптов.
@cd /D %~dp0
@cd /D ..\
@echo cd - %cd%
@set ScriptsRootPath=%cd%
@rem ================================================================================================================
@echo 1 - %1
@echo 1 - "%*"
if /i "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
	@set 7za=%ScriptsRootPath%\7za\x64\7za.exe
) else (
	@set 7za=%ScriptsRootPath%\7za\7za.exe
)
@rem Time
@set digit1=%time:~0,1%
@if "%digit1%"==" " (@set digit1=0)
@set BackUpTimeStamp01=!DATE:~-4!.!DATE:~3,2!.!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!
@set BackUpTimeStamp02=!DATE:~-4!.!DATE:~3,2!.!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@set TimeStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@set DateStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!
@set OnlyTimeStamp=!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@rem @echo cd - %cd%
@rem 
@set FileName=%~n1 (%BackUpTimeStamp02%)
@set OutputDir=%~dp1
@set SourceScriptTarget="%*"
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
@chcp 65001>nul
@rem @echo Архитектура процессора - %PROCESSOR_ARCHITECTURE%
@rem @echo ОС - %OS%
@chcp 866>nul
@cd /D %~dp1
@rem !7za! a -ttar "!OutputDir!\!FileName!.tar" null
call !7za! u -r0 !7zaKeyString4! "!OutputDir!\!FileName!.7z" "%SourceScriptTarget%" -w"%Temp%"
"%~dp0/[]-Echo-[Archive_Packed].js"
@rem @pause

@rem @echo Dir 1 - "%~dp1"
@rem @echo "FullPath =" %1
@rem @echo "FullPath, FileName, FileName&FileTip & FileTip =" (%1) (%~n1) (%~nx1) (%~x1)
@rem @echo (%BackUpTimeStamp02%)
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