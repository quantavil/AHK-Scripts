#SingleInstance force
SetWorkingDir %A_ScriptDir%

; --- Configuration ---
apiKey := "" ; --- PASTE YOUR KEY HERE ---
basePrompt := "Extract all vocabulary words and their synonyms from the given text, convert them to uppercase, and join them using semicolons"
curlPath := "curl.exe" ; Use full path if not in system PATH
#Include JSON.ahk      ; Include JSON library (ensure it's accessible)

; --- Hotkey ---
^!g::GoSub, ProcessSelectedText

; --- Main Logic ---
ProcessSelectedText:
    originalClipboard := ClipboardAll
    Clipboard := ""
    SendInput, ^c
    ClipWait, 0.5 ; Wait max 0.5 seconds for clipboard
    selectedText := Clipboard
    Clipboard := originalClipboard ; Restore clipboard quickly

    if (ErrorLevel || selectedText = "")
    {
        MsgBox, 48, Input Error, No text selected or failed to copy text.
        Return
    }

    ToolTip, Processing with Gemini...

    ; Prepare JSON payload using systemInstruction for the prompt
    escapedBasePrompt := StrReplace(basePrompt, """", "\""")
    escapedSelectedText := StrReplace(selectedText, """", "\""")
    jsonPayload := "{""systemInstruction"": {""parts"":[{""text"": """ . escapedBasePrompt . """}]}, ""contents"": [{""role"": ""user"", ""parts"":[{""text"": """ . escapedSelectedText . """}]}]}"

    apiUrl := "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-thinking-exp-01-21:generateContent?key=" . apiKey
    tempPayloadFile := A_Temp . "\gemini_payload_" . A_TickCount . ".json"

    ; Write payload to temp file (more robust for curl)
    Try FileDelete, %tempPayloadFile%
    Try FileAppend, %jsonPayload%, %tempPayloadFile%, UTF-8
    IfNotExist, %tempPayloadFile%
    {
        ToolTip ; Remove tooltip before showing error
        MsgBox, 16, File Error, Failed to create temporary payload file for curl.
        Return
    }

    ; Construct and run curl command
    curlCommand := curlPath . " """ . apiUrl . """ -H ""Content-Type: application/json"" -X POST -d @""" . tempPayloadFile . """ --silent --show-error"
    apiResponse := RunWaitWithOutput(curlCommand)
    Try FileDelete, %tempPayloadFile% ; Clean up temp file
    ToolTip ; Remove tooltip

    ; Basic check for curl execution errors or API errors (look for "error" key)
    if (apiResponse = "" or InStr(apiResponse, """error"""))
    {
        MsgBox, 16, API/Curl Error, Failed to get a valid response or API returned an error.`n`nResponse:`n%apiResponse%
        Return
    }

    ; Parse JSON and extract text
    Try {
        jsonObj := JSON.Load(apiResponse)
        ; Safely access nested structure
        if ( jsonObj.HasKey("candidates") && jsonObj.candidates._MaxIndex() >= 1
        && jsonObj.candidates[1].HasKey("content") && jsonObj.candidates[1].content.HasKey("parts")
        && jsonObj.candidates[1].content.parts._MaxIndex() >= 1 && jsonObj.candidates[1].content.parts[1].HasKey("text") )
        {
             generatedText := jsonObj.candidates[1].content.parts[1].text
        } else {
             generatedText := "" ; Default to empty if structure is not as expected
        }

        if (generatedText = "") {
             MsgBox, 48, Parse Warning, API response parsed, but no generated text found in the expected location.`n`nResponse:`n%apiResponse%
             Return
        }

        ; Replace selection
        Clipboard := generatedText
        Sleep, 150 ; Allow clipboard to update
        SendInput, ^v

    } Catch e {
        MsgBox, 16, JSON Parse Error, Failed to parse the API response.`nError: %e%`n`nRaw Response:`n%apiResponse%
        Return
    }
Return

; --- Helper Function to Run Command and Capture Output (StdOut & StdErr) ---
RunWaitWithOutput(command) {
    objShell := ComObjCreate("WScript.Shell")
    objExec := objShell.Exec(ComSpec " /C " command . " 2>&1") ; Redirect stderr to stdout
    stdOut := objExec.StdOut.ReadAll()
    Return stdOut
}
