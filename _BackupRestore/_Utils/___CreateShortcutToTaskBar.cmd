@echo on
@setlocal enableextensions enabledelayedexpansion
@Title "Sys Settings"
@cd /D %~dp0
@cd /D ..\
@rem @echo cd - %cd%
@set ScriptsRootPath=%cd%
@set NirCMD=%ScriptsRootPath%\NirCMD\nircmd.exe
@set ShortcutName=%~n1
@set OutputDir=%~dp1
@set SourceScriptTarget="%*"
@set UserPinnedToTaskBarDir="%Userprofile%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
@rem 
@rem [file]: Create a shortcut to this file. 
@rem [folder]: Specify the destination folder that inside it the shortcut will be created. You can specify any valid folder, including the special variables that represent system folders, like ~$folder.desktop$ (Desktop folder), ~$folder.programs$ (Start-Menu-Programs folder), and so on... 
@rem [shortcut title]: The text displayed in the shortcut. 
@rem {arguments}: Optional parameter - Additional arguments to execute the filename. 
@rem {icon file}: Optional parameter - Use this parameter if your want that the shortcut will be displayed with icon other than the default one. 
@rem {icon resource number}: Optional parameter - The resource number inside the icon file. 
@rem {ShowCmd}: Optional parameter - Use this parameter if you want to maximize or minimize the window of the program. Specify "max" to maximize the window or "min" to minimize it. 
@rem {Start In Folder}: Optional parameter - Specifies the "Start In" folder. If you don't specify this parameter, the "Start In" folder is automatically filled with the folder of the program you specify in [filename] parameter. 
@rem {Hot Key}: Optional parameter - Specifies an hot-key that will activate the shortcut. For example: Alt+Ctrl+A, Alt+Shift+F8, Alt+Ctrl+Shift+Y

@rem shortcut -{file} -{destinationfolder} -{title} -{arguments} -{icon file} -{icon resource number}
@rem 
@echo %~n1 - %~nx1 - %~dpnx1
for /f "delims=|" %%A in (%*) Do (
	@echo %~n1 - "%%~dpn"
)
@rem 
@pause
@rem 
for /f "delims=|" %%A in (%*) Do (
	if exist "!OutputDir!\%%A" (
		%NirCMD% shortcut "%%A" %UserPinnedToTaskBarDir% "%%dpn" "" "%~dpnx1" 0
	)
)
@rem 
@pause
@rem %NirCMD% shortcut "%~dpnx1" %UserPinnedToTaskBarDir% "%~n1" "" "%~dpnx1" 0
@rem %NirCMD% shortcut "%SystemRoot%\explorer.exe" "%Userprofile%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" "Компьютер" "/e,::{20D04FE0-3AEA-1069-A2D8-08002B30309D}" "C:\Windows\System32\shell32.dll" 16
@rem 
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Streams\Desktop /f
@rem reg DELETE HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband /v Favorites /f
@timeout /t 1 >nul
@taskkill /f /im explorer.exe
@taskkill /f /im shellexperiencehost.exe
@del %localappdata%\Packages\Microsoft.Windows.ShellExperienceHost_cw5n1h2txyewy\TempState\* /q
@del /F /S /Q %localappdata%\Packages\Microsoft.Windows.ShellExperienceHost_cw5n1h2txyewy\TempState\*
:: Restart Explorer
Explorer
:: start /SEPARATE explorer
@timeout /t 1 >nul
C:\Windows\system32\rundll32.exe "F:\ProgramFiles\_Desktop\Stardock\Fences\FencesMenu64.dll",StartFencesAsUser
Explorer /e,::{20D04FE0-3AEA-1069-A2D8-08002B30309D}
@rem Shell:::{20D04FE0-3AEA-1069-A2D8-08002B30309D}
endlocal