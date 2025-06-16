@echo off
SetLocal EnableExtensions EnableDelayedExpansion
set start=%date% %time% ***Starting cleanup Software Distribution Download***
echo %start%
set Dir001=C:\Windows\SoftwareDistribution\Download
del /F /S /Q "%Dir001%\*.*"
timeout 3
EndLocal
@rem exit
