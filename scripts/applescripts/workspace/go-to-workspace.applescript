#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Go To Workspace
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Placeholder" }

# Documentation:
# @raycast.description Goes to workspace number
# @raycast.author gian_singh
# @raycast.authorURL https://raycast.com/gian_singh

# How it works:
#   argv is the list of arguments passed when running the script.
#   key code 18 corresponds to the 1 key, 19 = 2, etc.
#   Holding control down with these simulates Control + number.

on run argv
    if (count of argv) < 1 then
        display dialog "Please provide a workspace number." buttons {"OK"}
        return
    end if

    set wsNum to item 1 of argv
    set wsNum to wsNum as integer

    delay 0.3 -- tiny pause so the keystroke is not dropped
    # display dialog "Testing " & wsNum  buttons {"OK"}

    tell application "System Events"
        key code (18 + (wsNum - 1)) using control down
        -- key code 18 = "1", 19 = "2", 20 = "3", etc.
    end tell
end run
