@echo off
cls
@echo "%date% %time% ***Starting BackUp Files***"

taskkill /IM Clover.exe
REM wait
timeout 3
@mkdir "C:\_BR\Yandex\YandexBrowser\User Data\Default"
@cd /d "C:\Users\KasaM\AppData\Local\Yandex\YandexBrowser\User Data\Default\"
@copy /Y "Bookmarks" "C:\_BR\Yandex\YandexBrowser\User Data\Default\Bookmarks"
@if errorlevel 1 goto error
@copy /Y "Bookmarks.bak" "C:\_BR\Yandex\YandexBrowser\User Data\Default\Bookmarks.bak"
@if errorlevel 1 goto error
@copy /Y "Current Session" "C:\_BR\Yandex\YandexBrowser\User Data\Default\Current Session"
@if errorlevel 1 goto error
@copy /Y "Current Tabs" "C:\_BR\Yandex\YandexBrowser\User Data\Default\Current Tabs"
@if errorlevel 1 goto error
@copy /Y "Last Session" "C:\_BR\Yandex\YandexBrowser\User Data\Default\Last Session"
@if errorlevel 1 goto error
@copy /Y "Last Tabs" "C:\_BR\Yandex\YandexBrowser\User Data\Default\Last Tabs"
@if errorlevel 1 goto error
@copy /Y "Login Data" "C:\_BR\Yandex\YandexBrowser\User Data\Default\Login Data"
@if errorlevel 1 goto error
@copy /Y "Login Data-journal" "C:\_BR\Yandex\YandexBrowser\User Data\Default\Login Data-journal"
@if errorlevel 1 goto error
@copy /Y "Web Data" "C:\_BR\Yandex\YandexBrowser\User Data\Default\Web Data"
@if errorlevel 1 goto error
@copy /Y "Web Data-journal" "C:\_BR\Yandex\YandexBrowser\User Data\Default\Web Data-journal"
@if errorlevel 1 goto error

@mkdir "C:\_BR\Clover\User Data\Default"
@cd /d "C:\Users\KasaM\AppData\Local\"
@ROBOCOPY "C:\Users\KasaM\AppData\Local\Clover" /E /Z /R:3 /W:2 "C:\_BR\Clover"

@mkdir "C:\_BR\Skyrim"
@cd /d "C:\Users\KasaM\AppData\Local\"
@ROBOCOPY "C:\Users\KasaM\AppData\Local\Skyrim" /E /Z /R:3 /W:2 "C:\_BR\Skyrim"

@mkdir "C:\_BR\iSendSMS"
@cd /d "C:\Users\KasaM\AppData\Roaming\"
@ROBOCOPY "C:\Users\KasaM\AppData\Roaming\iSendSMS" /E /Z /R:3 /W:2 "C:\_BR\iSendSMS"

@mkdir "C:\_BR\NetSarang"
@cd /d "C:\Users\KasaM\AppData\Roaming\"
@ROBOCOPY "C:\Users\KasaM\AppData\Roaming\NetSarang" /E /Z /R:3 /W:2 "C:\_BR\NetSarang"

@mkdir "C:\_BR\Lunascape\Lunascape6\ApplicationData"
@mkdir "C:\_BR\Lunascape\Lunascape6\Mode"
@mkdir "C:\_BR\Lunascape\Lunascape6\Profile"
@cd /d "C:\Users\KasaM\AppData\Roaming\"
@ROBOCOPY "Lunascape\Lunascape6\ApplicationData" /E /Z /R:3 /W:2 "C:\_BR\Lunascape\Lunascape6\ApplicationData"
@ROBOCOPY "Lunascape\Lunascape6\Mode" /E /Z /R:3 /W:2 "C:\_BR\Lunascape\Lunascape6\Mode"
@ROBOCOPY "Lunascape\Lunascape6\Profile" /E /Z /R:3 /W:2 "C:\_BR\Lunascape\Lunascape6\Profile"

@cd /d "H:\_BackupRestore\7za"

@echo "%date% %time% ***Local Files***"

del /F /Q "H:\Archive\Sys\Users\KasaM\AppData\Local\YandexDataBackup.7z"
del /F /Q "H:\Archive\Sys\Users\KasaM\AppData\Local\CloverDataBackup.7z"
del /F /Q "H:\Archive\Sys\Users\KasaM\AppData\Local\SkyrimDataBackup.7z"
del /F /Q "H:\Archive\Sys\Users\KasaM\AppData\Roaming\iSendSMSDataBackup.7z"
del /F /Q "H:\Archive\Sys\Users\KasaM\AppData\Roaming\NetSarangDataBackup.7z"
del /F /Q "H:\Archive\Sys\Users\KasaM\AppData\Roaming\LunascapeDataBackup.7z"
del /F /Q "H:\Archive\Sys\Users\KasaM\_LastDesktopBackup.7z"

Start /B 7za.exe a -ssw -mx9 "H:\Archive\Sys\Users\KasaM\AppData\Local\YandexDataBackup.7z" "C:\_BR\Yandex\"

Start /B 7za.exe a -ssw -mx9 "H:\Archive\Sys\Users\KasaM\AppData\Local\Yandex\YandexBrowser\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_YandexDataBackup.7z" "C:\_BR\Yandex\"

Start /B 7za.exe a -ssw -mx9 "H:\Archive\Sys\Users\KasaM\AppData\Local\CloverDataBackup.7z" "C:\_BR\Clover\"

Start /B 7za.exe a -ssw -mx9 "H:\Archive\Sys\Users\KasaM\AppData\Local\Clover\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_CloverDataBackup.7z" "C:\_BR\Clover\"

Start /B 7za.exe a -ssw -mx9 "H:\Archive\Sys\Users\KasaM\AppData\Local\SkyrimDataBackup.7z" "C:\_BR\Skyrim\"

Start /B 7za.exe a -ssw -mx9 "H:\Archive\Sys\Users\KasaM\AppData\Local\Skyrim\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_SkyrimDataBackup.7z" "C:\_BR\Skyrim\"

@echo "%date% %time% ***Roaming Files***"

Start /B 7za.exe a -ssw -mx9 "H:\Archive\Sys\Users\KasaM\AppData\Roaming\iSendSMSDataBackup.7z" "C:\_BR\iSendSMS\"

Start /B 7za.exe a -ssw -mx9 "H:\Archive\Sys\Users\KasaM\AppData\Roaming\iSendSMS\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_iSendSMSDataBackup.7z" "C:\_BR\iSendSMS\"

Start /B 7za.exe a -ssw -mx9 "H:\Archive\Sys\Users\KasaM\AppData\Roaming\NetSarangDataBackup.7z" "C:\_BR\NetSarang\"

Start /B 7za.exe a -ssw -mx9 "H:\Archive\Sys\Users\KasaM\AppData\Roaming\NetSarang\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_NetSarangDataBackup.7z" "C:\_BR\NetSarang\"

Start /B 7za.exe a -ssw -mx9 "H:\Archive\Sys\Users\KasaM\AppData\Roaming\LunascapeDataBackup.7z" "C:\_BR\Lunascape\"

Start /B 7za.exe a -ssw -mx9 "H:\Archive\Sys\Users\KasaM\AppData\Roaming\Lunascape\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_LunascapeDataBackup.7z" "C:\_BR\Lunascape\"

@echo "%date% %time% ***End BackUp Local & Roaming Files***"

@echo "%date% %time% ***Desktop Files***"

Start /B 7za.exe a -ssw -mx9 "H:\Archive\Sys\Users\KasaM\_LastDesktopBackup.7z" "C:\Users\KasaM\Desktop\"

Start /B 7za.exe a -ssw -mx9 "H:\Archive\Sys\Users\KasaM\%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%__%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%_DesktopBackup.7z" "C:\Users\KasaM\Desktop\"

@echo "%date% %time% ***End BackUp Desktop Files***"

@echo Done.
@goto end

:error
@echo "*** Switch was NOT sucessfull. ***"
@pause

:end
REM wait
timeout 3
Start /B /HIGH cmd /c taskkill /F /IM conhost.exe
Start /B /HIGH cmd /c taskkill /F /IM cmd.exe

