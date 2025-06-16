@echo off
color 0A
SetLocal EnableExtensions EnableDelayedExpansion
chcp 1252 >nul
set startmsg=%date% %time%
set process=cmd.exe
echo %startmsg%
echo ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// >> C:\Users\Public\Desktop\KillProcess.txt
echo ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// >> C:\Users\Public\Desktop\KillProcess.txt
echo -------------------------------------------------- >> C:\Users\Public\Desktop\KillProcess.txt
echo 	Задание запущенно - %startmsg% >> C:\Users\Public\Desktop\KillProcess.txt
echo -------------------------------------------------- >> C:\Users\Public\Desktop\KillProcess.txt
rem STATUS eq, ne RUNNING / NOT RESPONDING / UNKNOWN
REM Watch process
rem tasklist /nh /V /FI "ImageName EQ %process%" /FI "USERNAME NE NT %COMPUTERNAME%\%USERNAME%" /FI "STATUS EQ running" | Find /I "%process%" >> C:\Users\Public\Desktop\KillProcess.txt
:Watchprocess
tasklist /nh /V /FI "USERNAME EQ %USERNAME%" /FI "STATUS EQ RUNNING" /fo csv |>> C:\Users\Public\Desktop\KillProcess.txt find /i "%process%"
if errorlevel 1 (
	REM @echo %process% is not running
	goto Watchprocess
) else (
	echo "%process% запущен под пользователем %COMPUTERNAME%\%USERNAME% - %date% | %time%" >> C:\Users\Public\Desktop\KillProcess.txt
	tasklist /nh /M /FI "USERNAME EQ %USERNAME%" /FI "STATUS EQ RUNNING" |>> C:\Users\Public\Desktop\KillProcess.txt find /i "%process%"
	taskkill /F /FI "ImageName EQ %process%" /FI "USERNAME EQ %USERNAME%" /FI "STATUS EQ RUNNING" /IM %process% >> C:\Users\Public\Desktop\KillProcess.txt
	echo ----------------------------------------------------------------------------------------------------------------------------- >> C:\Users\Public\Desktop\KillProcess.txt
	REM echo %process% is running
	goto Watchprocess
)

rem tasklist /FI "USERNAME ne NT %COMPUTERNAME%\%USERNAME%" /FI "STATUS eq running" /FI "ImageName EQ %process%" | Find /I "%process%"
rem tasklist /FI "ImageName EQ %process%" /FI "USERNAME ne NT %COMPUTERNAME%\%USERNAME%" /FI "STATUS eq running"
rem tasklist /nh /V /FI "USERNAME NE NT %COMPUTERNAME%\%USERNAME%" /FI "STATUS EQ running" /fo csv |>nul find /i "cmd.exe" && echo OK - cmd is Running.
rem tasklist /nh /V /FI "USERNAME NE NT %COMPUTERNAME%\%USERNAME%" /FI "STATUS EQ running" /fo csv |>> C:\Users\Public\Desktop\KillProcess.txt find /i "cmd.exe" && echo OK - cmd is Running.

rem tasklist /fo csv |>nul find /i "cmd.exe" && echo OK - cmd is Running.
rem tasklist /fo csv | find /i "cmd.exe" && echo OK - cmd is Running.
