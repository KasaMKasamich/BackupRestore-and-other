@echo off
@setlocal enableextensions enabledelayedexpansion
@Title "Restart Explorer"
@cd /D %~dp0
@rem 
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Streams\Desktop /f
@rem reg DELETE HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband /v Favorites /f
@rem reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced» /V EnableXamlStartMenu /T REG_DWORD /D 0 /F
@timeout /t 1 >nul
taskkill /F /t /IM dllhost.exe
taskkill /F /t /IM rundll32.exe
@rem 
@rem @taskkill /IM msedge.exe
taskkill /F /t /IM Fences.exe
@timeout /t 1 >nul
@taskkill /f /im explorer.exe
@rem @taskkill /f /im FencesMenu64.dll
@taskkill /f /im shellexperiencehost.exe
@del %localappdata%\Packages\Microsoft.Windows.ShellExperienceHost_cw5n1h2txyewy\TempState\* /q
@del /F /S /Q %localappdata%\Packages\Microsoft.Windows.ShellExperienceHost_cw5n1h2txyewy\TempState\*
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
@rem Shell:::{20D04FE0-3AEA-1069-A2D8-08002B30309D}
@cd /D %~dp0
@call _Kill_CMD.cmd cmd.exe
endlocal
