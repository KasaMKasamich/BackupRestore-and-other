@echo off
@setlocal enableextensions enabledelayedexpansion
@set Title=Process_Info
@set Title01=Process_CommandLine
@set Title02=Process_ExecutablePath
@set Title03=Process_ReadTransferCount
@set Title04=Process_
@set ProcessName=%1
@cd /D %~dp0
@cd /D ..\..\
@set ScriptsRootPath=%cd%
@set TempDir=%ScriptsRootPath%\_Temp\ParseProcessPID
@if not exist "%TempDir%" mkdir "%TempDir%"
@set ParseProcessId=%TempDir%\ProcessId.tmp
@rem Time
@set digit1=%time:~0,1%
@if "%digit1%"==" " (@set digit1=0)
@set DateStamp=!DATE:~-4!.!DATE:~3,2!.!DATE:~0,2!
@set DateTimeStamp=!DATE:~-4!.!DATE:~3,2!.!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@set LogsDir=%ScriptsRootPath%\__Logs\%DateStamp%_%~n0\%DateTimeStamp%_%~n0
@set Commandline=%LogsDir%\Commandline.txt
@set ParseProcessIdLog=%LogsDir%\%DateTimeStamp%_ProcessId.txt
@set ParseProcessNameLog=%LogsDir%\%DateTimeStamp%_ProcessName.txt
@set ParseProcessNameLog2=%LogsDir%\%DateTimeStamp%_ProcessName2.txt
@if not exist "%LogsDir%" mkdir "%LogsDir%"
@rem 
@set LogFile01=%LogsDir%\%DateTimeStamp%_%Title01%.log
@set LogFile02=%LogsDir%\%DateTimeStamp%_%Title02%.log
@set LogFile03=%LogsDir%\%DateTimeStamp%_%Title03%.log
@set LogFile03=%LogsDir%\%DateTimeStamp%_%Title03%.log
@rem wmic /OUTPUT:%Commandline% process where (Name="%ProcessName%") get Caption,Processid,InstallDate,Commandline,ExecutablePath
WMIC /OUTPUT:%LogFile01% PROCESS get Caption,Processid,Commandline
WMIC /OUTPUT:%LogFile02% PROCESS get Caption,Processid,ExecutablePath
WMIC /OUTPUT:%LogFile03% PROCESS where "ReadTransferCount>5000000000" get Caption,Processid,ReadTransferCount,WriteTransferCount,Commandline,ExecutablePath /value
@rem ParseProcessNameLog
@rem 
wmic /OUTPUT:%ParseProcessIdLog% process where "ReadTransferCount>5000000000" get Processid
@rem powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt)[0,1].Trim()">>%LogFile%
@rem powershell -Command "(Get-Content -Path %ParseProcessIdLog% | ForEach-Object {$_ -Replace '[^0-9]', ''}).trim() | Set-Content %ParseProcessId%"
@rem powershell -Command "((gc %ParseProcessIdLog% -Raw) -replace '(?m)^\s*`r`n','').trim() | Set-Content %ParseProcessId%"
@rem @FOR /F "usebackq delims=" %%A IN ("%ParseProcessId%") DO ( @if not "%%~A" == "" (@set "PID=%%~A") )
@rem powershell -Command "Get-content -Path %ParseProcessNameLog% | Select-String -pattern "*.exe" -notMatch | select -exp Line | Set-Content %ParseProcessNameLog2%"
@rem 
@cd /D %~dp0
@rem 
@call _Parse_Process_PID.cmd "MsMpEng.exe" %ParseProcessIdLog%
@rem @tasklist /v /fo csv | findstr /i "MsMpEng.exe" > %LogsDir%\Process_log.txt
@rem @tasklist /v /fo csv | findstr /i "svchost.exe" > %LogsDir%\Process_log.txt
@rem @tasklist /v /fo csv | findstr /i "%PID%" > %LogsDir%\Process_log.txt
@rem 
@pause
