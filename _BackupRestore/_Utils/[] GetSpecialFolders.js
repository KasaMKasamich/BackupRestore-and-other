var fso = WScript.CreateObject("Scripting.FileSystemObject");
var l = fso.CreateTextFile("c:/_BackupRestore/__Logs/[] GetSpecialFolders/SpecialFolders.log");
//var l2 = fso.CreateTextFile("c:/_BackupRestore/__Logs/[] GetSpecialFolders/SpecialFolders2.log");
var WSHShell = WScript.CreateObject("wscript.shell");
WshFldrs = WSHShell.SpecialFolders;
s="List of all Special folders:"+"\r\n";
for (i=0;i<= WshFldrs.Count()-1;i++) {
	s+=WshFldrs(i)+"\r\n";
//	l.WriteLine(s);
}
l.WriteLine(s);
//l.Close;
WScript.Echo(s);
