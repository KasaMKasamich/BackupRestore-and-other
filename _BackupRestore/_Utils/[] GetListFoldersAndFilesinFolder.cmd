@echo off
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
@dir /a /b /o>"%ListDir%\GetListFoldersAndFilesinFolder.txt"