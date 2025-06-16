@Rem [ Author: [ Бурлачков Василий Александрович) ] ]
@echo off
@rem setlocal enableextensions enabledelayedexpansion
setlocal EnableExtensions
setlocal EnableDelayedExpansion
@chcp 65001>nul
@Title "Run As Admin"
@rem chcp 1251 >nul
@rem chcp 1252 >nul
@rem chcp 866 >nul
@rem Time
@set digit1=%time:~0,1%
@if "%digit1%"==" " (@set digit1=0)
@set DateStamp=!DATE:~-4!.!DATE:~3,2!.!DATE:~0,2!
@set DateTimeStamp=!DATE:~-4!.!DATE:~3,2!.!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@set DateTimeStamp2=!DATE:~-4!.!DATE:~3,2!.!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!
@rem 
@rem @echo dp0 - %~dp0
@cd /D %~dp0
@cd /D ..\
@Rem 
@set ScriptsRootPath=%cd%
@set LogsDir=%ScriptsRootPath%\__Logs
@set ParseVolumesLog="%LogsDir%\[] WMIC\%DateTimeStamp2%_Volumes.txt"
@set ParseDeviceIDsLogC="%LogsDir%\[] WMIC\DeviceID_C_(Sys).txt"
@set ParseDeviceIDsLogF="%LogsDir%\[] WMIC\DeviceID_F_(Archive).txt"
@set ParseDeviceIDsLogH="%LogsDir%\[] WMIC\DeviceID_H_(Games).txt"
@set ParseDeviceIDsLogI="%LogsDir%\[] WMIC\DeviceID_I_(UserData).txt"
@rem 
@echo ScriptsRootPath - %cd%
@rem Сбор сведений о дисках и разделах ==============================================================
@Title "[Сбор сведений о дисках и разделах]"
@rem wmic /OUTPUT:%ParseVolumesLog% volume where "ReadTransferCount>5000000000" get Processid
wmic /OUTPUT:%ParseVolumesLog% volume
@rem 
wmic /OUTPUT:%ParseDeviceIDsLogC% volume where (label="Sys") get Caption,DeviceID
wmic /OUTPUT:%ParseDeviceIDsLogF% volume where (label="Archive") get Caption,DeviceID
wmic /OUTPUT:%ParseDeviceIDsLogH% volume where (label="Games") get Caption,DeviceID
wmic /OUTPUT:%ParseDeviceIDsLogI% volume where (label="UserData") get Caption,DeviceID
wmic exit

:EOF
@rem @pause