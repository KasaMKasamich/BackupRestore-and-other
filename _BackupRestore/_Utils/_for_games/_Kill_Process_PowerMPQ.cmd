SetLocal EnableExtensions EnableDelayedExpansion
taskkill /F /T /IM PowerMPQ.exe
cd /d C:\Users\New\Desktop\Serv\PSTools
pskill -t PowerMPQ.exe
rem psexec -i -s cmd.exe