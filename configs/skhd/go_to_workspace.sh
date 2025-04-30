#!/bin/bash

index=$1
notify="$HOME/dotfiles/scripts/code/notify.sh"
window_id=$(yabai -m query --windows | jq --argjson index "$index" -r '[.[] | select(.space == $index)][0].id')
# $notify "Index: $index Window ID: $window_id"

if [ -z "$window_id" ] || [ "$window_id" = "null" ]; then
    # If window ID is not available, use skhd to focus on the next window
    $notify "No window found for space $index"
else
    yabai -m window --focus "$window_id"
fi
