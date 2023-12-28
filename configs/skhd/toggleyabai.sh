#!/bin/bash

notify="$HOME/dotfiles/scripts/notify.sh"

YABAI_STATUS=$(yabai -m query --spaces --space | jq -r '.type')

if [ "$YABAI_STATUS" == "bsp" ]; then
	$notify "Stopping Yabai" "From toggleyabai.sh"
	yabai --stop-service
else
	$notify "Starting Yabai" "From toggleyabai.sh"
	yabai --start-service
fi
