@echo off
@setlocal enableextensions enabledelayedexpansion
@set Title="Test"
@rem 
@cd /D %~dp0
@call _Parse_Process_PID.cmd MsMpEng.exe "C:\_BackupRestore\__Logs\2023.04.27_Process_Info_To_Log\2023.04.27__05_27_13_Process_Info_To_Log"
@rem ============================================== Init End ====================================================================
@rem @chcp 65001>nul
@rem @echo только путь к файлу - %~dp0
@rem 
@pause
@rem Logs
@rem wmic /OUTPUT:%Commandline% process where (Name="cmd.exe") get Caption,Processid,InstallDate,Commandline,ExecutablePath
@rem @tasklist /v /fo csv | findstr /i "%TaskKillProcessName%" > %LogsDir%\CMDParentPID.txt
@rem @if not "%1" == "" echo %1 > %LogFile%
@rem @chcp 866>nul
@rem ============================================================================================================================
endlocal
