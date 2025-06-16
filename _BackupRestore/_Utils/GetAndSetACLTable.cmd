@rem GetAndSetACLTable
@rem 
@if "%dm%" == "" echo off
@if "%dm%" NEQ "" echo on
echo -- %dm%
@Title "Test Full Backup"
setlocal enableextensions
setlocal enabledelayedexpansion
rem Отобразить ACL папки: 
@rem cacls "C:\\" /s
@rem cacls "C:\Program Files" /s
@rem cacls "C:\Users\New\AppData\Local" /s
@rem 
rem Установить ACL на "I:\ProgramFiles" от "C:\Program Files"
:: cacls "I:\ProgramFiles" /s:"D:PAI(A;;FA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;0x1301bf;;;SY)(A;OICIIO;GA;;;SY)(A;;0x1301bf;;;BA)(A;OICIIO;GA;;;BA)(A;;0x1200a9;;;BU)(A;OICIIO;GXGR;;;BU)(A;OICIIO;GA;;;CO)(A;;0x1200a9;;;AC)(A;OICIIO;GXGR;;;AC)(A;;0x1200a9;;;S-1-15-2-2)(A;OICIIO;GXGR;;;S-1-15-2-2)"
@rem 
rem Установить ACL на "F:\ProgramFiles" от "C:\Program Files"
@rem cacls "F:\ProgramFiles" /s:"D:PAI(A;;FA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;0x1301bf;;;SY)(A;OICIIO;GA;;;SY)(A;;0x1301bf;;;BA)(A;OICIIO;GA;;;BA)(A;;0x1200a9;;;BU)(A;OICIIO;GXGR;;;BU)(A;OICIIO;GA;;;CO)(A;;0x1200a9;;;AC)(A;OICIIO;GXGR;;;AC)(A;;0x1200a9;;;S-1-15-2-2)(A;OICIIO;GXGR;;;S-1-15-2-2)"
@rem 
rem Установить ACL на "I:\ProgramFiles\_WebBrowserDatas" от "C:\Users\New\AppData\Local"
@rem cacls "I:\ProgramFiles\_WebBrowserDatas" /s:"D:(A;OICI;FA;;;SY)(A;OICI;FA;;;BA)(A;OICI;FA;;;S-1-5-21-183910270-2929241433-3244790027-1001)"
@rem 
@rem По умолчанию для версии 1803 Windows 10: 
@rem 
@rem "C:\Program Files" "D:PAI(A;;FA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;0x1301bf;;;SY)(A;OICIIO;GA;;;SY)(A;;0x1301bf;;;BA)(A;OICIIO;GA;;;BA)(A;;0x1200a9;;;BU)(A;OICIIO;GXGR;;;BU)(A;OICIIO;GA;;;CO)(A;;0x1200a9;;;AC)(A;OICIIO;GXGR;;;AC)(A;;0x1200a9;;;S-1-15-2-2)(A;OICIIO;GXGR;;;S-1-15-2-2)"
@rem "C:\Users\New\AppData\Local" "D:(A;OICI;FA;;;SY)(A;OICI;FA;;;BA)(A;OICI;FA;;;S-1-5-21-183910270-2929241433-3244790027-1001)"
@rem "F:\Program Files" "D:(A;;FA;;;BA)(A;OICIIO;GA;;;BA)(A;;FA;;;SY)(A;OICIIO;GA;;;SY)(A;;0x1301bf;;;AU)(A;OICIIO;SDGXGWGR;;;AU)(A;;0x1200a9;;;BU)(A;OICIIO;GXGR;;;BU)"
@rem 
@rem "C:\" "D:PAI(A;OICI;FA;;;BA)(A;OICI;FA;;;SY)(A;OICI;0x1200a9;;;BU)(A;OICIIO;SDGXGWGR;;;AU)(A;;LC;;;AU)"
@rem "F:\" "D:(A;;FA;;;BA)(A;OICIIO;GA;;;BA)(A;;FA;;;SY)(A;OICIIO;GA;;;SY)(A;;0x1301bf;;;AU)(A;OICIIO;SDGXGWGR;;;AU)(A;;0x1200a9;;;BU)(A;OICIIO;GXGR;;;BU)"
@rem "I:\" "D:PAI(A;;FA;;;S-1-5-21-183910270-2929241433-3244790027-1001)(A;OICIIO;FA;;;S-1-5-21-183910270-2929241433-3244790027-1001)(A;;FA;;;BA)(A;OICIIO;GA;;;BA)(A;;FA;;;SY)(A;OICIIO;GA;;;SY)(A;;0x1200a9;;;BU)(A;OICIIO;GXGR;;;BU)"
@rem 
@rem По умолчанию для версии 1903 Windows 10: 
@rem "C:\Users\New\AppData\Local" "D:P(A;OICI;FA;;;SY)(A;OICI;FA;;;BA)(A;OICI;FA;;;S-1-5-21-575730894-1686360391-2651317774-1003)"
@rem "C:\Program Files" "D:PAI(A;;FA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;0x1301bf;;;SY)(A;OICIIO;GA;;;SY)(A;;0x1301bf;;;BA)(A;OICIIO;GA;;;BA)(A;;0x1200a9;;;BU)(A;OICIIO;GXGR;;;BU)(A;OICIIO;GA;;;CO)(A;;0x1200a9;;;AC)(A;OICIIO;GXGR;;;AC)(A;;0x1200a9;;;S-1-15-2-2)(A;OICIIO;GXGR;;;S-1-15-2-2)"
@rem 
takeown /f "F:\\" /r /d y
@rem 
icacls "F:\\" /reset /T
@rem 
cacls "F:\ProgramFiles" /s:"D:PAI(A;;FA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;0x1301bf;;;SY)(A;OICIIO;GA;;;SY)(A;;0x1301bf;;;BA)(A;OICIIO;GA;;;BA)(A;;0x1200a9;;;BU)(A;OICIIO;GXGR;;;BU)(A;OICIIO;GA;;;CO)(A;;0x1200a9;;;AC)(A;OICIIO;GXGR;;;AC)(A;;0x1200a9;;;S-1-15-2-2)(A;OICIIO;GXGR;;;S-1-15-2-2)"
@rem 
takeown /f "I:\\" /r /d y
@rem 
icacls "I:\\" /reset /T
@rem 
@rem cd /d C:\Users\new\AppData\Local
@rem icacls C:\Users\new\AppData\Local /save "I:\ProgramFiles\acl"
@rem cd /d "I:\ProgramFiles"
@rem icacls "I:\ProgramFiles" /restore acl
cacls "I:\ProgramFiles\_WebBrowserDatas" /s:"D:(A;OICI;FA;;;SY)(A;OICI;FA;;;BA)(A;OICI;FA;;;S-1-5-21-575730894-1686360391-2651317774-1003)"
                             
@rem 
setlocal enableextensions
setlocal enabledelayedexpansion
chcp 1252 >nul
mkdir "I:\_TestPermission"
F:\ProgramFiles
icacls "I:\_TestPermission" /reset /T
cacls "I:\_TestPermission" /s:"D:PAI(A;;FA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;0x1301bf;;;SY)(A;OICIIO;GA;;;SY)(A;;0x1301bf;;;BA)(A;OICIIO;GA;;;BA)(A;;0x1200a9;;;BU)(A;OICIIO;GXGR;;;BU)(A;OICIIO;GA;;;CO)(A;;0x1200a9;;;AC)(A;OICIIO;GXGR;;;AC)(A;;0x1200a9;;;S-1-15-2-2)(A;OICIIO;GXGR;;;S-1-15-2-2)"
cacls "I:\_TestPermission" /s:"D:(A;;FA;;;BA)(A;OICIIO;GA;;;BA)(A;;FA;;;SY)(A;OICIIO;GA;;;SY)(A;;0x1301bf;;;AU)(A;OICIIO;SDGXGWGR;;;AU)(A;;0x1200a9;;;BU)(A;OICIIO;GXGR;;;BU)"

@rem Сброс безопасности
ROBOCOPY "I:\ProgramFiles\_WebBrowserDatas" "I:\ProgramFiles\_WebBrowserDatas2" /S /B /R:3 /W:2 /SL /MT:8 /DCOPY:DAT
F:\ProgramFiles\_TXT\NotepadPlusPlus\backup
ROBOCOPY "F:\ProgramFiles\_TXT\NotepadPlusPlus\backup" "F:\ProgramFiles\_TXT\NotepadPlusPlus\backup2" /S /B /R:3 /W:2 /SL /MT:8 /DCOPY:DAT


icacls F:\ /save "F:\acl"
icacls "F:\ProgramFiles" /restore "F:\acl_ProgramFiles.acl"

F:\ProgramFiles


