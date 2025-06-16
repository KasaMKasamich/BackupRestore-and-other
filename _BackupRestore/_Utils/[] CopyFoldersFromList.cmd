@echo on
@setlocal enableextensions enabledelayedexpansion
@chcp 65001>nul
@rem Чтобы не редактировать скрипты в будущем, если путь до файлов изменится, ниже вычисление корневой папки скриптов.
@cd /D %~dp0
@cd /D ..\
@echo cd - %cd%
@set ScriptsRootPath=%cd%
@rem ================================================================================================================
@set ListDir=%ScriptsRootPath%\__Lists
@cd /d "%1"
set "psCommandSourceFolder="(new-object -COM 'Shell.Application').BrowseForFolder(0,'Please choose a source folder.',0,0).self.path""
set "psCommandDestFolder="(new-object -COM 'Shell.Application').BrowseForFolder(0,'Please choose a destination folder.',0,0).self.path""

for /f "usebackq delims=" %%I in (`powershell %psCommandSourceFolder%`) do set "SourceFolder=%%I"

if /i "%SourceFolder%"=="" Exit

for /f "usebackq delims=" %%I in (`powershell %psCommandDestFolder%`) do set "DestFolder=%%I"

echo %SourceFolder%
echo %DestFolder%

if /i "%DestFolder%"=="" Exit

for /f "tokens=*" %%i in (%ListDir%\GetListFoldersAndFilesinFolder.txt) DO (
    xcopy /S/V/Z/I/Y "%%i" "%DestFolder%\%%i"
)

rem @del /Q %ListDir%\GetListFoldersAndFilesinFolder.txt