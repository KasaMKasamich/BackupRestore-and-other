::@echo off
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
set SavedModFilesPath=C:\Users\New\AppData\Local\ConanSandbox\Saved\Mods\ModFiles
::set GameModFilesPath=I:\Games\Steam\steamapps\common\Conan Exiles\ConanSandbox\Mods
cd
::
 for %%i in ("%~dp0\..\..\../workshop\content\440900") do set "root_parent=%%~fi"

echo %root_parent%

@pause
:: for %%i in ("%~dp1") do set "CurDir=%%~fi"
::
:: echo %~dp0
::
:: echo %root_parent%
ROBOCOPY "%SavedModFilesPath%" /E /Z /R:3 /W:2 "%root_parent%"
:: @pause