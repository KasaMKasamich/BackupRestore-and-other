@echo on
@setlocal enableextensions enabledelayedexpansion
@Title "RimWorld Configs BackUp"
@set Title="RimWorld Configs BackUp"
setlocal enableextensions enabledelayedexpansion
@rem 
@cd /D %~dp0
@cd /D ..\..\
@rem 
@echo cd - %cd%
@set ScriptsRootPath=%cd%
@set LogsDir=%ScriptsRootPath%\__Logs
@set ListDir=%ScriptsRootPath%\__Lists
@set TempDir1=%ScriptsRootPath%\_Temp
@set UtilsDir=%ScriptsRootPath%\_Utils
@rem 
@set DestFolder=I:\Users\New\Pictures
@set RCParams=/S /ZB /R:3 /W:2 /SL /MT:8 /XA:sh
@set RCParams2=/S /ZB /R:3 /W:2 /SL /MT:8
@set RCParams3=/S /B /Z /R:3 /W:2 /SL /MT:8
@rem 
@set RCFileDataFlags=/DCOPY:DAT
@set RCFileDataFlags2=/COPYALL /DCOPY:DAT
@rem 
@set 7z_IncludeFiles=%ListDir%\Include\7z_R_Include_ScreenShots.txt
@rem 
@rem ScreenShot

:ROBOCOPY
@rem ROBOCOPY "!SourceFolder!" "!DestFolder!\%~p0" %RCParams3% %RCFileDataFlags%

REM Копирование дерева папок
@rem xcopy "%SourceDir001%" "%DestinationFolder%" /Y /Z /K /E /T

@rem 
@pause

@rem ROBOCOPY "Источник" "Назначение" /S /B /R:3 /W:2 /SL /MT:8 /DCOPY:DAT
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




