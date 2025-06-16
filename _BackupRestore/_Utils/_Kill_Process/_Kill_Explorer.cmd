SetLocal EnableExtensions EnableDelayedExpansion
taskkill /F /T /IM Explorer.exe
cd /d C:\Users\New\Desktop\Serv\PSTools
pskill -t Explorer.exe
Explorer
Explorer /e,::{20D04FE0-3AEA-1069-A2D8-08002B30309D}
@rem psexec -i -s cmd.exe