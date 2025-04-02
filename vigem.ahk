#NoEnv
#SingleInstance Force
SetBatchLines -1 ; For performance

; --- Configuration ---
GEMINI_API_KEY := "AIzaSyC-_-uHjWmfZysK5nHcbGqbViZ68NhLz8Q" ; <<< IMPORTANT: Replace with your actual API Key!
; Model capable of vision input. gemini-1.5-flash-latest is generally recommended.
GEMINI_MODEL := "gemini-2.0-flash" 
; Hotkey to trigger the script
TRIGGER_HOTKEY := "^!g" ; Ctrl+Alt+G  <--- MODIFIED HOTKEY

; --- Library Includes ---
; Ensure Gdip.ahk and JSON.ahk are in the script's directory or AHK's Lib folder
#Include Gdip_All.ahk
#Include JSON.ahk

; --- Check API Key ---
if (GEMINI_API_KEY = "YOUR_GEMINI_API_KEY") {
    MsgBox, 48, Error, Please replace "YOUR_GEMINI_API_KEY" in the script with your actual Gemini API key.
    ExitApp
}

; --- Main Hotkey ---
; Assign the function to the specified hotkey
Hotkey, %TRIGGER_HOTKEY%, ExtractTextFromClipboardImage 
return ; End of auto-execute section

; --- Core Function ---
ExtractTextFromClipboardImage:
    ToolTip, Processing clipboard image...
    
    ; --- Step 1: Get Image from Clipboard using GDI+ ---
    pToken := Gdip_Startup()
    if (!pToken) {
        MsgBox, 16, GDI+ Error, Could not start GDI+. Please ensure Gdip.ahk is included correctly.
        ToolTip
        return
    }

    pBitmap := Gdip_CreateBitmapFromClipboard()
    if (!pBitmap) {
        MsgBox, 64, Info, No valid image found on the clipboard. Press %TRIGGER_HOTKEY% after copying an image.
        Gdip_Shutdown(pToken)
        ToolTip
        return
    }

    ; --- Step 2: Save Image temporarily as PNG ---
    TempImagePath := A_Temp . "\AHK_Gemini_Clip_Image_" . A_TickCount . ".png"
    MimeType := "image/png" 

    SaveResult := Gdip_SaveBitmapToFile(pBitmap, TempImagePath, 100) 
    Gdip_DisposeImage(pBitmap) 
    Gdip_Shutdown(pToken) 

    if (SaveResult != 0) { 
        MsgBox, 16, Error, Failed to save clipboard image to temporary file: %TempImagePath%`nError code: %SaveResult%
        ToolTip
        return
    }

    ; --- Step 3: Read Image File and Base64 Encode ---
    ToolTip, Encoding image...
    FileRead, ImgData, *c %TempImagePath% 
    if (ErrorLevel) {
        MsgBox, 16, Error, Failed to read temporary image file: %TempImagePath%
        FileDelete, %TempImagePath% 
        ToolTip
        return
    }

    Base64Image := Base64Encode(ImgData) 
    VarSetCapacity(ImgData, 0) 

    if (Base64Image = "") {
        MsgBox, 16, Error, Failed to Base64 encode the image data.
        FileDelete, %TempImagePath% 
        ToolTip
        return
    }

    ; --- Step 4: Prepare API Request ---
    ToolTip, Sending request to Gemini API...
    ApiUrl := "https://generativelanguage.googleapis.com/v1beta/models/" . GEMINI_MODEL . ":generateContent?key=" . GEMINI_API_KEY
    
    PromptText := "Extract text from this image. Respond ONLY with the extracted text, without any introductory phrases or formatting."

    JsonPayload := "{""contents"": [{""parts"":[{""text"": """ . JsonEscape(PromptText) . """},{""inline_data"": {""mime_type"":""" . MimeType . """, ""data"": """ . Base64Image . """}}]}]}"
    VarSetCapacity(Base64Image, 0) 

    ; --- Step 5: Send Request via WinHttpRequest ---
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("POST", ApiUrl, true) 
    whr.SetRequestHeader("Content-Type", "application/json")
    
    try {
        whr.Send(JsonPayload)
        whr.WaitForResponse() 
    } catch e {
        MsgBox, 16, API Error, Failed to send request to Gemini API.`n`nDetails: %e%
        FileDelete, %TempImagePath% 
        ToolTip
        return
    }

    ; --- Step 6: Process API Response ---
    ToolTip, Processing response...
    StatusCode := whr.Status
    ResponseText := whr.ResponseText

    if (StatusCode != 200) {
        MsgBox, 16, API Error, Gemini API returned status code: %StatusCode%`n`nResponse:`n%ResponseText%
        FileDelete, %TempImagePath% 
        ToolTip
        return
    }

    ; Parse the JSON response
    try {
        JsonResponse := JSON.Load(ResponseText)
    } catch e {
        MsgBox, 16, JSON Error, Failed to parse API response.`n`nResponse:`n%ResponseText%`n`nError: %e%
        FileDelete, %TempImagePath% 
        ToolTip
        return
    }

    ; Extract the text 
    ExtractedText := ""
    if IsObject(JsonResponse) 
        && JsonResponse.HasKey("candidates") 
        && JsonResponse.candidates.MaxIndex() >= 1 
        && JsonResponse.candidates[1].HasKey("content")
        && JsonResponse.candidates[1].content.HasKey("parts")
        && JsonResponse.candidates[1].content.parts.MaxIndex() >= 1
        && JsonResponse.candidates[1].content.parts[1].HasKey("text")
    {
        ExtractedText := Trim(JsonResponse.candidates[1].content.parts[1].text)
    } else {
        ExtractedText := "Could not find text in the expected response structure."
        ; FileAppend, % ResponseText, % A_ScriptDir "\Gemini_Debug_Response.txt" ; Uncomment for debugging
    }
    
    ToolTip ; Clear the tooltip

    ; --- Step 7: Display Result & Cleanup ---
    if (ExtractedText != "" && ExtractedText != "Could not find text in the expected response structure.") {
        Clipboard := ExtractedText ; Put the extracted text back on the clipboard
        MsgBox, 64, Extracted Text (from Ctrl+Alt+G), %ExtractedText%`n`n(Text also copied to clipboard)
    } else {
        MsgBox, 48, Warning, % "Gemini API did not return any usable text or the response format was unexpected.`n`nResponse snippet:`n`n" . SubStr(ResponseText, 1, 500) ; Show a snippet
        }

    FileDelete, %TempImagePath% ; Clean up the temporary image file
    
return ; End of hotkey function


; === Helper Functions ===

; --- Base64 Encoding Function using Windows API ---
; === Helper Functions ===

; --- Base64 Encoding Function using Windows API ---
Base64Encode(ByRef data) {
    local pData, nSize, pBase64Str, nBase64Len := 0
    local CRYPT_STRING_BASE64_NOCRLF := 0x1 | 0x40000000 ; Combine BASE64 and NOCRLF flags

    nSize := VarSetCapacity(data)
    pData := &data

    ; Call CryptBinaryToString to get the required buffer size, NO CRLF
    if (!DllCall("Crypt32.dll\CryptBinaryToString", "Ptr", pData, "UInt", nSize, "UInt", CRYPT_STRING_BASE64_NOCRLF, "Ptr", 0, "UIntP", nBase64Len, "UInt")) {
        Return "" ; Error
    }
    
    if (nBase64Len = 0) {
        Return "" ; No data or error
    }

    ; Allocate buffer for the Base64 string (WCHAR format, so * 2 bytes)
    VarSetCapacity(Base64Str, nBase64Len * 2, 0) ; *2 for WCHAR, init with 0
    pBase64Str := &Base64Str

    ; Call CryptBinaryToString again to perform the encoding, NO CRLF
    if (!DllCall("Crypt32.dll\CryptBinaryToString", "Ptr", pData, "UInt", nSize, "UInt", CRYPT_STRING_BASE64_NOCRLF, "Ptr", pBase64Str, "UIntP", nBase64Len, "UInt")) {
        Return "" ; Error
    }
    
    ; Convert the Pointer to an AHK String (UTF-16/WCHAR from API)
    ; nBase64Len includes the null terminator from the API, so subtract 1 for StrGet length
    Return StrGet(pBase64Str, nBase64Len - 1, "UTF-16") 
}


; --- JSON String Escaping Function ---
JsonEscape(str) {
    StringReplace, str, str, \, \\, All 
    StringReplace, str, str, ", \", All 
    StringReplace, str, str, `n, \n, All 
    StringReplace, str, str, `r, \r, All 
    StringReplace, str, str, `t, \t, All 
    return str
}

; --- End of Script ---
