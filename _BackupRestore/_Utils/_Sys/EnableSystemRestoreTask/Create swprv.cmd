sc create swprv binPath= C:\Windows\System32\svchost.exe DisplayName= "Программный поставщик теневого копирования (Microsoft)" type= own start= demand error= normal depend= rpcss obj= LocalSystem
@pause
