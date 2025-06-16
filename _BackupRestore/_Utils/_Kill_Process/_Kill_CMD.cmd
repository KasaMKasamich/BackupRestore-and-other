@echo off
@setlocal enableextensions enabledelayedexpansion
@set Title="Kill CMD"
@rem 
@cd /D %~dp0
@cd /D ..\..\
@set TaskKillProcessName=%1
@set ScriptsRootPath=%cd%
@set TempDir=%ScriptsRootPath%\_Temp
@rem Time
@set digit1=%time:~0,1%
@if "%digit1%"==" " (@set digit1=0)
@set DateStamp=!DATE:~-4!.!DATE:~3,2!.!DATE:~0,2!
@set DateTimeStamp=!DATE:~-4!.!DATE:~3,2!.!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@set LogsDir=%ScriptsRootPath%\__Logs\%DateStamp%_%~n0\%DateTimeStamp%_%~n0
@if not exist "%LogsDir%" mkdir "%LogsDir%"
@rem 
@set LogFile=%LogsDir%\%DateTimeStamp%_%~n0.log
@set Commandline=%LogsDir%\Commandline.txt
@set ParentProcessId=%TempDir%\ParentProcessId.tmp
@set ProcessId=%TempDir%\ProcessId.tmp
@cd /D %~dp0
@rem ============================================== Init End ====================================================================
@rem Logs
@rem wmic /OUTPUT:%Commandline% process where (Name="cmd.exe") get Caption,Processid,InstallDate,Commandline,ExecutablePath
@rem @tasklist /v /fo csv | findstr /i "%TaskKillProcessName%" > %LogsDir%\CMDParentPID.txt
@rem @if not "%1" == "" echo %1 > %LogFile%
@rem ============================================================================================================================
for %%p in ( powershell.exe ) do if "%%~$PATH:p" == "" (
    >&2 echo:%%p required.
    exit /b 1
)

:cmdpid
@chcp 65001>nul
for /f "tokens=*" %%p in ( '
    set "PPID=(Get-WmiObject Win32_Process -Filter ProcessId=$P).ParentProcessId" ^& ^
    call powershell -NoLogo -NoProfile -Command "$P = $pid; $P = %%PPID%%; %%PPID%%"
' ) do set CMDPID=%%p
@rem Create .tmp
@rem @echo %CMDPID%>>%ProcessId%
wmic /OUTPUT:%ParentProcessId% process where (Name="cmd.exe" AND Processid="%CMDPID%") get ParentProcessId
powershell -Command "(Get-Content -Path %ParentProcessId% | ForEach-Object {$_ -Replace '[^0-9]', ''}).trim() | Set-Content %ParentProcessId%"
powershell -Command "((gc %ParentProcessId% -Raw) -replace '(?m)^\s*`r`n','').trim() | Set-Content %ParentProcessId%"
@FOR /F "usebackq delims=" %%A IN ("%ParentProcessId%") DO ( @if not "%%~A" == "" (@set "CMDParentPID=%%~A") )
@chcp 866>nul
@rem @echo CMDParentPID - %CMDParentPID%
@timeout /t 1 >nul
for /f "tokens=2 delims=," %%b in (
  'tasklist /v /fo csv ^| findstr /i "Test"'
) do (
  set "mypid=%%~b"
)
@rem @echo %mypid%
@rem @pause
@rem 
@taskkill /F /PID %CMDPID% && taskkill /F /PID %CMDParentPID%
endlocal
