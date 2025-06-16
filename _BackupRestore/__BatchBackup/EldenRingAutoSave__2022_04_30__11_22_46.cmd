@rem @echo off
@Title "Elden Ring Auto Save Backup"
setlocal enableextensions
setlocal enabledelayedexpansion
@rem chcp 1251 >nul
@rem 
@chcp 1252 >nul
@rem chcp 866 >nul
@rem  Time
@set digit1=%time:~0,1%
@if "%digit1%"==" " (set digit1=0)
@set StartTimeStamp=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%digit1%%TIME:~1,1%_%TIME:~3,2%_%TIME:~6,2%
@set TimeStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@set DateStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!
set OnlyTimeStamp=!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@rem echo !digit1!!TIME:~1,1!
@rem 
@echo %StartTimeStamp%
@rem  7za
@set 7zaKeyString=-ssw -m0=LZMA2:d128m:fb256 -myx9 -mmt=8 -ms=off
@set 7zaKeyString2=-ssw -mmt=8 -ms=off
@set 7zaKeyString3=-ssw -mmt=8
@set 7za=%~dp0..\..\7z\1900\x64\7za.exe
@set Game=eldenring.exe
 
@rem set SteamId=76561197960267366
@rem  Папки
@set SavesDir=%AppData%\EldenRing
@for /d /r  "%SavesDir%" %%i in (*) do set SteamId=%%~nxi
 
@set BackupsDir=F:\Archive\SavedGameFiles\Elden Ring\_Saves_Backups\%SteamId%
@set AutoSavesDir=%BackupsDir%\Autosaves
@rem  File Names
@set FileName=%SteamId%
@set AutoSaveFileName=%TimeStamp%__%SteamId%
@set FileType=sl2
 
@echo [92m " =================================== End init =================================== " [0m 
 
rem  Self Backup
@set SelfBackupDir=%~dp0..\..\__BatchBackup
@copy /v /y %0 %SelfBackupDir%\%~n0__%TimeStamp%%~x0
 
@echo [92m " =================================== Create Backup Folder =================================== " [0m 
@if not exist "%BackupsDir%" mkdir "%BackupsDir%"
@if not exist "%AutoSavesDir%" mkdir "%AutoSavesDir%"
@timeout /t 1 >nul
 
:isGameRunning
@set TimeStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@set AutoSaveFileName=%TimeStamp%__%SteamId%
@rem echo "%TimeStamp%"
tasklist /FI "ImageName EQ %Game%" | Find /I "%Game%"
@if errorlevel 1 (
	@rem echo %Game% is not running
	@rem 
	goto CMDTimeout
	@rem goto End
) else (
	@rem echo %Game% is running
	goto AutoSavePack
)
 
:AutoSavePack
@echo [92m " =================================== Auto Save Pack  =================================== " [0m 
:: Получение даты и времени модификации файла:
:: FORFILES
:: @fsize   - возвращает размер файла в байтах.
:: @fdate   - возвращает дату последнего изменения файла.
:: @ftime   - возвращает время последнего изменения файла.
@rem FORFILES /P %SavesDir%\%SteamId% /M ER0000.sl2 /C "cmd /c echo fdate: @fdate
 
:: оператор_сравнения принимает следующие значения:
:: EQU - равно
:: NEQ - не равно
:: LSS - меньше
:: LEQ - меньше или равно
:: GTR - больше
:: GEQ - больше или равно,
 
@rem Текущая дата и время без секунд
@set "DateTimeStamp=%DATE:~-4%%DATE:~3,2%%DATE:~0,2%%digit1%%TIME:~1,1%%TIME:~3,2%"
@rem @echo DateTimeStamp: %DateTimeStamp%
@rem Сравнение даты и времени модификации файла с текущей датой и временем
@for %%i in ("%SavesDir%\%SteamId%\*.%FileType%") do (
	@for /f "tokens=1-5 delims=.: " %%j in ("%%~ti") do set "FileDateTimeStamp=%%l%%k%%j%%m%%n"
	@for /f "tokens=1-5 delims=.: " %%j in ("%%~ti") do (
		@rem @echo %%l%%k%%j%%m%%n
		@rem 
		echo "FileDateTimeStamp: %FileDateTimeStamp%"
		@rem       2022 04 29 17 19
		@if "%%l%%k%%j%%m%%n" lss "%DateTimeStamp%" (
			@rem !7za! u -r0 !7zaKeyString2! "%AutoSavesDir%\%AutoSaveFileName%.7z" "%SavesDir%\*" -w"%Temp%"
		)
	)
)
@timeout /t 1 >nul
@rem Если в "Планировщике заданий" в тригере не настроено "Повторять задачу каждые" Н минут, раскомментировать строку ниже.
@rem 
goto CMDTimeout
 
:End
@echo [92m " ========================================== End ========================================== " [0m 
@timeout /t 1 >nul
endlocal
@rem @pause
@rem 
exit /b
 
:CMDTimeout
@echo "!TimeStamp!"
@echo [92m " ========================================== is waiting 10 minutes ========================================== " [0m 
@timeout /t 600 >nul
@rem 
@rem 
goto isGameRunning
