@echo off
@setlocal enableextensions enabledelayedexpansion
@Title "Restart Explorer"
@cd /D %~dp0
@rem 
@rem @taskkill /IM msedge.exe
taskkill /F /t /IM Fences.exe
@timeout /t 1 >nul
@taskkill /f /t /im explorer.exe
@rem @taskkill /f /im FencesMenu64.dll
@taskkill /f /im shellexperiencehost.exe
@del %localappdata%\Packages\Microsoft.Windows.ShellExperienceHost_cw5n1h2txyewy\TempState\* /q
@del /F /S /Q %localappdata%\Packages\Microsoft.Windows.ShellExperienceHost_cw5n1h2txyewy\TempState\*
:: Restart Explorer
Explorer
:: start /SEPARATE explorer
@timeout /t 1 >nul
@rem "F:\ProgramFiles\_Desktop\Stardock\Fences\Fences.exe"
C:\Windows\system32\rundll32.exe "F:\ProgramFiles\_Desktop\Stardock\Fences\FencesMenu64.dll",StartFencesAsUser
@rem 
F:\ProgramFiles\_Desktop\Stardock\Fences\Fences.exe /FromDesktop
@rem 
@timeout /t 2 >nul
taskkill /F /IM Fences.exe
Explorer /e,::{20D04FE0-3AEA-1069-A2D8-08002B30309D}
@rem Shell:::{20D04FE0-3AEA-1069-A2D8-08002B30309D}
@cd /D %~dp0
@call _Kill_CMD.cmd cmd.exe
endlocal
