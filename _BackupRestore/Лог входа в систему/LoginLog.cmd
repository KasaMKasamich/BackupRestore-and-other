@echo off
SetLocal EnableExtensions EnableDelayedExpansion
chcp 1251 >nul
@echo "Вход выполнен под пользователем %USERNAME% - %date% | %time%" >> C:\Users\Public\Desktop\Login.txt
exit
