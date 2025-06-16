@echo off
setlocal EnableExtensions
setlocal EnableDelayedExpansion
set start=%date% %time% ***Clear Windows Defender Scans***
echo %start%
set Scans=C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service
rem 
RMDIR /S /Q "%Scans%"
@rem exit
