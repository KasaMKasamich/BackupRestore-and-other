@Title "Test Full Backup"
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
@rem 
echo %StartTimeStamp%
@rem  bool
set isStep=0
@rem  7za
set 7zaKeyString=-ssw -m0=LZMA2:d128m:fb256 -myx9 -mmt=8 -ms=off
set 7zaKeyString2=-ssw -mmt=8 -ms=off
set 7zaKeyString3=-ssw -mmt=8
set 7za=C:\_BackupRestore\7z\1900\x64\7za.exe
@rem  Папки
set Dir[0]=%userprofile%\AppData\LocalLow
set Dir[1]=%userprofile%\AppData\Local
set Dir[2]=%userprofile%\AppData\Roaming
set Dir[3]=C:\Users\Public
set Dir[4]=%ProgramFiles%
set Dir[5]=C:\Program Files (x86)
set Dir[6]=C:\ProgramData
set Dir[7]=F:\Temp\11111
echo [92m " =================================== End init =================================== " [0m 
rem  Self Backup
copy /v /y %0 C:\_BackupRestore\__BatchBackup\%~n0__%TimeStamp%%~x0
:: cd /D !Dir[%isStep%]!\
cd /D \
:: !7za! <x или e> "" -o"<путь, куда распаковываем>"
:: !7za! <x или e> "" -o"<путь, куда распаковываем>"
:: !7za! <x или e> "" -o"<путь, куда распаковываем>"
:: !7za! <x или e> "" -o"<путь, куда распаковываем>"
:: !7za! <x или e> "Program Files\*.7z" -o"!Dir[4]!"
:: !7za! <x или e> "" -o"<путь, куда распаковываем>"
:: !7za! <x или e> "" -o"<путь, куда распаковываем>"
!7za! x "Users\New\New.7z" -o"!Dir[7]!"
!7za! x "Users\New\AppData\Local\*.7z" -o"!Dir[7]!"
@pause





