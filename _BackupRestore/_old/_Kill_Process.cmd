SetLocal EnableExtensions EnableDelayedExpansion
taskkill /F /T /IM TrayTorrent.exe
cd /d C:\Users\New\Desktop\Serv\PSTools
pskill -t TrayTorrent.exe
rem psexec -i -s cmd.exe