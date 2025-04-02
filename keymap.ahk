#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; -----------------------------
; SCRIPT 1: Key Remapping
RCtrl::^x  ; Right Ctrl sends Ctrl+X (Cut)
RAlt::^v   ; Right Alt sends Ctrl+V (Paste)



; -----------------------------
; SCRIPT 2: Emoji and Text Shortcuts

; Emoji Shortcuts for AHK v1
!1::  ; Alt+1
    SendInput, 🪐
return

!2::  ; Alt+2
    SendInput, 🌟
return

!3::  ; Alt+3
    SendInput, 💫
return

!4::  ; Alt+4
    SendInput, ✨
return

!5::  ; Alt+5
    SendInput, 🚀
return

!6::  ; Alt+6
    clipboard =
    (
    ; Insert your text or emoji here.
    )
clipwait, 2
Send, ^v
return

!7::  ; Alt+7
    clipboard =
    (
    ; Insert your text or emoji here.
    )
clipwait, 2
Send, ^v
return

; ONLY FOR WORDS
!8::  ; Alt+8
    clipboard =
    (
    ; Insert your text here.
    )
clipwait, 2
Send, ^v 
return

; OWS
!9::  ; Alt+9
    clipboard =
    (
I will provide you with a word, phrase, or idiom. Generate a response strictly following the format and instructions below. Ensure accuracy, clarity, and adherence to the structural details.

### [Word/Phrase/Idiom]
@@
**[Part of Speech 1, e.g., Noun]** | हिंदी: [Hindi Term 1a / Hindi Term 1b]; [Hindi Term 2] : [Concise English Meaning for Term 1a/1b]; [Concise English Meaning for Term 2].
**[Part of Speech 2, e.g., Verb]** | हिंदी: [Hindi Term 3]; [Hindi Term 4] : [Concise English Meaning for Term 3]; [Concise English Meaning for Term 4].
*(Use separate lines for each major Part of Speech. Use `/` between Hindi terms that are synonymous for the *same* specific meaning. Use `;` to separate distinct Hindi terms corresponding to distinct English meanings listed in the same order after the colon.)*

- ***Synonyms***:
    - **[Part of Speech 1]:**
        - *[Meaning Hint 1]:* Synonym1, Synonym2, Synonym3
        - *[Meaning Hint 2]:* Synonym4, Synonym5
    - **[Part of Speech 2]:**
        - *[Meaning Hint 3]:* SynonymA, SynonymB
    *(Group synonyms by Part of Speech, then by specific meaning using an italicized meaning hint. List only English synonyms, separated by commas. Do not include Hindi here.)*

- ***Antonyms***:
    - **[Part of Speech 1]:**
        - *[Meaning Hint 1]:* Antonym1, Antonym2
        - *[Meaning Hint 2]:* Antonym3, Antonym4
    - **[Part of Speech 2]:**
        - *[Meaning Hint 3]:* AntonymA, AntonymB
    *(Follow the exact same structure as Synonyms. List only English antonyms. If no relevant antonyms exist for a specific meaning or for the entire word/phrase, omit that line or the entire Antonyms section.)*

_Example_:
1.  [Example sentence with the **word/phrase** in bold]. *(Part of Speech: specific meaning hint)*
2.  [Second example sentence for a different meaning/POS]. *(Part of Speech: specific meaning hint)*
*(Provide at least one example sentence for each distinct meaning/POS* defined above. Ensure the word/phrase is bolded. The clarification in parentheses should state the Part of Speech and a brief English hint corresponding to the meaning being illustrated.)*

_Word Form Examples_
[List all relevant word forms derived from the base word, past tense, comparative/superlative forms, noun/verb/adjective forms, etc. ]
For each derived word:
[Derived word] : 
[Contextual sentence using the derived word]*(Part of Speech)*
[Synonyms: [2-6 most relevant direct synonyms for the derived form]]

HERE IS AN EXAMPLE RESULT THAT YOU NEED TO REPRODUCE:

### MANDATE
@@
**Noun** | हिंदी: आदेश/जनादेश; अधिदेश : An official order or commission to do something; The authority granted by a constituency to act as its representative.
**Verb** | हिंदी: आदेश देना; अनिवार्य करना : To authorize or command officially; To require something by law or formal decision.
- ***Synonyms***:
    - **Noun:**
        - *Official order:* Command, directive, instruction, authorization, commission
        - *Political authority:* Authority, sanction, approval, endorsement
    - **Verb:**
        - *Order officially:* Decree, direct, command, require, prescribe
_Example_:
1. The government issued a **mandate** requiring masks in all public spaces. *(Noun: official order)*
2. After winning the election, she claimed a **mandate** to implement her proposed reforms. *(Noun: authority from voters)*
3. Federal law **mandates** that employers provide a safe workplace. *(Verb: requires by law)*

_Word Form Examples_  
1. **MANDATORY**: 🌟  
   - Wearing helmets is **mandatory** for all motorcycle riders in this country. *(Adjective: required by rule or law)*  
   - ***Synonyms***: compulsory, obligatory, required, essential, binding  
2. **MANDATED**:  
   - The policy was **mandated** by the board of directors to ensure compliance. *(Adjective: officially ordered)*  
   - ***Synonyms***: decreed, enforced, prescribed, imposed, authorized  

=====

NOTE : NEVER FORGET "=====" AT END .
And add 🌟 important word forms and *(Rare)* when the word is rare or obscure
RETURN IN SINGLE CODE BLOCK
IF YOU UNDERSTAND ALL ABOVE INSTRUCTIONS JUST SAY "Yes".
    )
clipwait, 2
Send, ^v 
return

; FOR WORDS WITH MULTIPLE MEANINGS OR FORMS 
!0::  ; Alt+0
    clipboard =
    (
I will provide you with a word, phrase, or idiom. Generate a response strictly following the format and instructions below. Ensure accuracy, clarity, and adherence to the structural details.

 IF SINGLE MEANINGS :
### Phrase/Idiom/Phrasal Verb/ OWS
@@
[All applicable forms of Part of Speech] | हिंदी: [translation]  : [Concise English Meaning for the Term]
- ***Synonyms***: [2-6 most relevant direct synonyms or similar expressions]
_Example_ : [Provide one strong, contextual sentence showing primary usage.] *(Part of Speech: specific meaning hint)*

If necessary (e.g., for multiple meanings or forms), include an additional example to enhance clarity.

=====

HERE IS AN EXAMPLE RESULT THAT YOU NEED TO REPRODUCE IF SINGLE MEANINGS :

### PROXIMITY
@@
**Noun** | हिंदी: निकटता : The state of being near in space, time, or relationship.
- ***Synonyms***: Closeness, nearness, vicinity, adjacency, proximity
_Example_: The **proximity** of the coffee shop to the office made it a popular spot for afternoon breaks. *(Noun: state of being close or nearby)*

=====

IF MORE MULTIPLE MEANINGS  :

### Word/Phrase/Idiom
@@
**[Part of Speech 1, e.g., Noun]** | हिंदी: [Hindi Term 1a / Hindi Term 1b]; [Hindi Term 2] : [Concise English Meaning for Term 1a/1b]; [Concise English Meaning for Term 2].
**[Part of Speech 2, e.g., Verb]** | हिंदी: [Hindi Term 3]; [Hindi Term 4] : [Concise English Meaning for Term 3]; [Concise English Meaning for Term 4].
*(Use separate lines for each major Part of Speech. Use / between Hindi terms that are synonymous for the *same* specific meaning. Use ; to separate distinct Hindi terms corresponding to distinct English meanings listed in the same order after the colon.)*
- ***Synonyms***:
    - **[Part of Speech 1]:**
        - *[Meaning Hint 1]:* Synonym1, Synonym2, Synonym3
        - *[Meaning Hint 2]:* Synonym4, Synonym5
    - **[Part of Speech 2]:**
        - *[Meaning Hint 3]:* SynonymA, SynonymB
    *(Group synonyms by Part of Speech, then by specific meaning using an italicized meaning hint. List only English synonyms, separated by commas. Do not include Hindi here.)*
_Example_:
1.  [Example sentence with the **word/phrase** in bold]. *(Part of Speech: specific meaning hint)*
2.  [Second example sentence for a different meaning/POS]. *(Part of Speech: specific meaning hint)*
*(Provide at least one example sentence for each distinct meaning/POS* defined above. Ensure the word/phrase is bolded. The clarification in parentheses should state the Part of Speech and a brief English hint corresponding to the meaning being illustrated.)*

=====

HERE IS AN EXAMPLE RESULT THAT YOU NEED TO REPRODUCE:

### ACCOMPLICE
@@
**Noun** | हिंदी: सह-अपराधी: A person who helps another commit a crime or wrongdoing.
- ***Synonyms***:
    - **Noun:**
        - *Partner in Crime:* Collaborator, conspirator, associate, accessory, aide, abettor
_Example_:
1. The thief was caught, but his **accomplice** managed to escape. *(Noun: partner in crime)*

=====

NOTE : NEVER FORGET "=====" AT END .
And add 🌟 important word forms and *(Rare)* when the word is rare or obscure
RETURN IN SINGLE CODE BLOCK
IF YOU UNDERSTAND ALL ABOVE INSTRUCTIONS JUST SAY "Yes".
    )
clipwait, 2
Send, ^v 
return
