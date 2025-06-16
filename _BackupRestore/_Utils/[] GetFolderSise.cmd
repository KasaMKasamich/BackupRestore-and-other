@echo on
@setlocal enableextensions enabledelayedexpansion
@chcp 65001>nul
@rem Чтобы не редактировать скрипты в будущем, если путь до файлов изменится, ниже вычисление корневой папки скриптов.
@cd /D %~dp0
@cd /D ..\
@echo cd - %cd%
@set ScriptsRootPath=%cd%
@rem ================================================================================================================
@rem [============][============][============]
@set LogsDir=%ScriptsRootPath%\__Logs
@set ListDir=%ScriptsRootPath%\__Lists
@set TempDir1=%ScriptsRootPath%\_Temp
@set UtilsDir=%ScriptsRootPath%\_Utils
@rem [============][============][============]
:BuildJS
@if exist "%Temp%\[]GetFolderSise.js" ( del /f /q "%Temp%\[]GetFolderSise.js" )
@if exist "%Temp%\tmpPath.txt" ( del /f /q "%Temp%\tmpPath.txt" )
@echo %1>%Temp%\tmpPath.txt
@FOR /F "usebackq delims=" %%F IN ("%Temp%\tmpPath.txt") DO ( @if not "%%~F" == "" (@set "sDirPath=%%~F") )
set "sDirPath=%sDirPath:\=/%"
echo "%sDirPath%"
@cd /d "%1"
@rem =================================================================================================================
@Echo var FSO = WScript.CreateObject("Scripting.FileSystemObject");>>%Temp%\[]GetFolderSise.js
@Echo Dir="%sDirPath%";>>%Temp%\[]GetFolderSise.js
@Echo var Folder = FSO.GetFolder(Dir);>>%Temp%\[]GetFolderSise.js
@Echo s="";>>%Temp%\[]GetFolderSise.js>>%Temp%\[]GetFolderSise.js
@Echo s+="Folder "+Folder;>>%Temp%\[]GetFolderSise.js
@Echo FolderSize = Folder.Size;>>%Temp%\[]GetFolderSise.js
@Echo TotalGb = Folder.Size/1024/1024/1024;>>%Temp%\[]GetFolderSise.js
@Echo FloatGb = TotalGb.toFixed(2);>>%Temp%\[]GetFolderSise.js
@Echo s+="\r\n";>>%Temp%\[]GetFolderSise.js
@Echo s+=" Folder Size: " +FloatGb+ " Gb ";>>%Temp%\[]GetFolderSise.js
@Echo s+="[ " +FolderSize+" bytes" + " ]" + "\r\n";>>%Temp%\[]GetFolderSise.js
@Echo WScript.Echo(s);>>%Temp%\[]GetFolderSise.js
@rem =================================================================================================================
:EOF
"%Temp%\[]GetFolderSise.js"
@if exist "%Temp%\[]GetFolderSise.js" ( del /f /q "%Temp%\[]GetFolderSise.js" )
rem @if exist "%Temp%\tmpPath.txt" ( del /f /q "%Temp%\tmpPath.txt" )
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