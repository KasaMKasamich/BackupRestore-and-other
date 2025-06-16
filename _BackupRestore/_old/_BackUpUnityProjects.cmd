@echo off
SetLocal EnableExtensions EnableDelayedExpansion
color 0A
chcp 1252 >nul
set startmsg=Начата архивация файлов
echo %startmsg%
set isAppRunning=0
set backuptool=7za.exe
set DirProjects01=I:\Archive\_UnityProjects
set DirProjects02=D:\Archive\_UnityProjects
set DirProject01=TestGame
set DirProject02=7DTD_Project
set DirProject03=UniFileBrowser
set NewDir=G:\Archive\_UnityProjects
set LogFile=G:\Archive\_UnityProjects\_Logs\%DATE:~-4%_%DATE:~3,2%_%DATE:~0,2%__%TIME:~0,2%_%TIME:~3,2%_BackupUnityProjects.log
echo ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// >> "%LogFile%"
echo ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// >> "%LogFile%"
echo ------------------------------------------------------------------ >> "%LogFile%"
echo 	"%startmsg% - %date% | %time%" >> "%LogFile%"
echo ------------------------------------------------------------------ >> "%LogFile%"
rem tasklist /FI "USERNAME ne NT %COMPUTERNAME%\%USERNAME%" /FI "STATUS eq running" /FI "ImageName EQ %backuptool%" | Find /I "%backuptool%"
:WatchBackupTool
tasklist /nh /V /FI "USERNAME EQ %USERNAME%" /FI "STATUS EQ RUNNING" /fo csv |>> C:\Users\Public\Desktop\KillProcess.txt find /i "%backuptool%"
if errorlevel 1 (
	if "%isAppRunning%"=="2" (
		goto End2
	)
	if "%isAppRunning%"=="1" (
		goto End1
	)
	if "%isAppRunning%"=="0" (
		goto isNotRunning
	)
	rem goto WatchBackupTool
) else (
	REM echo %backuptool% is running
	echo "%backuptool% Запущен под пользователем %COMPUTERNAME%\%USERNAME% - %date% | %time%"
	goto WatchBackupTool
)

:isNotRunning
rem chcp 866 >nul
set isAppRunning=1
echo Step1 >> "%LogFile%"
echo %isAppRunning% >> "%LogFile%"
REM Подготовка к архивированию
cd /d "C:\_BackupRestore\7za"
echo "%backuptool% Запущен под пользователем %COMPUTERNAME%\%USERNAME% - %date% | %time%" >> "%LogFile%"
rem chcp 850 >nul
Start /B %backuptool% u -ssw -mx9 "%NewDir%\%DirProject01%.7z" "%DirProjects01%\%DirProject01%" >> "%LogFile%"
echo %backuptool% is Running
@timeout 3
goto WatchBackupTool

:isRunning

:End1
echo %isAppRunning% >> "%LogFile%"
echo ----------------------------------------------------------------------------------------------------------------------------- >> "%LogFile%"
goto Step2


:Step2
rem chcp 1251 >nul
set isAppRunning=2
echo Step2 >> "%LogFile%"
echo %isAppRunning% >> "%LogFile%"
echo "%backuptool% Запущен под пользователем %COMPUTERNAME%\%USERNAME% - %date% | %time%"
echo "%backuptool% Запущен под пользователем %COMPUTERNAME%\%USERNAME% - %date% | %time%" >> "%LogFile%"
rem chcp 850 >nul
Start /B %backuptool% u -ssw -mx9 "%NewDir%\%DirProject02%.7z" "%DirProjects02%\%DirProject02%" >> "%LogFile%"
goto WatchBackupTool

:End2
echo ----------------------------------------------------------------------------------------------------------------------------- >> "%LogFile%"
exit





rem Start /B 7za.exe u -ssw -mx9 "%NewDir%\%DirProject03%.7z" "%DirProjects01%\%DirProject03%"
rem ROBOCOPY "%DirProjects01%\%DirProject01%" /E /Z /R:3 /W:2 "%NewDir%\%DirProject01%"
rem ROBOCOPY "%DirProjects02%\%DirProject02%" /E /Z /R:3 /W:2 "%NewDir%\%DirProject02%"