@echo off
setlocal EnableExtensions
setlocal EnableDelayedExpansion
set start=%date% %time% ***Starting Kill DLL's Processes***
echo %start%
taskkill /F /t /IM dllhost.exe
taskkill /F /t /IM rundll32.exe
taskkill /F /t /IM Fences.exe
taskkill /F /IM explorer.exe
@rem taskkill /f /im shellexperiencehost.exe
@timeout /t 1 >nul
:: @timeout 3
:: Restart Explorer
Explorer
@timeout /t 1 >nul
@rem "F:\ProgramFiles\_Desktop\Stardock\Fences\Fences.exe"
C:\Windows\system32\rundll32.exe "C:\Program Files (x86)\Stardock\Fences\FencesMenu64.dll",StartFencesAsUser
@rem @timeout /t 1 >nul
@rem 
"C:\Program Files (x86)\Stardock\Fences\Fences.exe" /FromDesktop
@rem 
@timeout /t 2 >nul
@rem taskkill /F /IM Fences.exe
Explorer /e,::{20D04FE0-3AEA-1069-A2D8-08002B30309D}
@cd /D %~dp0
@call _Kill_CMD.cmd cmd.exe
endlocal