# AHK-Scripts

## keymap.ahk
This script contains two main functionalities:

Key Remapping: It remaps the right Ctrl key to send Ctrl+X (cut) and the right Alt key to send Ctrl+V (paste).
Emoji and Text Shortcuts: It assigns various emoji and text snippets to Alt key combinations (Alt+1 to Alt+9 and Alt+0). When these key combinations are pressed, the corresponding emoji or text is sent or pasted.
README.md
This file is the readme document for the AHK-Scripts repository. It provides an overview and documentation for the scripts included in the repository. Currently, it is empty and requires content to describe the repository.

## JSON.ahk
This script is a library for handling JSON in AutoHotkey. It includes a class JSON with methods for parsing JSON strings into AutoHotkey values (Load) and converting AutoHotkey values into JSON strings (Dump). It also has support for handling custom serialization and deserialization with optional parameters for reviver and replacer functions.

## case.ahk
This script allows for changing the case of selected text in various ways:

Ctrl+Alt+L: Changes the selected text to lowercase.
Ctrl+Alt+U: Changes the selected text to uppercase.
Ctrl+Alt+T: Changes the selected text to title case. The script works by copying the selected text, changing its case, and then pasting the modified text back.

## gemini.ahk
This script integrates with the Gemini API to process selected text. It performs the following steps:
Copies the selected text to the clipboard.
Sends a request to the Gemini API with a prompt to extract vocabulary words and their synonyms from the selected text, convert them to uppercase, and join them using semicolons.
Replaces the selected text with the processed text from the API response. The script includes configuration options for the API key, prompt, and path to the curl executable. It also uses a JSON library for handling the API response.

## vigem.ahk
AHK Script: Extract Text from Clipboard Image using Gemini API
This AutoHotkey (v1.1) script provides Optical Character Recognition (OCR) like functionality by leveraging the Google Gemini Vision API. When you copy an image to the clipboard and press the Ctrl+Alt+G hotkey, the script sends the image to the Gemini API, extracts any text found within it, displays the text in a message box, and automatically copies the extracted text back to the clipboard for immediate use.

## Gdip_All.ahk
The Gdip_All.ahk script is a comprehensive AutoHotkey (AHK) script that provides an extensive set of functions for working with GDI+ graphics in AHK. It includes various functions for drawing, handling bitmaps, performing operations with device contexts (DCs), and working with system colors and icons. This script supports both AHK v1 and v2, ensuring compatibility across different versions. It is a modified and updated version of the original GDI+ library by tic (Tariq Porter), with contributions from several other developers to fix bugs and add new features.
