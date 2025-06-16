@echo off
@setlocal EnableExtensions
@setlocal EnableDelayedExpansion
@set start=%date% %time% ***Starting Clear Icon Cache***
@echo %start%
taskkill /F /t /IM dllhost.exe
taskkill /F /t /IM rundll32.exe
@rem @cd /D %~dp0
@rem @call _Kill_Process\_ClearIconCacheNextStep.cmd
@taskkill /f /im explorer.exe
@taskkill /f /im shellexperiencehost.exe
@cd /d %userprofile%\AppData\Local
@del /f /s /q IconCache.db
@del /f /s /q iconcache*
@del /f /s /q thumbcache*
@cd /d %userprofile%\AppData\Local\Microsoft\Windows\Explorer
@timeout /t 1 >nul
@del /f /s /q iconcache*
@del /f /s /q thumbcache*
@del /f /s /q *.tmp
@cd /d %userprofile%\AppData\Local\Microsoft\Windows\Caches
@timeout /t 1 >nul
@del /f /s /q *.db
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
