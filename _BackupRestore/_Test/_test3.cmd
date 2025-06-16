@echo off
@setlocal enableextensions enabledelayedexpansion
@set Title="Test"
@cd /D %~dp0
call _Test.cmd cmd.exe
@rem 
@pause

endlocal
