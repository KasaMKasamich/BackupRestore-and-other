:: Get Dir Size
@echo on
Title "Get Dir Size"
SetLocal EnableExtensions EnableDelayedExpansion
:: chcp 1251 >nul
:: chcp 1252 >nul
:: chcp 866 >nul
::  Time
set digit1=%time:~0,1%
if "%digit1%"==" " (set digit1=0)
set TimeStamp=%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%digit1%%TIME:~1,1%_%TIME:~3,2%_%TIME:~6,2%
::  bool
::  int
set /A KB=1*1024
set /A MB=400*1048576
::  Папки
set Dir001=%userprofile%\AppData\Local
set LogsDir=C:\_BackupRestore\__Logs
::  Files
set FileName=GetDirSize.log
set LogFile=%LogsDir%\%TimeStamp%_%~n1.log
::  Self Backup
copy /v /y %0 %~dp0__BatchBackup\%~n0__%TimeStamp%%~x0
:: 
echo %~dp1%~n1

cd /D %~dp1%~n1
if exist GetDirSize.vbs ( Del /F /Q GetDirSize.vbs 1>nul 2>&1 )
@timeout /t 1 >nul
Echo WScript.Echo Round(CreateObject("Scripting.FileSystemObject").GetFolder(WScript.Arguments(0)).Size/2^^20,2)>GetDirSize.vbs
::  
For /D %%A In ("%~dp1%~n1\*") Do (
	For /F "delims=" %%B In ('CScript //Nologo %~dp1%~n1\GetDirSize.vbs "%%A"') Do (
		Set Bytes=%%B
		Set /A IntMB=!Bytes!/1048576
		Set /A IntKB=!Bytes!/1024
		Set /A FloatMB=!Bytes!%%1048576/10000
		Set /A FloatKB=!Bytes!%%1024/10
		Echo Size of %%A is !FloatMB! MB. >> %LogFile%
	)
)
%LogFile%
@pause

if exist GetDirSize.vbs ( Del /F /Q GetDirSize.vbs 1>nul 2>&1 )
endlocal
rem @timeout /t 2 >nul
rem exit
