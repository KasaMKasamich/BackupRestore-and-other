var objShellApp = new ActiveXObject('Shell.Application');
var Folder = objShellApp.BrowseForFolder(0, 'SELECT FOLDER',1+2+64+512+16);
WScript.Echo(Folder)