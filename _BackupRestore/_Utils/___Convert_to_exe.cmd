@echo on
@setlocal enableextensions enabledelayedexpansion
@set Title=%~n1
@set 7zaKeyString=-ssw -m0=LZMA2:d128m:fb256 -myx9 -mmt=8 -ms=off
@set 7zaKeyString2=-ssw -mmt=8 -ms=off
@set 7zaKeyString3=-ssw -mmt=8
@set 7zaKeyString4=-ssw -mmt=8 -mx9 -ms=off
@cd /D %~dp0
@cd /D ..\
@rem @echo cd - %cd%
@set ScriptsRootPath=%cd%
if /i "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
	@set 7za=%ScriptsRootPath%\7za\x64\7za.exe
) else (
	@set 7za=%ScriptsRootPath%\7za\7za.exe
)
@set 7z_SFX_Module=%ScriptsRootPath%\7za\x64\7zsd_All_x64.sfx
@set ConfigDir=%~dp0\config
@set Config=%~dp0\_Temp\config.txt
@rem chcp 1251 >nul
@rem chcp 1252 >nul
@rem chcp 866 >nul
@rem 
@cd /D %~dp0\_Temp\
@rem echo Dir 0 - "%~dp0\_Temp\"
@rem echo Dir 1 - "%~dp1\_Temp\"
@rem echo Config - "%Config%"
@rem 
@rem '
@rem "
@rem 
@if "%~x1"==".cmd" ( goto :cmd )
@if "%~x1"==".bat" ( goto :bat )

:cmd
@goto :Create

:bat
@goto :Create

:Create
@rem del
@del /f /q %~n1.7z
@del /f /q %~n1.exe
@del /f /q %Title%.tmp
@del /f /q %Config%
@timeout /t 1 >nul
@rem Build config file
@rem Create .tmp
@chcp 65001>nul
powershell -Command "Get-Content -Path %ConfigDir%\ConfigBegin.txt | Add-Content -Path %Title%.tmp"
@echo Title="%Title%">>%Title%.tmp
@echo BeginPrompt="Continue execution %~nx1?">>%Title%.tmp
@rem %~nx1">>%Title%.tmp
@echo RunProgram="hidcon:%~nx1">>%Title%.tmp
powershell -Command "Get-Content -Path %ConfigDir%\ConfigEnd.txt | Add-Content -Path %Title%.tmp"
@rem Create Config
@rem powershell -Command "Get-Content -Path %Title%.tmp | Out-File -FilePath config2.txt"
@copy %Title%.tmp %Config%
@chcp 866>nul
@rem 
@timeout /t 1 >nul
@rem Build SFX
!7za! u %~n1.7z null
@xcopy "%7z_SFX_Module%" "%~dp0\_Temp\" /H /Y /Z /K /E /C /R /S /I
@copy /b 7zsd_All_x64.sfx + %Config% + %~n1.7z %~dp0\_To_Exe\%~n1.exe
!7za! u !7zaKeyString2! %~dp0\_To_Exe\%~n1.exe %1
@rem 
@goto :End

:End
@rem echo "FullPath =" %1
@rem echo "FullPath, FileName & FileTip =" (%1) (%~n1) (%~nx1) (%~x1)
@rem @pause
@rem delete
@timeout /t 1 >nul
@del /f /q %~n1.7z
@del /f /q %Config%
@del /f /q %Title%.tmp
