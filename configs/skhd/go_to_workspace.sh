#!/bin/bash

index=$1

# focus space 3
# index=3
# eval "$(yabai -m query --spaces | jq --argjson index "${index}" -r '(.[] | select(.index == $index).windows[0]) as $wid | if $wid then "yabai -m window --focus \"" + ($wid | tostring) + "\"" else "skhd --key \"ctrl - " + (map(select(."native-fullscreen" == 0)) | index(map(select(.index == $index))) + 1 % 10 | tostring) + "\"" end')"


# yabai -m query --spaces | jq --argjson index "${index}" -r '(.[] | select(.index == $index).windows[0]) as $wid | if $wid then "yabai -m window --focus \"" + ($wid | tostring) + "\"" else "skhd --key \"ctrl - " + (map(select(."native-fullscreen" == 0)) | index(map(select(.index == $index))) + 1 % 10 | tostring) + "\"" end'

notify="$HOME/dotfiles/scripts/code/notify.sh"

# Get the window ID for the specified space index
window_id=$(yabai -m query --spaces | jq --argjson index "${index}" -r '(.[] | select(.index == $index).windows[0]) as $wid | if $wid then $wid else null end')
# $notify "Window ID: $window_id"


if [ -z "$num" ] || [ "$num" = "null" ]; then
    # If window ID is not available, use skhd to focus on the next window
    $notify "No window found for space $index"
else
    yabai -m window --focus "$window_id"
fi
