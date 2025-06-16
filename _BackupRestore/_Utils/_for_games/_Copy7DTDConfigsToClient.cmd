@echo off
set startcopy7dtdconfigs=%date% %time% Starting copy 7DTD Configs To Client
echo %startcopy7dtdconfigs%
SetLocal EnableExtensions EnableDelayedExpansion
set serverconfigspath=D:\_Servers\7DTD\Server_7DTD\Default\Data\Config
set clientconfigspath=D:\Games\7 Days To Die\Data\Config
mkdir "%clientconfigspath%\"
ROBOCOPY "%serverconfigspath%" /E /Z /R:3 /W:2 "%clientconfigspath%"
REM copy /Y "D:\_Servers\7DTD\Server_7DTD\Default\7DTDServer_Data\Managed\Assembly-CSharp.dll" "D:\Games\7 Days To Die\7DaysToDie_Data\Managed\Assembly-CSharp.dll"
@timeout 1
exit
