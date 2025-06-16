@echo off
SetLocal EnableExtensions EnableDelayedExpansion
set startbackup=%date% %time% ***Starting BackUp Files***
echo %startbackup%
:: chcp 1251 >nul
chcp 1252 >nul
:: echo %USERNAME%
set isAppRunning=0
set backuptool=7za.exe
set Dir001=%userprofile%\AppData\Local
set Dir002=%userprofile%\AppData\LocalLow
set Dir003=%userprofile%\AppData\Roaming
set Dir004=C:\Windows\SoftwareDistribution\Download
set BackupsDir=F:\Archive\_BackUps
set LogsDir=C:\_BackupRestore\__Logs
set FileName=TestBackup
set FileNameSec01=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%TIME:~0,2%_%TIME:~3,2%
set LogFile=%LogsDir%\%FileNameSec01%_%FileName%.log
set RoboCopyLogFile=%LogsDir%\%FileNameSec01%_%FileName%.txt
:: directories for cleaning
set DirToClean001=%userprofile%\Recent
set DirToClean002=%temp%
set DirToClean003=%userprofile%\AppData\Roaming\Microsoft\Windows\Recent
set DirToClean004=%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\Content.IE5
set DirToClean005=%userprofile%\AppData\LocalLow\Unity\Caches
set DirToClean006=%userprofile%\AppData\Local\Microsoft\Windows\INetCache\IE
set DirToClean007=%userprofile%\AppData\Local\Microsoft\Windows\INetCache\Virtualized
set DirToClean008=%userprofile%\AppData\Local\Microsoft\Windows\INetCache\Low
set DirToClean009=%userprofile%\AppData\Local\Microsoft\Windows\INetCache
set DirToClean010=%userprofile%\AppData\Local\Microsoft\Windows\History
:: set DirToClean011=%userprofile%\AppData\Local\Microsoft\Windows\WER\ReportArchive
:: set DirToClean012=%userprofile%\AppData\Local\Microsoft\Windows\WER\ReportQueue
:: set DirToClean013=%Systemroot%\Temp
:: set DirToClean014=C:\ProgramData\Microsoft\Windows\WER\ReportArchive
:: set DirToClean015=C:\ProgramData\Microsoft\Windows\WER\ReportQueue
:: set DirToClean016=C:\Windows\Downloaded Program Files
:: Start cleaning directories
del /F /S /Q "%DirToClean001%\*.*"
del /F /S /Q "%DirToClean002%\*.*"
del /F /S /Q "%DirToClean003%\*.*"
del /F /S /Q "%DirToClean004%\*.*"
del /F /S /Q "%DirToClean005%\*.*"
del /F /S /Q "%DirToClean006%\*.*"
del /F /S /Q "%DirToClean007%\*.*"
del /F /S /Q "%DirToClean008%\*.*"
del /F /S /Q "%DirToClean009%\*.*"
del /F /S /Q "%DirToClean010%\*.*"
:: 
set YandexBrowser=browser.exe
set appdir=C:\_BR\
set BackUpStoreDir=G:\Archive\Sys\_BackUps\%USERNAME%
set filetip=.tmp
set appdirYandexBrowser="%userprofile%\AppData\Local\Yandex\YandexBrowser\User Data\Default\"
set backupdirYandexBrowser="C:\_BR\Yandex\YandexBrowser\User Data\Default"
set appdirOperaBrowser="%userprofile%\AppData\Roaming\Opera Software\Opera Stable\"
set backupdirOperaBrowser="C:\_BR\Opera Software\Opera Stable"
set BrowserFile01="Bookmarks"
set BrowserFile02="Bookmarks.bak"
set BrowserFile03="Current Session"
set BrowserFile04="Current Tabs"
set BrowserFile05="Last Session"
set BrowserFile06="Last Tabs"
set BrowserFile07="Login Data"
set BrowserFile08="Login Data-journal"
set BrowserFile09="Password Checker"
set BrowserFile10="Password Checker-journal"
set BrowserFile11="Preferences"
set BrowserFile12="Tablo"
set BrowserFile13="Top Sites"
set BrowserFile14="Top Sites-journal"
set BrowserFile15="BookmarksExtras"
:: 
If NOT exist %backupdirYandexBrowser%\ (
 mkdir %backupdirYandexBrowser%
)
If NOT exist %backupdirOperaBrowser%\ (
 mkdir %backupdirOperaBrowser%
)

If NOT exist "%userprofile%\AppData\Local\Clover\" (
echo Not Exist 
) ELSE (
echo No
)
:: Watch Clover
:WatchClover
taskkill /F /IM %clover%
taskkill /F /IM %YandexBrowser%
tasklist /FI "ImageName EQ %clover%" | Find /I "%clover%"
if errorlevel 1 (
	echo %clover% is not running
	goto WatchBrowser
) else (
	echo %clover% is running
	goto WatchClover
)
:: Watch Browser
:WatchBrowser
tasklist /FI "ImageName EQ %YandexBrowser%" | Find /I "%YandexBrowser%"
if errorlevel 1 (
	echo %YandexBrowser% is not running
	goto COPYFILES
) else (
	echo %YandexBrowser% is running
	goto WatchClover
)
:COPYFILES
:: Удаление архивов
del /F /S /Q "C:\_BR\_backups\*.7z"
:: Удаление каталога Yandex
RMDIR /S /Q "C:\_BR\Yandex"
:: Копирование файлов YandexBrowser
mkdir %backupdirYandexBrowser%
cd /d %appdirYandexBrowser%
copy /Y %BrowserFile01% %backupdirYandexBrowser%\%BrowserFile01%
copy /Y %BrowserFile02% %backupdirYandexBrowser%\%BrowserFile02%
copy /Y %BrowserFile03% %backupdirYandexBrowser%\%BrowserFile03%
copy /Y %BrowserFile04% %backupdirYandexBrowser%\%BrowserFile04%
copy /Y %BrowserFile05% %backupdirYandexBrowser%\%BrowserFile05%
copy /Y %BrowserFile06% %backupdirYandexBrowser%\%BrowserFile06%
copy /Y %BrowserFile07% %backupdirYandexBrowser%\%BrowserFile07%
copy /Y %BrowserFile08% %backupdirYandexBrowser%\%BrowserFile08%
copy /Y %BrowserFile09% %backupdirYandexBrowser%\%BrowserFile09%
copy /Y %BrowserFile10% %backupdirYandexBrowser%\%BrowserFile10%
copy /Y %BrowserFile11% %backupdirYandexBrowser%\%BrowserFile11%
copy /Y %BrowserFile12% %backupdirYandexBrowser%\%BrowserFile12%
copy /Y %BrowserFile13% %backupdirYandexBrowser%\%BrowserFile13%
copy /Y %BrowserFile14% %backupdirYandexBrowser%\%BrowserFile14%

:: Удаление файлов с расширением .tmp и .7z
del /F /S /Q "%userprofile%\AppData\Local\Clover\*%filetip%"
del /F /S /Q "%userprofile%\AppData\Local\Clover\*.7z"
:: Удаление каталога Clover
RMDIR /S /Q "C:\_BR\Clover"
:: Создание каталога Clover
mkdir "C:\_BR\Clover\User Data\Default"
:: Копирование файлов Clover
ROBOCOPY "%userprofile%\AppData\Local\Clover" "C:\_BR\Clover" /S /ZB /R:3 /W:2 /SL /MT:32 /LOG:"%RoboCopyLogFile%" /XF "IconCache*" "*Cache*" "*.cookie" "*.LOG*" "*.tmp" /XD "Recent" "Report*" "Temporary*" "Caches" "*Cache*" "Temp" "*History*" /COPYALL /DCOPY:DAT /TBD

:: Удаление каталога Skyrim
RMDIR /S /Q "C:\_BR\Skyrim"
:: Создание каталога Skyrim
mkdir "C:\_BR\Skyrim"
:: Копирование файлов Skyrim
ROBOCOPY "%userprofile%\AppData\Local\Skyrim" "C:\_BR\Skyrim" /S /ZB /R:3 /W:2 /SL /MT:32 /LOG:"%RoboCopyLogFile%" /XF "IconCache*" "*Cache*" "*.cookie" "*.LOG*" "*.tmp" /XD "Recent" "Report*" "Temporary*" "Caches" "*Cache*" "Temp" "*History*" /COPYALL /DCOPY:DAT /TBD

:: Удаление файлов с расширением .tmp и .7z
del /F /S /Q "%userprofile%\AppData\Roaming\iSendSMS\*%filetip%"
del /F /S /Q "%userprofile%\AppData\Roaming\iSendSMS\*.7z"
:: Удаление каталога iSendSMS
RMDIR /S /Q "C:\_BR\iSendSMS"
:: Создание каталога iSendSMS
mkdir "C:\_BR\iSendSMS"
:: Копирование файлов iSendSMS
ROBOCOPY "%userprofile%\AppData\Roaming\iSendSMS" /S /ZB /R:3 /W:2 /SL /MT:32 /LOG:"%RoboCopyLogFile%" /COPYALL /DCOPY:DAT /TBD "C:\_BR\iSendSMS" /XF "IconCache*" /XD "Report*" "Temporary*" "*Cache*"

:: Удаление файлов с расширением .tmp и .7z
del /F /S /Q "%userprofile%\AppData\Roaming\NetSarang\*%filetip%"
del /F /S /Q "%userprofile%\AppData\Roaming\NetSarang\*.7z"
:: Удаление каталога NetSarang
RMDIR /S /Q "C:\_BR\NetSarang"
:: Создание каталога NetSarang
mkdir "C:\_BR\NetSarang"
:: Копирование файлов NetSarang
ROBOCOPY "%userprofile%\AppData\Roaming\NetSarang" /S /ZB /R:3 /W:2 /SL /MT:32 /LOG:"%RoboCopyLogFile%" /COPYALL /DCOPY:DAT /TBD "C:\_BR\NetSarang" /XF "IconCache*" /XD "Report*" "Temporary*" "*Cache*"

:: Удаление файлов с расширением .tmp и .7z
del /F /S /Q "%userprofile%\AppData\Roaming\Lunascape\*%filetip%"
del /F /S /Q "%userprofile%\AppData\Roaming\Lunascape\*.7z"
:: Удаление каталога Lunascape6
RMDIR /S /Q "C:\_BR\Lunascape"
:: Создание каталогов Lunascape6
mkdir "C:\_BR\Lunascape\Lunascape6\ApplicationData"
mkdir "C:\_BR\Lunascape\Lunascape6\Mode"
mkdir "C:\_BR\Lunascape\Lunascape6\Profile"
:: Копирование файлов Lunascape
cd /d "%userprofile%\AppData\Roaming\"
ROBOCOPY "Lunascape\Lunascape6\ApplicationData" /S /ZB /R:3 /W:2 /SL /MT:32 /LOG:"%RoboCopyLogFile%" /COPYALL /DCOPY:DAT /TBD "C:\_BR\Lunascape\Lunascape6\ApplicationData" /XF "IconCache*" /XD "Report*" "Temporary*" "*Cache*"
ROBOCOPY "Lunascape\Lunascape6\Mode" /S /ZB /R:3 /W:2 /SL /MT:32 /LOG:"%RoboCopyLogFile%" /COPYALL /DCOPY:DAT /TBD "C:\_BR\Lunascape\Lunascape6\Mode" /XF "IconCache*" /XD "Report*" "Temporary*" "*Cache*"
ROBOCOPY "Lunascape\Lunascape6\Profile" /S /ZB /R:3 /W:2 /SL /MT:32 /LOG:"%RoboCopyLogFile%" /COPYALL /DCOPY:DAT /TBD "C:\_BR\Lunascape\Lunascape6\Profile" /XF "IconCache*" /XD "Report*" "Temporary*" "*Cache*"

:: Удаление файлов с расширением .tmp и .7z
del /F /S /Q "%userprofile%\AppData\Roaming\Opera Software\*%filetip%"
del /F /S /Q "%userprofile%\AppData\Roaming\Opera Software\*.7z"
:: Удаление каталога Opera
RMDIR /S /Q "C:\_BR\Opera Software"
:: Создание каталога Opera
mkdir %backupdirOperaBrowser%
:: Копирование файлов Opera
cd /d %appdirOperaBrowser%
copy /Y %BrowserFile01% %backupdirOperaBrowser%\%BrowserFile01%
copy /Y %BrowserFile02% %backupdirOperaBrowser%\%BrowserFile02%
copy /Y %BrowserFile03% %backupdirOperaBrowser%\%BrowserFile03%
copy /Y %BrowserFile04% %backupdirOperaBrowser%\%BrowserFile04%
copy /Y %BrowserFile05% %backupdirOperaBrowser%\%BrowserFile05%
copy /Y %BrowserFile06% %backupdirOperaBrowser%\%BrowserFile06%
copy /Y %BrowserFile07% %backupdirOperaBrowser%\%BrowserFile07%
copy /Y %BrowserFile08% %backupdirOperaBrowser%\%BrowserFile08%
copy /Y %BrowserFile09% %backupdirOperaBrowser%\%BrowserFile09%
copy /Y %BrowserFile10% %backupdirOperaBrowser%\%BrowserFile10%
copy /Y %BrowserFile11% %backupdirOperaBrowser%\%BrowserFile11%
copy /Y %BrowserFile12% %backupdirOperaBrowser%\%BrowserFile12%
copy /Y %BrowserFile13% %backupdirOperaBrowser%\%BrowserFile13%
copy /Y %BrowserFile14% %backupdirOperaBrowser%\%BrowserFile14%
copy /Y %BrowserFile15% %backupdirOperaBrowser%\%BrowserFile15%
:: Создание папки _backups если такой нет
mkdir "C:\_BR\_backups\"
:: Подготовка к архивированию
cd /d "C:\_BackupRestore\7za"
@echo "%date% %time% ***Local Files***"
:: Создание папки если такой нет
mkdir %BackUpStoreDir%
:: Удаление архивов
:: del /F /Q "%BackUpStoreDir%\AppData\Local\YandexDataBackup.7z"
:: del /F /Q "%BackUpStoreDir%\AppData\Local\CloverDataBackup.7z"
:: del /F /Q "%BackUpStoreDir%\AppData\Local\SkyrimDataBackup.7z"
:: del /F /Q "%BackUpStoreDir%\AppData\Roaming\iSendSMSDataBackup.7z"
:: del /F /Q "%BackUpStoreDir%\AppData\Roaming\NetSarangDataBackup.7z"
:: del /F /Q "%BackUpStoreDir%\AppData\Roaming\LunascapeDataBackup.7z"
:: del /F /Q "%BackUpStoreDir%\AppData\Roaming\OperaDataBackup.7z"
:: del /F /Q "%BackUpStoreDir%\_LastDesktopBackup.7z"
:: Удаление файлов с расширением .tmp и .7z
del /F /S /Q "%prebackupdir%*%filetip%"
del /F /S /Q "C:\_BR\_backups\*.7z"
:: Архивация
@timeout 5
:: Yandex
Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\Local\YandexDataBackup.7z" "C:\_BR\Yandex\"
Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\Local\Yandex\YandexBrowser\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_YandexDataBackup.7z" "C:\_BR\Yandex\"
:: Clover
Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\Local\CloverDataBackup.7z" "C:\_BR\Clover\"
Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\Local\Clover\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_CloverDataBackup.7z" "C:\_BR\Clover\"
:: Skyrim
Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\Local\SkyrimDataBackup.7z" "C:\_BR\Skyrim\"
Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\Local\Skyrim\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_SkyrimDataBackup.7z" "C:\_BR\Skyrim\"

@echo "%date% %time% ***Roaming Files***"
:: iSendSMS
Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\Roaming\iSendSMSDataBackup.7z" "C:\_BR\iSendSMS\"
Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\Roaming\iSendSMS\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_iSendSMSDataBackup.7z" "C:\_BR\iSendSMS\"
:: NetSarang
Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\Roaming\NetSarangDataBackup.7z" "C:\_BR\NetSarang\"
Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\Roaming\NetSarang\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_NetSarangDataBackup.7z" "C:\_BR\NetSarang\"
:: Lunascape
Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\Roaming\LunascapeDataBackup.7z" "C:\_BR\Lunascape\"
Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\Roaming\Lunascape\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_LunascapeDataBackup.7z" "C:\_BR\Lunascape\"
:: Opera
Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\Roaming\OperaDataBackup.7z" "C:\_BR\Opera Software\"
Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\Roaming\Opera Software\Opera Stable\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_OperaDataBackup.7z" "C:\_BR\Opera Software\"
@echo "%date% %time% ***End BackUp Local & Roaming Files***"
@echo "%date% %time% ***Desktop Files***"
:: Desktop
Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\_LastDesktopBackup.7z" "%userprofile%\Desktop\"
Start /B 7za.exe u -ssw -mx9 "C:\_BR\_backups\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_DesktopBackup.7z" "%userprofile%\Desktop\"
@echo "%date% %time% ***End BackUp Desktop Files***"
:: Watch 7za
:WatchBackUp
tasklist /FI "ImageName EQ %backup%" | Find /I "%backup%"
if errorlevel 1 (
	echo %backup% is not running
	goto COPYFILES2
) else (
	echo %backup% is running
	goto WatchBackUp
)
:COPYFILES2
:: Копирование архивов Бекапа.
ROBOCOPY "C:\_BR\_backups" /S /ZB /R:3 /W:2 /SL /MT:32 /LOG:"%RoboCopyLogFile%" /COPYALL /DCOPY:DAT /TBD "%BackUpStoreDir%\AppData" /XF "IconCache*" /XD "Report*" "Temporary*" "*Cache*"
@timeout 3
:: Удаление файлов с расширением .7z
del /F /S /Q "C:\_BR\_backups\*.7z"
@echo Done.
@timeout 3
@goto end

:error
@echo "*** Switch was NOT sucessfull. ***"
@timeout 3
goto WatchClover

:end
:: Удаление каталогов
RMDIR /S /Q "C:\_BR\Yandex"
RMDIR /S /Q "C:\_BR\Opera Software"
RMDIR /S /Q "C:\_BR\Lunascape"
RMDIR /S /Q "C:\_BR\Clover"
RMDIR /S /Q "C:\_BR\Skyrim"
RMDIR /S /Q "C:\_BR\iSendSMS"
RMDIR /S /Q "C:\_BR\NetSarang"
:: wait
@rem @timeout 3
@rem exit
