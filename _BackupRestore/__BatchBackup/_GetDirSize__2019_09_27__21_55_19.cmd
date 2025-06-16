@rem Get Dir Size
@echo on
if exist "%~dp0\.Target" ( Del /F /Q "%~dp0\.Target" 1>nul 2>&1 )
Title "Get Dir Size"
SetLocal EnableExtensions EnableDelayedExpansion
@rem chcp 1251 >nul
chcp 1252 >nul
@rem chcp 866 >nul
@rem  Time
set digit1=%time:~0,1%
if "%digit1%"==" " (set digit1=0)
set TimeStamp=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%digit1%%TIME:~1,1%_%TIME:~3,2%_%TIME:~6,2%
@rem  bool
@rem  int
set /A KB=1*1024
set /A MB=400*1048576
@rem  Папки
set LogsDir=C:\_BackupRestore\__Logs
@rem  Files
set FileName=GetDirSize.log
set LogFile="%LogsDir%\%TimeStamp%"
@rem  Self Backup
set self=%0
copy /v /y %0 C:\_BackupRestore\__BatchBackup\%~n0__%TimeStamp%%~x0
rem echo %~dp1\Temp\%~n0%~x0
rem echo %~dp1%~n1
@rem =================================================================================================================================
cd /d %~dp0\
set sTarget="%1"
set sTargetName="%~n1"
if not exist %~dp0\.Target ( echo %1>%~dp0\.Target )
if not exist %~dp0\.TargetName ( echo %~n1>%~dp0\.TargetName )
for /f "usebackq tokens=* delims=" %%A In ('%~dp0\.Target') Do ( set /A sTarget=%%A )
for /f "usebackq tokens=* delims=" %%A In ('%~dp0\.TargetName') Do ( set /A sTargetName=%%A )
@rem =================================================================================================================================
@rem =================================================================================================================================
@rem =================================================================================================================================
:Sandbox
echo [92m " =================================== Sandbox =================================== " [0m 
set DM=0
set isCLS=0
set isSandbox=1
set isRunAs=1
if %DM% == 1 (
	if %isRunAs% == 1 (
		pause | powershell -Command "Start-Process %self% -Verb RunAs"
	)
@rem >> ===================================
echo --  %0
echo --  %~dp0
echo --  %~n0
echo --  %~x0

echo --  %~dp1
echo --  %~n1


@rem << ===================================
)
echo [92m " =================================== Sandbox Border =================================== " [0m 
if %DM% == 1 ( goto :Stop )
@rem =================================================================================================================================
@rem =================================================================================================================================
@rem =================================================================================================================================

cd /D "C:\Temp"
if exist GetDirSize.vbs ( Del /F /Q GetDirSize.vbs 1>nul 2>&1 )
Echo WScript.Echo Round(CreateObject("Scripting.FileSystemObject").GetFolder(WScript.Arguments(0)).Size/2^^20,2)>GetDirSize.vbs
rem echo %errorlevel%
xcopy GetDirSize.vbs %sTarget%\GetDirSize.vbs /R /Y /O /X
echo %errorlevel%
if errorlevel 4 (
	call :RunAs
	goto :End
) else (
	goto :Get
)

:Get
cd /D "C:\%1"
For /D %%A In ("%sTarget%\*") Do (
	For /F "delims=" %%B In ('CScript //Nologo "%sTarget%\GetDirSize.vbs" "%%A"') Do (
		Set Bytes=%%B
		Set /A IntMB=!Bytes!/1048576
		Set /A IntKB=!Bytes!/1024
		Set /A FloatMB=!Bytes!%%1048576/10000
		Set /A FloatKB=!Bytes!%%1024/10
		if %%B geq 1 Echo Size of %%A is !Bytes! MB. >> %LogFile%_%sTargetName%.log
	)
)
if exist GetDirSize.vbs ( Del /F /Q GetDirSize.vbs 1>nul 2>&1 )
explorer.exe %LogFile%_%sTargetName%.log
goto :End

:RunAs
powershell -Command "Start-Process %self% -Verb RunAs"
if %isSandbox% == 1 ( goto :Stop )
endlocal

:End
if exist "%~dp0\.Target" ( Del /F /Q "%~dp0\.Target" 1>nul 2>&1 )
if %isSandbox% == 1 ( goto :Stop )

exit

:Stop
echo [92m " =================================== Stop =================================== " [0m 
@rem 
if %isCLS% == 1 ( cls )
pause
exit /b
exit /b
@rem @timeout /t 360 >nul
rem 
