#!/usr/bin/env osascript

on run argv
    set noteHeading to item 1 of argv

    try
        tell application "Notes"
            set noteContent to ""
            set noteExists to false

            repeat with currentNote in every note
                if name of currentNote is equal to noteHeading then
                    set noteExists to true
                    set noteContent to body of currentNote
                    exit repeat
                end if
            end repeat

            # display dialog noteContent 
            if noteExists then
                set txtFilePath to "/Users/gians/dotfiles/scripts/AppleNotes/THE_NOTE.txt"
                set txtFile to open for access txtFilePath with write permission
                set eof txtFile to 0
                write noteContent to txtFile
                close access txtFile
                
                # Run Python script to process the file
                set txtFormat to (do shell script "python3 /Users/gians/dotfiles/scripts/AppleNotes/html_to_txt.py " & quoted form of txtFilePath)
                return txtFormat
            else
                return "Note not found"
            end if
        end tell
    on error errMsg number errNum
        return "Error: " & errMsg & " (Error number: " & errNum & ")"
    end try
end run
