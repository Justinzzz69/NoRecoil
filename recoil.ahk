; Hotkey
Gui, Add, Text, xm ym+3, Hotkey:
Gui, Add, Hotkey, xm+40 ym vHotkeyC w240, % HotkeyCC := "End"
Hotkey, End, CheckBox

; Speed
Gui, Add, Text, xm ym+33, Speed:
Gui, Add, Edit, xm+40 ym+30 vSpeed w240 ,1

; Toggle Script
Gui, Add, CheckBox, xm+200 ym+67 vED gCheckBox, Toggle Script

; Apply Changes Button
Gui, Add, Button, xm ym+60 w100, Apply Changes

Gui, Show, w300

Hotkey, LButton, LeftButton, Off
Hotkey, LButton Up, LeftButtonUp, Off
Return

GuiClose:
ExitApp

LeftButton:
    Gui, Submit, NoHide
    SendInput, {LButton Down}
    SetTimer, DragDown, % 10 / Speed
Return

LeftButtonUp:
    SendInput, {LButton Up}
    SetTimer, DragDown, Off
Return

DragDown:
    Gui, Submit, NoHide
    DllCall("mouse_event", "UInt", 0x01, "UInt", 0, "UInt", 1 + Speed)
Return

CheckBox:
    Gui, Submit, NoHide
    If (A_ThisHotkey = HotkeyCC)
        GuiControl,, ED, % !ED
    Gui, Submit, NoHide
    Stat := (ED) ? "On" : "Off"
    Hotkey, LButton, % Stat
    Hotkey, LButton Up, % Stat
Return

ButtonApplyChanges:
    Gui, Submit, NoHide
    If (HotkeyC != HotkeyCC) {
        Hotkey, % HotkeyCC, CheckBox, Off
        Hotkey, % HotkeyCC := HotkeyC, CheckBox, On
    }

    ; Call Python script to update UUID
    RunWait, python update_uuid.py,, Hide

    ; Optional: Display a message box indicating that the UUID has been updated
    MsgBox, The UUID has been updated.

Return
