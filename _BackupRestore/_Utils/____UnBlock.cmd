@echo on
Title "Unblock-Files"
SetLocal EnableExtensions EnableDelayedExpansion
@rem chcp 1251 >nul
chcp 1252 >nul
@rem chcp 866 >nul
@rem powershell -Command "get-childitem '%1' dir -Recurse | Unblock-File"
cd /d "%1"
@rem powershell -Command "Set-Location '%1'"
@rem powershell -Command "Set-Location '%1' | dir -Recurse | Unblock-File"
powershell -Command "dir -Recurse | Unblock-File"

@rem pause