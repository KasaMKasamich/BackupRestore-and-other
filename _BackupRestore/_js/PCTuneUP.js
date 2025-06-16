/* _EthernetEnable.js
 * Запуск комманды (.exe, .cmd, ...) запускает комманду из папки на один уровень выше текущей (RunInSameFolder)
*/
var fso = WScript.CreateObject("Scripting.FileSystemObject");
var WSHShell = WScript.CreateObject("WScript.Shell");
ParentDirectory = fso.GetParentFolderName(fso.GetParentFolderName(WScript.ScriptFullName));
Script = fso.BuildPath(ParentDirectory, "\_Utils/_PCTuneUP.cmd")
// WScript.Echo("",ParentDirectory);
// WScript.Echo("",Script);
WSHShell.Run(Script,0);