#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force ; Ensures only one instance of the script runs at a time.

; --- Configuration ---
; Define the hotkeys for each case type
; ^ = Ctrl
; ! = Alt
Hotkey, ^!L, ChangeToLower ; Ctrl+Alt+L for Lowercase
Hotkey, ^!U, ChangeToUpper ; Ctrl+Alt+U for Uppercase
Hotkey, ^!T, ChangeToTitle ; Ctrl+Alt+T for Title Case

Return ; End of auto-execute section

; --- Hotkey Subroutines ---
ChangeToLower:
    ChangeSelectedTextCase("Lower")
Return

ChangeToUpper:
    ChangeSelectedTextCase("Upper")
Return

ChangeToTitle:
    ChangeSelectedTextCase("Title")
Return

; --- Core Function ---
ChangeSelectedTextCase(caseType)
{
    ; 1. Backup Current Clipboard
    ClipboardSaved := ClipboardAll ; Backup everything (text, files, images, etc.)
    Clipboard := "" ; Clear the clipboard to ensure ClipWait detects new content

    ; 2. Copy Selected Text
    Send, ^c
    ClipWait, 0.7 ; Wait up to 0.7 seconds for text to appear on the clipboard
    
    ; 3. Check if Copy Succeeded (if clipboard is still empty, likely nothing was selected)
    If (ErrorLevel OR Clipboard = "")
    {
        MsgBox, 48, Error, No text selected or failed to copy.`nOriginal clipboard restored. ; 48 = Exclamation icon
        Clipboard := ClipboardSaved ; Restore original clipboard on error
        VarSetCapacity(ClipboardSaved, 0) ; Clear the variable holding the backup
        Return ; Stop the function
    }

    ; 4. Store the Selected Text
    SelectedText := Clipboard ; Store the copied text

    ; 5. Change Case based on parameter
    If (caseType = "Lower")
    {
        StringLower, ModifiedText, SelectedText
    }
    Else If (caseType = "Upper")
    {
        StringUpper, ModifiedText, SelectedText
    }
    Else If (caseType = "Title")
    {
        StringUpper, ModifiedText, SelectedText, T ; 'T' flag enables Title case
    }
    Else ; Should not happen with current hotkeys, but good practice
    {
        MsgBox, 16, Error, Invalid case type specified: %caseType%`nOriginal clipboard restored. ; 16 = Stop icon
        Clipboard := ClipboardSaved ; Restore original clipboard on error
        VarSetCapacity(ClipboardSaved, 0) ; Clear the variable holding the backup
        Return ; Stop the function
    }

    ; 6. Paste Modified Text
    Clipboard := ModifiedText ; Put the modified text onto the clipboard
    Sleep, 50 ; Short pause to ensure clipboard is ready before pasting
    Send, ^v

    ; 7. Restore Original Clipboard (after a short delay to allow paste to finish)
    Sleep, 100 ; Give the paste command time to execute
    Clipboard := ClipboardSaved
    
    ; 8. Clean up temporary variables
    VarSetCapacity(ClipboardSaved, 0) ; Clear the variable holding the backup
    SelectedText := ""
    ModifiedText := ""
}

