@Rem [ Author: [ Бурлачков Василий Александрович) ] ]
@echo off
setlocal EnableExtensions
setlocal EnableDelayedExpansion
set start=%date% %time% ***Starting PCTuneUP***
echo %start%
set Dir001=%userprofile%\AppData\Roaming\Microsoft\Windows\Recent
set Dir002=%temp%
set Dir003=%userprofile%\AppData\Local\Microsoft\Windows\WER\ReportArchive
set Dir004=%userprofile%\AppData\Local\Microsoft\Windows\WER\ReportQueue
set Dir005=%Systemroot%\Temp
set Dir006=C:\ProgramData\Microsoft\Windows\WER\ReportArchive
set Dir007=C:\ProgramData\Microsoft\Windows\WER\ReportQueue
set Dir008=%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\Content.IE5
set Dir009=C:\Windows\Downloaded Program Files
set Dir010=%userprofile%\AppData\LocalLow\Unity\Caches
set Dir011=%userprofile%\AppData\Local\Microsoft\Windows\INetCache\IE
set Dir012=%userprofile%\AppData\Local\Microsoft\Windows\INetCache\Virtualized
set Dir013=%userprofile%\AppData\Local\Microsoft\Windows\INetCache\Low
set Dir014=%userprofile%\AppData\Local\Microsoft\Windows\INetCache
set Dir015=%userprofile%\AppData\Local\Microsoft\Windows\History
set Dir016=C:\NVIDIA\DisplayDriver
set Dir017=C:\Program Files\NVIDIA Corporation\Installer2
set Dir018=C:\Program Files\NVIDIA Corporation\Installer
set Dir019=C:\Windows\SoftwareDistribution\Download
set Dir020=%userprofile%\Recent
@rem Если нужно избавиться от автозагрузки:
:: set Dir021=%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

@rem Эти две вывел в отдельный файл, здесь тоже задействованы.
@rem Используютя для очистки кеша иконок, если не отображаются либо отображаются не правильно
:: %userprofile%\AppData\Local\Microsoft\Windows\Explorer
:: %userprofile%\AppData\Local\Microsoft\Windows\Caches
:: set filetip=.db

@rem Сейчас занимает мало места, не чистил давно, но пусть будет в списке на всякий случай.
:: %userprofile%\AppData\Local\Microsoft\Windows\AppCache

@rem Про эти папки пишут, но у меня они не существуют.
:: %userprofile%\AppData\Local\Microsoft\Media Player\Кэш файлов графики\LocalMLS
:: C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Media Player\Кэш файлов графики\LocalMLS

@rem Сейчас занимает мало места, не чистил давно, но пусть будет в списке на всякий случай.
:: %userprofile%\AppData\Local\Microsoft\Windows\WebCache

@rem > Если потребуется удалять, по причинам: 
:: 1. освобождение места на диске (наврятли).
:: 2. сохранение приватности. (возможно, но...)
:: 3. хз.
:: %userprofile%\AppData\Local\speech
:: %userprofile%\AppData\Local\Microsoft\Speech
:: %userprofile%\AppData\Roaming\Microsoft\Speech
:: 
rem <

REM taskkill /F /IM %Explorer%
REM del /F /S /Q "%Dir005%\*%filetip%"
REM del /F /S /Q "%Dir006%\*%filetip%"
del /F /S /Q "%Dir001%\*.*"
del /F /S /Q "%Dir002%\*.*"
@rem del /F /S /Q "%Dir003%\*.*"
@rem del /F /S /Q "%Dir004%\*.*"
del /F /S /Q "%Dir005%\*.*"
@rem del /F /S /Q "%Dir006%\*.*"
@rem del /F /S /Q "%Dir007%\*.*"
del /F /S /Q "%Dir008%\*.*"
:: del /F /S /Q "%Dir009%\*.*"
del /F /S /Q "%Dir010%\*.*"
del /F /S /Q "%Dir011%\*.*"
del /F /S /Q "%Dir012%\*.*"
del /F /S /Q "%Dir013%\*.*"
del /F /S /Q "%Dir014%\*.*"
del /F /S /Q "%Dir015%\*.*"
:: del /F /S /Q "%Dir016%\*.*"
:: del /F /S /Q "%Dir017%\*.*"
:: del /F /S /Q "%Dir018%\*.*"
:: del /F /S /Q "%Dir019%\*.*"
del /F /Q "%Dir020%\*.*"
:: RMDIR /S /Q "%Dir016%"
:: RMDIR /S /Q "%Dir017%"
:: RMDIR /S /Q "%Dir018%"
:: mkdir "%Dir017%"
taskkill /F /t /IM dllhost.exe
taskkill /F /t /IM rundll32.exe
taskkill /F /IM explorer.exe
taskkill /f /im shellexperiencehost.exe
REM Clear Icon Cache
@cd /d %userprofile%\AppData\Local
@del /f /s /q IconCache.db
@del /f /s /q iconcache*
@del /f /s /q thumbcache*
cd /d %userprofile%\AppData\Local\Microsoft\Windows\Explorer
@timeout /t 1 >nul
del /f /s /q iconcache*
del /f /s /q thumbcache*
del /f /s /q *.tmp
cd /d %userprofile%\AppData\Local\Microsoft\Windows\Caches
@timeout /t 1 >nul
del /f /s /q *.db
@timeout /t 1 >nul
:: Restart Explorer
Explorer
:: start /SEPARATE explorer
@timeout /t 1 >nul
@rem "F:\ProgramFiles\_Desktop\Stardock\Fences\Fences.exe"
C:\Windows\system32\rundll32.exe "C:\Program Files (x86)\Stardock\Fences\FencesMenu64.dll",StartFencesAsUser
@rem 
"C:\Program Files (x86)\Stardock\Fences\Fences.exe" /FromDesktop
@rem 
@timeout /t 2 >nul
@rem taskkill /F /IM Fences.exe
Explorer /e,::{20D04FE0-3AEA-1069-A2D8-08002B30309D}
@timeout /t 1 >nul
@cd /D %~dp0
@call _Kill_Process\_Kill_CMD.cmd cmd.exe
endlocal
