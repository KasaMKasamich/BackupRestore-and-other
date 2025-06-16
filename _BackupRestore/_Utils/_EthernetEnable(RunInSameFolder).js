/* _EthernetEnable(RunInSameFolder).js
 * Запуск комманды (.exe, .cmd, ...) запускается из той же папки где лежит запускаемая комманда (RunInSameFolder)
*/
var fso = WScript.CreateObject("Scripting.FileSystemObject");
var WSHShell = WScript.CreateObject("WScript.Shell");
Directory = fso.GetParentFolderName(WScript.ScriptFullName);
Script = fso.BuildPath(Directory, "\_EthernetEnable.cmd")
// WScript.Echo("",Directory);
// WScript.Echo("",Script);
WSHShell.Run(Script,0);