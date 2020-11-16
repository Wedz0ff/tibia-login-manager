SCRIPT_CREATOR = "Wed"
SCRIPT_VERSION = 1.2

favicon := A_Temp "\favicon.png"
if !FileExist(favicon){
	UrlDownloadToFile, https://i.imgur.com/b8XqdU3.png, % favicon := A_Temp "\favicon.png"
}

reifu := A_Temp "\reifu.png"
if !FileExist(reifu){
	UrlDownloadToFile, https://i.imgur.com/2llNWX3.png, % reifu := A_Temp "\reifu.png"
}

iniFile := A_MyDocuments "\accountList.ini"
if !FileExist(iniFile){
	FileAppend , [Account 01]`nemail=a@a.com`npassword=lol123`n`n[Wedzy]`nemail=a@a.com`npassword=lol123`n`n[Eternal Oblivion]`nemail=a@a.com`npassword=lol123, %A_MyDocuments%\accountList.ini
}

#SingleInstance Force
#NoEnv
SetBatchLines -1
SetKeyDelay, 2
SendMode Input
Menu,Tray,Icon, %A_Temp%\favicon.png, , 1
Menu, Tray, NoStandard
Menu, Tray, Add , &Config, ConfigFile 
Menu, Tray, Add , Exit, ButtonExit

accLogin(ByRef Acc, ByRef Pass){
	random, waitTime, 150, 400
	IfWinExist, ahk_exe client.exe
	WinActivate
	clipboard := Acc
	Send ^v
	Sleep, waitTime
	Send, {TAB}
	clipboard := Pass
	Send ^v
	Sleep, waitTime
	Send, {ENTER}
	clipboard := ""
	ExitApp
}

IniRead, sectionNames, %A_MyDocuments%\accountList.ini
charList := StrReplace(sectionNames, "`n", "|")

Gui +Resize -MinimizeBox -MaximizeBox +AlwaysOnTop
Gui Add, Text, x164 y320 w120 h23 +0x200, Version: %SCRIPT_VERSION%
Gui Add, Picture, x72 y19 w66 h86, %A_Temp%\reifu.png
Gui Add, ListBox, hWndhLbxItems x56 y136 w120 h147 gAction vcharName +0x100, %charList%
Gui Show, w224 h342, Tibia Login
Gui, Show, ,, Actions

Action:
If ((A_GuiEvent = "DoubleClick") || (Trigger_Action))
{
	Gui, Submit
	IniRead, acc, %A_MyDocuments%\accountList.ini, %charName%, email
	IniRead, pw, %A_MyDocuments%\accountList.ini, %charName%, password
	accLogin(acc, pw)
}	
Return

Gui Show, w224 h315, Window
Return

ConfigFile:
Run, edit "%A_MyDocuments%\accountList.ini"
Return

ButtonExit:
ExitApp

GuiEscape:
GuiClose:
    ExitApp
