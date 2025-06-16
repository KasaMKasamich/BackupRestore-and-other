color 0A
SetLocal EnableExtensions EnableDelayedExpansion
set startmsg="(%DATE:~-4%.%DATE:~3,2%.%DATE:~0,2%  %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%)"
set process=wget.exe
set OutputLog="D:\Program Files\_Utilites\InternetSpeedTest.log"
cd /d "D:\Program Files\_Utilites\"
REM Удаление файла
del /F /S /Q "D:\Program Files\_Utilites\test100.zip"
del /F /S /Q "D:\Program Files\_Utilites\wget-log"
del /F /S /Q "D:\Program Files\_Utilites\wget-log.*"
echo ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// >> %OutputLog%
echo 	%startmsg% >> %OutputLog%
echo ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// >> %OutputLog%
ping -n 8 -w 1 101xp.com >> %OutputLog%
echo ----------------------------------------------------------------------------------------------------------------------------- >> %OutputLog%
ping -n 8 -w 1 speedtest.sea01.softlayer.com >> %OutputLog%
echo ----------------------------------------------------------------------------------------------------------------------------- >> %OutputLog%
wget -b -O "D:\Program Files\_Utilites\test100.zip" http://speedtest.sea01.softlayer.com/downloads/test100.zip
goto WatchProcess
:WatchProcess
tasklist /nh /V /FI "ImageName EQ %process%" /fo csv | Find /I "%process%"
if errorlevel 1 (
	echo %process% is not running
	TYPE "D:\Program Files\_Utilites\wget-log" >> %OutputLog%
	echo ----------------------------------------------------------------------------------------------------------------------------- >> %OutputLog%
	goto end
) else (
	REM echo %process% is running, waiting...
	goto WatchProcess
)
:end
exit
