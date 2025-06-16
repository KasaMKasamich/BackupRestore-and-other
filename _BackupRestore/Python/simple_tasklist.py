from pywinauto.application import Application
app = Application.start("notepad.exe")
app.UntitledNotepad.TypeKeys("%FX")
