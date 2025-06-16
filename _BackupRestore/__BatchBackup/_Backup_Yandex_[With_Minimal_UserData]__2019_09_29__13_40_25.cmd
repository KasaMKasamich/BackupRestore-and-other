:: User Data(Minimal)
@rem F:\_BackupRestore\_Backup_Yandex_[With_Minimal_UserData].cmd
@echo on
Title "User Data(Minimal) Backup"
setlocal enableextensions enabledelayedexpansion
@rem chcp 1251 >nul
@rem chcp 1252 >nul
@rem chcp 866 >nul
rem  Time
set digit1=%time:~0,1%
if "%digit1%"==" " (set digit1=0)
set TimeStamp=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%digit1%%TIME:~1,1%_%TIME:~3,2%_%TIME:~6,2%
rem  bool
set isAppRunning=2
rem int
set version=19.9.2.229
rem  7za
set 7zaKeyString=-ssw -m0=LZMA2:d128m:fb256 -myx9 -slp -mmt=64 -ms=off
set 7za=C:\_BackupRestore\7z\1900\x64\7za.exe
rem  Папки программы
set AppDataDir[0]=%userprofile%\AppData\Local\Yandex
set AppDataDir[1]=%userprofile%\AppData\Roaming\Yandex
set AppDataDir[2]=%userprofile%\AppData\LocalLow\Yandex
set AppDataDir[3]=%userprofile%\AppData\Local\Yandex\YandexBrowser
set AppDataDir[4]=C:\Program Files (x86)\Yandex\YandexBrowser
rem  Папки User Data
set UserDataDir=%userprofile%\AppData\Local\Yandex\YandexBrowser\User Data
set CustomUserDataDir=I:\ProgramFiles\_WebBrowserDatas\YandexBrowser
@rem \UserData
set BackupsDir=F:\Archive\_BackUps\Users\%USERNAME%\AppData\Local\Yandex\YandexBrowser
set TempBackupDir=C:\_BR
set LogsDir=%~dp0\__Logs
set ListDir=%~dp0\__Lists
rem  Files
set FileName[0]=YandexBrowser_UserData[Minimal]
set FileName[1]=YandexBrowser_[With_Minimal_UserData]
set LogFileName=_Backup_YandexBrowser_[With_Minimal_UserData]
set LogFile=%LogsDir%\%TimeStamp%_%LogFileName%.log
rem  File Lists
set 7z_List[0]=%ListDir%\7z_Yandex.txt"
set 7z_List[1]=%ListDir%\7z_R_ExcludeYandex.txt
set 7z_List[2]=%ListDir%\7z_YandexBrowser.txt
rem 
rem  Self Backup
copy /v /y %0 %~dp0__BatchBackup\%~n0__%TimeStamp%%~x0
echo [92m " =================================== End init =================================== " [0m 
rem 
:Pack
echo [92m " =================================== Pack, Step = %isStep%  =================================== " [0m 
cd /D %CustomUserDataDir%\UserData\
@rem for /f "usebackq delims=" %%A in (`dir /a:d /s /b *`) do ( If %%~zA LSS 1 if exist "%%~nxA" rd /q "%%~nxA" )
rem  FILES FOR CLEANING
del /F /S /Q *.tmp
del /F /S /Q *.log
del /F /S /Q *.dmp
@rem for /f "usebackq delims=;" %%A in (`dir /s /b *.*`) do ( If %%~zA LSS 1 del /f /s /q "%%A" )
@timeout /t 1 >nul
cd /D %userprofile%\AppData\LocalLow\
!7za! u -y !7zaKeyString! "%TempBackupDir%\TempYandex\Updater.7z" "%AppDataDir[2]%" -w"%Temp%"
cd /D %userprofile%\AppData\Local\Yandex\YandexBrowser\
!7za! u -y !7zaKeyString! "%TempBackupDir%\TempYandex\Application.7z" -w"%Temp%" @"%7z_List[2]%"
cd /D "C:\Program Files (x86)\Yandex\"
!7za! u -y !7zaKeyString! "%TempBackupDir%\TempYandex\Service_Update.7z" "%AppDataDir[4]%" -w"%Temp%"

cd /D %CustomUserDataDir%
!7za! u -y !7zaKeyString! "%TempBackupDir%\TempYandex\%FileName[0]%.7z" -w"%Temp%" @"!7z_List[0]!"

cd /D %TempBackupDir%\TempYandex\
!7za! u -y !7zaKeyString! "%TempBackupDir%\%FileName[1]%.7z" * -w"%Temp%"

cd /D %TempBackupDir%
@rem Rename & Move UserData
move /y "%TempBackupDir%\TempYandex\%FileName[0]%.7z" %TempBackupDir%
ren "%TempBackupDir%\%FileName[0]%.7z" "%TimeStamp%__%FileName[0]%.7z"
move /y "%TimeStamp%__%FileName[0]%.7z" %BackupsDir%

@rem Move YandexBrowser
move /y "TempYandex\"%TempBackupDir%\%FileName[1]%.7z" %BackupsDir%


rem !7za! u -y !7zaKeyString! "%TempBackupDir%\%TimeStamp%__%FileName[0]%.7z" -w"%Temp%" @"!7z_List[0]!"

rem xcopy %TimeStamp%_%FileName[0]%.7z %sTarget%\GetDirSize.vbs /R /Y /O /X
:End
echo [92m " ========================================== End ========================================== " [0m
@timeout /t 2 >nul
endlocal
rem @timeout /t 2 >nul
rem exit
@rem > ==============================================================================================
@rem > ===================================         Yandex         ===================================
@rem > ==============================================================================================
@rem Extension Rules
@rem Extension State
@rem Extensions
@rem Local Extension Settings
@rem Managed Extension Settings
@rem Sync Data
@rem Sync Extension Settings
@rem Web Applications
@rem 
@rem 
@rem Bookmarks.
@rem Cookies.
@rem Current Session.
@rem Current Tabs.
@rem Extension Cookies.
@rem History.
@rem Last Session.
@rem Last Tabs.
@rem Preferences.
@rem Secure Preferences.
@rem Tablo.
@rem Top Sites.
@rem Visited Links.
@rem Web Data.
@rem Ya Credit Cards.
@rem Ya Login Data.
@rem 
@rem 
@rem \UserData\
@rem configs\
@rem HibernateSnapshots\
@rem RescueTool\
@rem RescueToolReport\
@rem Resources\
@rem ui_config\
@rem YandexDictionaries\
@rem YandexOfflineSpellchecker\
@rem First Run.
@rem Last Version.
@rem < ==============================================================================================
