@echo on
@setlocal enableextensions enabledelayedexpansion
@Title "RimWorld Configs BackUp"
@set Title="RimWorld Configs BackUp"
@rem 
@set 7zaKeyString=-ssw -m0=LZMA2:d128m:fb256 -myx9 -mmt=8 -ms=off
@set 7zaKeyString2=-ssw -mmt=8 -ms=off
@set 7zaKeyString3=-ssw -mmt=8
@set 7zaKeyString4=-ssw -mmt=8 -mx9 -ms=off
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
@set 7z_ExcludeRecurseFiles=%ListDir%\ExcludeRecurse\7z_R_ExcludeFiles_RimWorld.txt
@rem 
@set SourceBackupsDir=C:\Users\new\AppData\LocalLow\Ludeon Studios\RimWorld by Ludeon Studios
@set BackupsDir=F:\Archive\SavedGameFiles\RimWorld\LocalLow\Ludeon Studios\RimWorld by Ludeon Studios
@set FileName=Config (%BackUpTimeStamp02%)
@rem 
@rem @echo ------------------------------------------------------------------------
@rem @echo !7za! u -r0 !7zaKeyString4!
@rem @echo BackupsDir - "!BackupsDir!\!FileName!.7z"
@rem @echo SourceBackupsDir - %SourceBackupsDir%
@rem @echo 7z_ExcludeRecurseFiles - !7z_ExcludeRecurseFiles!
@rem @echo ------------------------------------------------------------------------
@cd /D "%SourceBackupsDir%"
call !7za! u -r0 !7zaKeyString4! "!BackupsDir!\!FileName!.7z" "!SourceBackupsDir!\*" -w"%Temp%" -xr@"!7z_ExcludeRecurseFiles!"
@rem 
"%UtilsDir%/[]-Echo-[Archive_Packed].js"
