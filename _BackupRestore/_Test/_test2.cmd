@echo on
@setlocal enableextensions enabledelayedexpansion
@set Title="Test 2"
@cd /D %~dp0
@cd /D ..\..\
@set ScriptsRootPath=%cd%
@set TempDir=%ScriptsRootPath%\_Temp
@rem Time
@set digit1=%time:~0,1%
@if "%digit1%"==" " (@set digit1=0)
@set DateStamp=!DATE:~-4!.!DATE:~3,2!.!DATE:~0,2!
@set DateTimeStamp=!DATE:~-4!.!DATE:~3,2!.!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@set LogsDir=%ScriptsRootPath%\__Logs\%DateStamp%_%~n0\%DateTimeStamp%_%~n0
@if not exist "%LogsDir%" mkdir "%LogsDir%"
@rem 
@set LogFile=%LogsDir%\%DateTimeStamp%_%~n0.log
@rem ============================================== Init End ====================================================================
@cd /D %~dp0
@rem Logs
@if not "%1" == "" echo %1 > %LogFile%
@rem ============================================================================================================================
:: Restart Explorer
Explorer /e,::{20D04FE0-3AEA-1069-A2D8-08002B30309D}
@rem @pause
@rem @echo Timeout End 2
@rem Exit /b
endlocal
