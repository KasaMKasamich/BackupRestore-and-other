@echo off
@Rem [ Author: [ Бурлачков Василий Александрович) ] ]
@rem setlocal enableextensions enabledelayedexpansion
setlocal EnableExtensions
setlocal EnableDelayedExpansion
@chcp 65001>nul
@cd /D %~dp0
@cd /D ..\
@rem @echo cd - %cd%
@rem [============][============][============]
@set ScriptsRootPath=%cd%
@set LogsDir=%ScriptsRootPath%\__Logs
@set ListDir=%ScriptsRootPath%\__Lists
@set TempDir1=%ScriptsRootPath%\_Temp
@set UtilsDir=%ScriptsRootPath%\_Utils
@rem [============][============][============]
@rem @echo ScriptsRootPath - %ScriptsRootPath%
@cd /D %~dp0
@rem @echo cd - %cd%
@rem [============][============][============]
@set SourceDirectoryes="%*"
@rem @Echo %SourceDirectoryes%
@rem call ___ResetPermisionAndCopy.cmd "%*"
@rem 
@del /f /q "%ListDir%\_TempFilesList2.txt"
@echo %*>> "%ListDir%\_TempFilesList2.txt"
@rem [============][============][============][============][============][============][============]
@rem @set PwShCmd=powershell -noprofile -Command "Start-Process ___ResetPermisionAndCopy.cmd -Verb RunAs '%*'"
@set PwShCmd=powershell -Command "Start-Process ___ResetPermisionAndCopy.cmd '%*' -Verb RunAs"
@call !PwShCmd!

:EOF
@rem 
@pause
@rem @timeout /t 1 >nul