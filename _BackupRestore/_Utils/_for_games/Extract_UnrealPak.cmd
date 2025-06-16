@echo off
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
set UnrealPak="H:\SteamLibrary\steamapps\common\Conan Exiles\ConanExilesDevKit\Engine\Binaries\Win64\UnrealPak.exe"
::cd /d H:\SteamLibrary\steamapps\common\Conan Exiles\ConanExilesDevKit\Engine\Binaries\Win64
::
:: for %%i in ("%~dp0\..") do set "root_parent=%%~fi"
:: for %%i in ("%~dp1\..") do set "root_parent=%%~fi"
:: FOR /F "usebackq tokens=*" %%i IN (`%1`) DO set CurDir=%%i
::
for %%i in ("%~dp1") do set "CurDir=%%~fi"
::set ExtractionDir="%CurDir%"
::echo %ExtractionDir%
::FOR /F "usebackq tokens=*" %%i IN (`%~dp1`) DO set CurDir=%%i
%UnrealPak% %1 -Extract "%CurDir%\"
::@pause