;#NoTrayIcon
full_command_line := DllCall("GetCommandLine", "str")

if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}

;MsgBox A_IsAdmin: %A_IsAdmin%`nCommand line: %full_command_line%

EnvGet, CommonProgramFilesx86, CommonProgramFiles(x86)
EnvGet, CommonProgramFiles, CommonProgramFiles

SetRegView 64
RegRead, 32VST2Path, HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\VST, VSTPluginsPath
IF ErrorLevel != 0
	msgbox, 4, VST2 System Plugin Folder Manager, The 32-bit VST Plugins Path is not set. Would you like to create the plugins folder %CommonProgramFilesx86%\VST2 and configure the registry?
	IfMsgBox, Yes
	{
		FileCreateDir, %CommonProgramFilesx86%\VST2
		RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\VST, VSTPluginsPath, %CommonProgramFilesx86%\VST2
		RegRead, 32VST2Path, HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\VST, VSTPluginsPath
	}
RegRead, 64VST2Path, HKEY_LOCAL_MACHINE\SOFTWARE\VST, VSTPluginsPath
IF ErrorLevel != 0
	msgbox, 4, VST2 System Plugin Folder Manager, The 64-bit VST Plugins Path is not set. Would you like to create the plugins folder %CommonProgramFiles%\VST2 and configure the registry?
	IfMsgBox, Yes
	{
		FileCreateDir, %CommonProgramFiles%\VST2
		RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SOFTWARE\VST, VSTPluginsPath, %CommonProgramFiles%\VST2
		RegRead, 64VST2Path, HKEY_LOCAL_MACHINE\SOFTWARE\VST, VSTPluginsPath
	}
Gui, New,, VST2 System Plugin Folder Manager
Gui, Show, X200 Y200 W500 H90, VST2 System Plugin Folder Manager
Gui, Add, Text,, 32-bit VST2 Folder:
Gui, Add, Text,, 64-bit VST2 Folder:
Gui, Add, Edit, v32VST2 ReadOnly ym w340, %32VST2Path%  ; The ym option starts a new column of controls.
Gui, Add, Edit, v64VST2 ReadOnly w340, %64VST2Path%
Gui, Add, Button, gButtonSave, Save Changes and Exit
Gui, Add, Button, ym w30 h20 v32VST2New gSelect32File, ... 
Gui, Add, Button, w30 h20 v64VST2New gSelect64File, ... 
return  ; End of auto-execute section. The script is idle until the user does something.


ButtonSave:
	Gui, Submit  ; Save the input from the user to each control's associated variable.
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\VST, VSTPluginsPath, %32VST2Path%
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SOFTWARE\VST, VSTPluginsPath, %64VST2Path%
	MsgBox, 0, VST2 System Plugin Folder Manager, Changes have been saved.
	ExitApp

GuiClose:
	ExitApp

Select32File:
  FileSelectFolder, 32NewVST2Path, *%32VST2Path%, 3, Select a Folder for 32-bit VST Plugins
  IF ErrorLevel = 0
    32VST2Path := RegExReplace(32NewVST2Path, "\\$")
    GuiControl,,32VST2,%32VST2Path%
Return

Select64File:
  FileSelectFolder, 64NewVST2Path, *%64VST2Path%, 3, Select a Folder for 64-bit VST Plugins
  IF ErrorLevel = 0
    64VST2Path := RegExReplace(64NewVST2Path, "\\$")
    GuiControl,,64VST2,%64VST2Path%
Return


