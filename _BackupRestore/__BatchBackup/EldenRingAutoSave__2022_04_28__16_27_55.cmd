@echo off
@Title "Elden Ring Auto Save Backup"
setlocal enableextensions
setlocal enabledelayedexpansion
@rem chcp 1251 >nul
@rem 
chcp 1252 >nul
@rem chcp 866 >nul
@rem  Time
set digit1=%time:~0,1%
if "%digit1%"==" " (set digit1=0)
set StartTimeStamp=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%digit1%%TIME:~1,1%_%TIME:~3,2%_%TIME:~6,2%
set TimeStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
set DateStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!
set OnlyTimeStamp=!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@rem echo !digit1!!TIME:~1,1!
@rem 
echo %StartTimeStamp%
@rem  7za
set 7zaKeyString=-ssw -m0=LZMA2:d128m:fb256 -myx9 -mmt=8 -ms=off
set 7zaKeyString2=-ssw -mmt=8 -ms=off
set 7zaKeyString3=-ssw -mmt=8
set 7za=%~dp0..\..\7z\1900\x64\7za.exe
set Game=eldenring.exe
 
@rem set SteamId=76561197960267366
@rem  Папки
set SavesDir=%AppData%\EldenRing
for /d /r  "%SavesDir%" %%i in (*) do set SteamId=%%~nxi
 
set BackupsDir=F:\Archive\SavedGameFiles\Elden Ring\_Saves_Backups\%SteamId%
set AutoSavesDir=%BackupsDir%\Autosaves
@rem  File Names
set FileName=%SteamId%
set AutoSaveFileName=%TimeStamp%__%SteamId%
 
echo [92m " =================================== End init =================================== " [0m 
 
rem  Self Backup
set SelfBackupDir=%~dp0..\..\__BatchBackup
copy /v /y %0 %SelfBackupDir%\%~n0__%TimeStamp%%~x0
@rem if exist C:\_BackupRestore ( copy /v /y %0 C:\_BackupRestore\__BatchBackup\%~n0__%TimeStamp%%~x0 )
 
echo [92m " =================================== Create Backup Folder =================================== " [0m 
if not exist "%BackupsDir%" mkdir "%BackupsDir%"
if not exist "%AutoSavesDir%" mkdir "%AutoSavesDir%"
@timeout /t 1 >nul
 
:isGameRunning
@rem set /a NextTime=!TIME:~3,2!+10
tasklist /FI "ImageName EQ %Game%" | Find /I "%Game%"
if errorlevel 1 (
	@rem echo %Game% is not running
	@rem 
	goto CMDTimeout
	@rem goto End
) else (
	@rem echo %Game% is running
	goto AutoSavePack
)
 
:AutoSavePack
echo [92m " =================================== Auto Save Pack  =================================== " [0m 
@rem cd /D %SavesDir%\
!7za! u -r0 !7zaKeyString2! "%AutoSavesDir%\%AutoSaveFileName%.7z" "%SavesDir%\*" -w"%Temp%"
@timeout /t 1 >nul
@rem Если в "Планировщике заданий" в тригере не настроено "Повторять задачу каждые" Н минут, раскомментировать строку ниже.
@rem 
goto CMDTimeout
 
:End
echo [92m " ========================================== End ========================================== " [0m 
@timeout /t 1 >nul
endlocal
@rem @pause
@rem 
exit /b
 
:CMDTimeout
echo [92m " ========================================== is waiting 10 minutes ========================================== " [0m 
@timeout /t 600
@rem  >nul
@rem 
goto isGameRunning
