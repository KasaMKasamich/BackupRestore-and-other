:: Copy LockScreen images
@echo off
setlocal enableextensions enabledelayedexpansion
set DestinationFolder=I:\Users\New\Pictures\Desktop\
set LockScreenFolder=I:\Users\New\Pictures\Desktop\LockScreen\
:: 
cd /D %userprofile%\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets
mkdir "I:\Users\New\Pictures\Desktop\LockScreen\" 1>nul 2>&1
xcopy * "I:\Users\New\Pictures\Desktop\LockScreen\*.jpg" /Y /Z /K /E
:: @timeout 2 >nul
cd /D %LockScreenFolder%
:: @timeout 1 >nul
for /f "usebackq delims=;" %%A in (`dir /s /b *.jpg`) do If %%~zA LSS 200000 del /f /s /q "%%A"
:: 
cd /D C:\Windows\Web
xcopy * "%DestinationFolder%" /Y /Z /K /E
:: 
endlocal
