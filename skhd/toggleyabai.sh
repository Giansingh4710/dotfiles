#!/bin/bash

notify=~/dotfiles/scripts/notify.sh
if [ "$(brew services | grep 'yabai   started' | wc -w)" -eq 0 ]; then
	brew services start yabai
	$notify "Starting yabai" "From toggleyabai.sh"
else
	brew services stop yabai
	$notify "Stoping yabai" "From toggleyabai.sh"
fi
