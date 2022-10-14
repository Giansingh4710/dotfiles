#!/bin/bash
if [ "$(brew services | grep 'yabai   started' | wc -w)" -eq 0 ]; then
	brew services start yabai
	echo starting yabai
else
	brew services stop yabai
	echo stoping
fi
