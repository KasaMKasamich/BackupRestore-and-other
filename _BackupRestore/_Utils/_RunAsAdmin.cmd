@Rem [ Author: [ Бурлачков Василий Александрович) ] ]
@echo on
@rem setlocal enableextensions enabledelayedexpansion
setlocal EnableExtensions
setlocal EnableDelayedExpansion
@chcp 65001>nul
@Title "Run As Admin"
@rem chcp 1251 >nul
@rem chcp 1252 >nul
@rem chcp 866 >nul
@Rem []
@set Title="Run As Admin"
@cd /D %~dp0
@rem @echo dp0 - %~dp0
@cd /D ..\
@rem @echo cd - %cd%
@set ScriptsRootPath=%cd%
@set LogsDir=%ScriptsRootPath%\__Logs
@set CmdParametrString=%LogsDir%\CmdParametrString.txt
@echo Run As Admin
@rem @echo 1 - %1
@rem 
@echo 2 - %2
@rem 
@pause
@rem 
@rem Run As Admin ==============================================================
@Title "[Run As Admin]"

:RunAsAdmin
@rem @if not "%1" == "" echo %1 > %LogFile%
powershell -Command "Start-Process %1 %2 -Verb RunAs"
@rem 
@pause
goto :EOF

:EOF
@rem @pause

:Exit
@rem pause