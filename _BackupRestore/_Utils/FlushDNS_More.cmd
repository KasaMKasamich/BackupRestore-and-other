SetLocal EnableExtensions EnableDelayedExpansion
ipconfig /flushdns
nbtstat -RR
netsh int ip reset
netsh interface ip delete arpcache
netsh winsock reset
netsh winsock reset catalog
@timeout 5
ipconfig /registerdns
@rem @rem exit
