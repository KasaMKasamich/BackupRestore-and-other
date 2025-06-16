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
@cd /D %~dp0
@call ___RestartExplorerNextStep.cmd
