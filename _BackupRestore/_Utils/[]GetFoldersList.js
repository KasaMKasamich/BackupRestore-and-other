var fso = WScript.CreateObject("Scripting.FileSystemObject");
var l = fso.CreateTextFile("c:/_BackupRestore/__Lists/[]GetFoldersList.txt");
var WSHShell = WScript.CreateObject("wscript.shell");
WshFldrs = WSHShell.SpecialFolders;
s="";
for (i=0;i<= WshFldrs.Count()-1;i++) {
	s+=WshFldrs(i)+"\r\n";
//	l.WriteLine(s);
}
l.WriteLine(s);
//l.Close;
WScript.Echo(s);
