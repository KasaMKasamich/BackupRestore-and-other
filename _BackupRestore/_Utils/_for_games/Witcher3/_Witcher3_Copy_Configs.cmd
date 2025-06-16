@Rem [ Author: [ Бурлачков Василий Александрович) ] ]
@echo off
@rem setlocal enableextensions enabledelayedexpansion
setlocal EnableExtensions
setlocal EnableDelayedExpansion
@set DestinationFolder=../bin\config\r4game\user_config_matrix\pc\
@set ConfigDir=*\bin\config\r4game\user_config_matrix\pc
@Rem 
cd /D
@Rem "H:\Games\The Witcher 3 Wild Hunt\mods"
for /r %%a in (*.xml) do xcopy "%%a" "%DestinationFolder%" /H /Y /Z /K /E /C /R /S /I /EXCLUDE:_ExcludeList.txt
