@echo off
setlocal EnableExtensions
setlocal EnableDelayedExpansion
@chcp 65001>nul
@rem chcp 1251 >nul
@rem chcp 1252 >nul
@rem chcp 866 >nul
@Title "RimWorld Download mod"
@set Title="RimWorld Download mod"
@cd /D %~dp0
@cd /D ..\..\
@rem @echo cd - %cd%
@rem [============][============][============]
@set ScriptsRootPath=%cd%
@set LogsDir=%ScriptsRootPath%\__Logs
@set ListDir=%ScriptsRootPath%\__Lists
@set TempDir1=%ScriptsRootPath%\_Temp
@set UtilsDir=%ScriptsRootPath%\_Utils
@rem [============][============][============]
@echo ScriptsRootPath - %ScriptsRootPath%
@rem @cd /D %~dp0
@rem @echo cd - %cd%
@rem [============][============][============]
for /f "usebackq delims=" %%I in (`@cscript //Nologo %UtilsDir%\[]Textinput.wsf`) do set "Input=%%I"
@rem @echo Input - %Input%
if /i "%Input%"=="" (
	@goto :EOF
)
H:\SteamLibrary\steamapps\common\SteamCMD\steamcmd.exe +login anonymous" +force_install_dir "F:\Archive\SavedGameFiles\RimWorld\[] Mods\[] Downloaded mods" +workshop_download_item 294100 %Input% validate +quit

:EOF

	