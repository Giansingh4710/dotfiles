#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Yabai Run Once
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Resizes windows so everything is formated
# @raycast.author gian_singh
# @raycast.authorURL https://raycast.com/gian_singh

yabai &
YABAI_PID=$!
sleep 10
kill $YABAI_PID
# echo "yabai PID: $YABAI_PID"
echo "Done with yabai!"
