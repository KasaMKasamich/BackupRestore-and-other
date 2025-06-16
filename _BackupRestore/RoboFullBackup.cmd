:: Test Full Backup 2
rem F:\_BackupRestore\RoboFullBackup2.cmd
:: Часть, не закончен
:: 
cd /D %Dir[1]%\Microsoft\
@timeout /t 1 >nul
ROBOCOPY "OneDrive\settings" "%TempDirNBP%\%FileN[0]%\Microsoft\OneDrive\settings" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
cd /D %Dir[1]%\Microsoft\Windows\
@timeout /t 1 >nul
ROBOCOPY "Themes" "%TempDirNBP%\%FileN[0]%\Microsoft\Windows\Themes" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "BackgroundSlideshow" "%TempDirNBP%\%FileN[0]%\Microsoft\Windows\BackgroundSlideshow" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
::  AppData\LocalLow
@rem ROBOCOPY "%Dir[1]%" "%TempDirNBP%\%FileN[1]%" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
::  AppData\Roaming
cd /D %Dir[2]%\Microsoft\
@timeout /t 1 >nul
ROBOCOPY "VisualStudio" "%TempDirNBP%\%FileN[2]%\Microsoft\VisualStudio" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "Skype for Desktop" "%TempDirNBP%\%FileN[2]%\Microsoft\Skype for Desktop" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
cd /D %Dir[2]%\Microsoft\Windows\
@timeout /t 1 >nul
ROBOCOPY "AccountPictures" "%TempDirNBP%\%FileN[2]%\Microsoft\Windows\AccountPictures" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "Themes" "%TempDirNBP%\%FileN[2]%\Microsoft\Windows\Themes" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "SendTo" "%TempDirNBP%\%FileN[2]%\Microsoft\Windows\SendTo" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "PowerShell" "%TempDirNBP%\%FileN[2]%\Microsoft\Windows\PowerShell" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "Libraries" "%TempDirNBP%\%FileN[2]%\Microsoft\Windows\Libraries" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "Network Shortcuts" "%TempDirNBP%\%FileN[2]%\Microsoft\Windows\Network Shortcuts" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
::  Users\Public
cd /D C:\%UsersDir[0]%\
@timeout /t 1 >nul
ROBOCOPY "Desktop" "%TempDirNBP%\%FileN[3]%\Desktop" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "Foxit Software" "%TempDirNBP%\%FileN[3]%\Foxit Software" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "Documents\Unity Projects" "%TempDirNBP%\%FileN[3]%\\Documents\Unity Projects" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
::  Users\UserProfile
cd /D %userprofile%\
@timeout /t 1 >nul
ROBOCOPY ".android" "%TempBackupDir%\Users\%USERNAME%\.android" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY ".AndroidStudio3.1" "%TempBackupDir%\Users\%USERNAME%\.AndroidStudio3.1" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY ".BigNox" "%TempBackupDir%\Users\%USERNAME%\.BigNox" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY ".fontconfig" "%TempBackupDir%\Users\%USERNAME%\.fontconfig" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY ".swt" "%TempBackupDir%\Users\%USERNAME%\.swt" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY ".thumbnails" "%TempBackupDir%\Users\%USERNAME%\.thumbnails" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "AndroidStudioProjects" "%TempBackupDir%\Users\%USERNAME%\AndroidStudioProjects" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "NCH Software Suite" "%TempBackupDir%\Users\%USERNAME%\NCH Software Suite" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "Nox_share" "%TempBackupDir%\Users\%USERNAME%\Nox_share" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
ROBOCOPY "OneDrive" "%TempBackupDir%\Users\%USERNAME%\OneDrive" %RCParams% /LOG:"!RCLogFile!" %RCFileDataFlags%
:: 