@Title "Restore Backup"
setlocal enableextensions
setlocal enabledelayedexpansion
@rem 
chcp 1251 >nul
@rem chcp 1252 >nul
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
@rem  7za
set 7za=C:\_BackupRestore\7z\1900\x64\7za.exe
@rem Папки
set Dir[0]=%userprofile%\AppData\LocalLow
set Dir[1]=%userprofile%\AppData\Local
set Dir[2]=%userprofile%\AppData\Roaming
set Dir[3]=C:\Users\Public
set Dir[4]=%ProgramFiles%
set Dir[5]=C:\Program Files (x86)
set Dir[6]=C:\ProgramData
:: set Dir[7]=F:\Temp\11111
@rem DriveLetter
set DestFolderPart=Archive\_BackUps\_BackupsArchive
set sDriveLetter=
set sCmd=wmic volume where "label='Archive'" get DriveLetter
echo [92m " =================================== End init =================================== " [0m 

@rem ======================================================================
call %sCmd%>%temp%\tmpDriveLetter.txt
powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt)[1].Trim()">%temp%\fDriveLetter.txt

powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt)[0,1].Trim()"

FOR /F "usebackq delims=" %%A IN ("%temp%\fDriveLetter.txt") DO ( if not "%%~A" == "" (@set "sDriveLetter=%%~A") )

@rem  Проверить пустая переменная или нет, если да то выход >>>>>>>>>>>>>>>>>>>>>>>>>> >>
@if "%sDriveLetter%" == "" (
	echo DriveLetter not found
	exit /b
)
@rem  << <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

set DestinationFolder=%sDriveLetter%\%DestFolderPart%
echo %DestinationFolder%
@rem @pause

del /f /q %temp%\tmpDriveLetter.txt
del /f /q %temp%\fDriveLetter.txt
@rem ======================================================================

echo [92m " Сначала надо изменить буквы дисков. Запуск compmgmt.msc " [0m 
compmgmt.msc
@rem @pause
@rem ======================================================================
:CheckDisks
if exist F:\ (
	if exist I:\ (
		if exist H:\ (
			goto :Exist
		)
	)
) else (
	goto :CheckDisks
)
@rem ======================================================================
:Exist
cd /D %~dp0\
if not exist C:\_BackupRestore ( cmd /c %sDriveLetter%\_BackupRestore\_MKLINK\___MKLINK_BackupRestore.cmd )
@rem Self Backup
if exist C:\_BackupRestore ( copy /v /y %0 C:\_BackupRestore\__BatchBackup\%~n0__%TimeStamp%%~x0 )
@rem ======================================================================
:: xcopy F:\_RestoreWin\7-Zip "!Dir[4]!" /Y /Z /K /E
@rem ======================================================================
:: cmd /c C:\_BackupRestore\_Utils\_AddUsers.cmd
cmd /c "C:\_BackupRestore\_Utils\_AddSilentUser (netuser).cmd"
cmd /c C:\_BackupRestore\_Utils\_SysSettings.cmd
@rem ======================================================================
echo [92m " Сначала надо изменить в редакторе локальной групповой политики параметр. Запуск Gpedit.msc " [0m 
echo [92m " Шаг 1. В редакторе локальной групповой политики перейдите в следующую папку: " [0m 
echo [92m " Конфигурация пользователя > Административные шаблоны > Меню «Пуск» и панель задач. " [0m 
echo [92m " Шаг 2: В правой части окна дважды щелкните Start Layout (Макет начального экрана) и выбрать включено. " [0m 
echo [92m " После импорта макета нужно выбрать 'Отключено', иначе не получится изменить начальный экран. " [0m 
echo [92m " ==================================================================================== " [0m 
echo [92m " Также необходимо включить очистку файла подкачки после завершения работы или перезагрузки компьютера: " [0m 
echo [92m " Конфигурация компьютера > Параметры Windows > Параметры безопасности > Локальные политики > Параметры безопасности. " [0m 
echo [92m " Параметр - 'Завершение работы: очистка файла подкачки виртуальной памяти'. " [0m 
@rem Gpedit.msc
@rem @pause
@rem powershell -Command Import-StartLayout -LayoutPath "Users\%USERNAME%\DefaultLayouts.xml" -MountPath C:\
@rem powershell -Command Import-StartLayout -LayoutPath "F:\Archive\_BackUps\_BackupsArchive\2022_04_14__09_12_36_New_Backup_Full\Users\New\DefaultLayouts.xml" -MountPath C:\
@rem taskkill /F /T /IM Explorer.exe
@rem @timeout /t 3 >nul
@rem explorer
@rem ======================================================================
cmd /c C:\_BackupRestore\_ImportTasks\ImportTaskBackUpFull.cmd
@rem cmd /c "%sDriveLetter%\Archive\Sys1\Drivers\VC_Redist\Install_all.cmd"
@rem 
@rem @chcp 1251 >nul
@rem start /WAIT "%sDriveLetter%\Archive\Sys1\Drivers\DirectX\12\dxwebsetup.exe"
@rem ======================================================================
@rem start /WAIT "%sDriveLetter%\Archive\_ReinstallApps\Обзор\Yandex\Yandex.exe"
@rem xcopy "!Dir[1]!\Yandex" "!Dir[5]!" /Y /Z /K /E
@rem del /F /S /Q "!Dir[5]!\Yandex\YaPin\"
@rem del /F /S /Q "!Dir[5]!\Yandex\YaPinIcons\"
@rem %sDriveLetter%\ProgramFiles\Sys\NirCMD\nircmd.exe shortcut "C:\Program Files (x86)\Yandex\YandexBrowser\Application\browser.exe" ~$folder.desktop$" "Yandex" ""%"YandexBrowserSwitches"%"" "C:\Program Files (x86)\Yandex\YandexBrowser\Application\browser.exe" 0
@rem %sDriveLetter%\ProgramFiles\Sys\NirCMD\nircmd.exe shortcut "C:\Program Files (x86)\Yandex\YandexBrowser\Application\browser.exe" ~$folder.desktop$" "Yandex" "-incognito --save-page-as-mhtml" "C:\Program Files (x86)\Yandex\YandexBrowser\Application\browser.exe" 0
@rem MOVE /Y "Program Files (x86)\SkypeForDesktop_x86.7z" SkypeForDesktop_x86.7z
@rem ======================================================================
!7za! x "Users\New\AppData\LocalLow\*.7z" -y -o"!Dir[0]!"
!7za! x "Users\New\AppData\Local\*.7z" -y -o"!Dir[1]!"
!7za! x "Users\New\AppData\Roaming\*.7z" -y -o"!Dir[2]!"
!7za! x "Users\Public\*.7z" -y -o"!Dir[3]!"
!7za! x "Program Files\*.7z" -y -o"!Dir[4]!"
!7za! x "Program Files (x86)\*.7z" -y -o"!Dir[5]!"
!7za! x "Program Files (x86)\SkypeForDesktop_x86.7z" -y -o"!Dir[5]!"
!7za! x "ProgramData\*.7z" -y -o"!Dir[6]!"
@rem ======================================================================
!7za! x "Users\New\New.7z" -y -o"!userprofile!"
@rem ======================================================================
@rem MOVE /Y SkypeForDesktop_x86.7z "Program Files (x86)\SkypeForDesktop_x86.7z"
@rem ======================================================================
:: Пример регистрации dll библиотек, если потребуется.
::	regsvr32.exe "C:\путь до папки\файл.dll"
@rem ======================================================================
explorer "%sDriveLetter%\Archive\_ReinstallApps"
explorer "%sDriveLetter%\Archive\Sys1\Drivers"
echo [92m " ========================================== End ========================================== " [0m 
goto :End
@rem ======================================================================
:NotExist
echo [92m " Сначала надо изменить буквы дисков " [0m 
@rem ======================================================================
:End
@pause
exit /b
