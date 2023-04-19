#!/bin/bash

notify=~/dotfiles/scripts/notify.sh
if [ "$(brew services | grep 'yabai' | grep 'started' | wc -w)" -eq 0 ]; then
	$notify "Starting yabai" "From toggleyabai.sh"
	brew services start yabai
else
	$notify "Stoping yabai" "From toggleyabai.sh"
	brew services stop yabai
fi
