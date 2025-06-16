@echo off
@setlocal enableextensions enabledelayedexpansion
@set Title="ParseProcessPID"
@rem 
@cd /D %~dp0
@cd /D ..\..\
@set ParseProcessPID=%1
@set Executable=%~nx1
@set ProcessPath=%~dp2
@set Argument2=%2
@set ScriptsRootPath=%cd%
@set TempDir=%ScriptsRootPath%\_Temp\ParseProcessPID
@if not exist "%TempDir%" mkdir "%TempDir%"
@rem Time
@set digit1=%time:~0,1%
@if "%digit1%"==" " (@set digit1=0)
@set DateStamp=!DATE:~-4!.!DATE:~3,2!.!DATE:~0,2!
@set DateTimeStamp=!DATE:~-4!.!DATE:~3,2!.!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@set LogsDir=%ScriptsRootPath%\__Logs\%DateStamp%_%~n0\%DateTimeStamp%_%~n0\%~n1
@if not exist "%LogsDir%" mkdir "%LogsDir%"
@rem 
@set LogFile=%LogsDir%\%DateTimeStamp%_%~n0.log
@set Commandline=%LogsDir%\Commandline.txt
@set ParseParentProcessId=%TempDir%\ParentProcessId.tmp
@set ParseName=%TempDir%\Name.tmp
@set ParseProcessId=%TempDir%\ProcessId.tmp
@cd /D %~dp0
@rem ============================================== Init End ====================================================================
@rem Logs
@rem 
@chcp 65001>nul
@rem @echo только путь к файлу - %~dp0
@rem @echo Exe - %Executable%
@rem @echo Path - %ProcessPath%
@rem @pause
@rem 
@chcp 866>nul
@rem ============================================================================================================================
@rem Create .tmp
@rem %ProcessPath%\%ParentProcessId%
@rem wmic /OUTPUT:C:\_BackupRestore\_Temp\ParseProcessPID\ProcessId.tmp process where (Name="MsMpEng.exe") get Processid
@rem wmic /OUTPUT:C:\_BackupRestore\_Temp\ParseProcessPID\ProcessId.txt process where (Name="MsMpEng.exe") get Processid
@rem ============================================================================================================================
@rem powershell -Command "(Get-Content -Path %Argument2% | ForEach-Object {$_ -Replace '[^0-9]', ''}).trim() | Set-Content %ParseProcessId%"
@rem powershell -Command "((gc %Argument2% -Raw) -replace '(?m)^\s*`r`n','').trim() | Set-Content %ParseProcessId%"
@rem @pause
@rem wmic /OUTPUT:%Argument2% process where (Name="%Executable%") get Name
@rem 
wmic /OUTPUT:%ParseProcessId% process where (Name="%Executable%") get Processid
@rem 
powershell -Command "(Get-Content -Path %ParseProcessId% | ForEach-Object {$_ -Replace '[^0-9]', ''}).trim() | Set-Content %ParseProcessId%"
@rem 
powershell -Command "((gc %ParseProcessId% -Raw) -replace '(?m)^\s*`r`n','').trim() | Set-Content %ParseProcessId%"
@rem @FOR /F "usebackq delims=" %%A IN ("%ParseProcessId%") DO ( @if not "%%~A" == "" (@set "PID=%%~A") )
@rem @echo Step 1 Finish
@rem type %ParseProcessId%
@rem @echo PID - %PID%
@rem @chcp 866>nul
@rem @pause
@rem 
endlocal
