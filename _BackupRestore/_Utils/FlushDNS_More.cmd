SetLocal EnableExtensions EnableDelayedExpansion
ipconfig /flushdns
nbtstat -RR
netsh int ip reset
cmd is netsh winsock reset
netsh interface ip delete arpcache
REM netsh winsock reset catalog
@timeout 5
ipconfig /registerdns
@rem @rem exit
