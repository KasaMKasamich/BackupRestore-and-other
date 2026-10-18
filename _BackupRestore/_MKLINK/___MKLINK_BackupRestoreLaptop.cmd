@Title "_BackupRestore MKLINK"
set sDriveLetter=
@rem set sCmd=wmic volume where "label='Storage'" get DriveLetter
@rem set sCmd=powershell -Command "(Get-Volume -FileSystemLabel 'Storage').DriveLetter"
echo [92m " =================================== End init =================================== " [0m 
@rem ======================================================================
@rem call %sCmd%>%temp%\tmpDriveLetter.txt
@rem powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt)[1].Trim()">%temp%\fDriveLetter.txt
@rem powershell -Command "(Get-Content -Path '%temp%\tmpDriveLetter.txt' -TotalCount 2) | ForEach-Object { $_.Trim() } | Out-File -FilePath '%temp%\fDriveLetter.txt' -Encoding utf8"

@rem powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt)[0,1].Trim()"
@rem powershell -Command "(Get-Content %temp%\tmpDriveLetter.txt -TotalCount 2).Trim()"
@rem powershell -Command "(Get-Content -Path '%temp%\tmpDriveLetter.txt' -TotalCount 2) | ForEach-Object { $_.Trim() }"

@rem FOR /F "usebackq delims=" %%A IN ("%temp%\fDriveLetter.txt") DO ( if not "%%~A" == "" (@set "sDriveLetter=%%~A") )

for /f "usebackq tokens=*" %%i in (`powershell -NoProfile -Command "(Get-CimInstance Win32_Volume | Where-Object {$_.Label -eq 'Storage'}).DriveLetter"`) do set "sDriveLetter=%%i"

@rem echo %sDriveLetter%

@rem wmic exit

@rem  Проверить пустая переменная или нет, если да то выход >>>>>>>>>>>>>>>>>>>>>>>>>> >>
@if "%sDriveLetter%" == "" (
	echo DriveLetter not found
	exit
)
@rem  << <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
@rem @pause
@rem del /f /q %temp%\tmpDriveLetter.txt
@rem del /f /q %temp%\fDriveLetter.txt
@rem ======================================================================
cd /d C://
MKLINK /d /h /j _BackupRestore %sDriveLetter%\_BackupRestore

@pause
