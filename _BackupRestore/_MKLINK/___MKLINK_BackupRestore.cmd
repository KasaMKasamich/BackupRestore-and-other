@Title "_BackupRestore MKLINK"
set sDriveLetter=
set sCmd=wmic volume where "label='Archive'" get DriveLetter
echo [92m " =================================== End init =================================== " [0m 
@rem ======================================================================
call %sCmd%>%temp%\tmpDriveLetter.txt
powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt)[1].Trim()">%temp%\fDriveLetter.txt

powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt)[0,1].Trim()"

FOR /F "usebackq delims=" %%A IN ("%temp%\fDriveLetter.txt") DO ( if not "%%~A" == "" (@set "sDriveLetter=%%~A") )

@rem  Проверить пустая переменная или нет, если да то выход >>>>>>>>>>>>>>>>>>>>>>>>>> >>
@if "%sDriveLetter%" == "" (
	echo DriveLetter not found
	exit
)
@rem  << <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
@rem @pause
del /f /q %temp%\tmpDriveLetter.txt
del /f /q %temp%\fDriveLetter.txt
@rem ======================================================================
cd /d C:\\
MKLINK /d /h /j _BackupRestore %sDriveLetter%\_BackupRestore
