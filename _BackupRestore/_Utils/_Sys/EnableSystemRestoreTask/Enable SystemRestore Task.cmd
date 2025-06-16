reg delete "HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\SystemRestore" /v "DisableSR" /f
reg delete "HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\SystemRestore" /v "DisableConfig" /f
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SPP\Clients" /v " {09F7EDC5-294E-4180-AF6A-FB0E6A0E9513}" /t REG_MULTI_SZ /d "1" /f
srtasks ExecuteScheduledSPPCreation
@rem schtasks /Change /TN "Microsoft\\Windows\\SystemRestore\\SR" /Enable
schtasks /Change /TN "Microsoft\Windows\SystemRestore\SR" /Enable
net start vss
@pause
