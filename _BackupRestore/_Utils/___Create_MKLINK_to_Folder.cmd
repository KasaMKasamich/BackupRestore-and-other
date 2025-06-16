@Rem [ Author: [ Бурлачков Василий Александрович) ] ]
@echo on
@rem setlocal enableextensions enabledelayedexpansion
setlocal EnableExtensions
setlocal EnableDelayedExpansion
@chcp 65001>nul
@Title "Create MKLINK to Folder"
@rem chcp 1251 >nul
@rem chcp 1252 >nul
@rem chcp 866 >nul
@Rem []
@set Title="Create MKLINK to Folder"
@cd /D %~dp0
@rem @echo dp0 - %~dp0
@rem @echo p0 - %~p0
@rem @echo ps0 - %~ps0
@rem @echo n1 - %~n1
@rem @echo f1 - %~f1
@rem @echo dpf1 - %~dpf1
@cd /D ..\
@rem 
@echo cd - %cd%
@set ScriptsRootPath=%cd%
@set LogsDir=%ScriptsRootPath%\__Logs
@set CmdParametrString=%LogsDir%\CmdParametrString.txt
@rem 
@pause
@rem 
@rem SetPathDest ==============================================================
@Title "[SetPathDest]"
@rem 
:SetPathDest
@rem @echo 1 - %1
@rem @set "DestFolder=F:\Temp\_Test\Новая папка"
@cd /D "%1"
@set "DestFolder=%cd%"
echo %DestFolder%>"%CmdParametrString%"
@cd /D ..\
@rem @echo DestFolder - %DestFolder%
@rem @echo cd - %cd%
@rem 
@pause
@rem MKLINK /d /h /j "[] %~n1" %1
@set "Cmd=%ScriptsRootPath%\_Utils\_MKLINK\_Create_MKLINK_to_Folder.cmd"
@rem 
call %ScriptsRootPath%\_Utils\_RunAsAdmin.cmd %Cmd% "%DestFolder%"
@rem powershell -Command "Start-Process %Cmd% -Verb RunAs
@rem C:\_BackupRestore\_Utils\_MKLINK\_Create_MKLINK_to_Folder.cmd "F:\Temp\_Test\Новая папка"
@rem MKLINK /d "[] %~n1" %1
@rem 
@pause

@rem goto :EOF

:EOF
@rem @pause
@rem @timeout /t 1 >nul

:Exit
@rem pause
@rem	"MKLINK [[/D] | [/H] | [/J]] Ссылка Назначение"
@rem 
@rem	"/D				Создает символьную ссылку на каталог. По умолчанию создается символьная ссылка на файл."
@rem	"/H				Создает жесткую связь вместо символьной ссылки."
@rem	"/J				Создает соединение для каталога."
@rem	"Ссылка			Указывает имя новой символьной ссылки."
@rem	"Назначение		Указывает путь (относительный или абсолютный), на который ссылается новая ссылка."
@rem @echo Dir 1 - "%~dp1"
@rem @echo "FullPath =" %1
@rem @echo "FullPath, FileName, FileName&FileTip & FileTip =" (%1) (%~n1) (%~nx1) (%~x1)
@rem @echo (%BackUpTimeStamp02%)
@rem @echo %FileName%
@rem @echo "n1 =" "%Temp%\%~n1"
@rem @echo "n1 =" "%~n1"
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
