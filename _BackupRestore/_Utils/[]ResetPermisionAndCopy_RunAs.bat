@echo off
@Rem [ Author: [ Бурлачков Василий Александрович) ] ]
@rem setlocal enableextensions enabledelayedexpansion
setlocal EnableExtensions
setlocal EnableDelayedExpansion
@chcp 65001>nul
@cd /D %~dp0
@set SourceDirectoryes="%*"
@Echo %SourceDirectoryes%
@rem 
@pause
@rem 
call ___ResetPermisionAndCopy.cmd "%*"
@rem powershell -Command "Start-Process ___ResetPermisionAndCopy.cmd %1 -Verb RunAs"

:EOF
@rem 
@pause
@rem @timeout /t 1 >nul