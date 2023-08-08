#!/usr/bin/env osascript

on run argv
  set filePath to item 1 of argv
  -- set filePath to "/Users/gians/Desktop/dev/rand/NJIT/SSA/text_to_html.py"
  -- set noteContent to (do shell script "cat " & quoted form of POSIX path of filePath)
  set noteContent to (do shell script "python3 /Users/gians/dotfiles/scripts/AppleNotes/txt_to_html.py " & quoted form of POSIX path of filePath)
  set noteHeading to (do shell script "head -1 " & quoted form of POSIX path of filePath)

  # display dialog noteContent
  tell application "Notes"
    set noteExists to false
    repeat with currentNote in every note
        if name of currentNote is equal to noteHeading then
            set noteExists to true
            exit repeat
        end if
    end repeat

    # display dialog noteExists

    if noteExists then
        set body of note noteHeading to noteContent
    else
        make new note with properties {body:noteContent}
    end if
  end tell
end run
