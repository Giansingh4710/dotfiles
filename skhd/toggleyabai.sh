#!/bin/bash
if [ "$(brew services | grep none | wc -w)" -eq 0 ]; then brew services stop yabai; echo stoping ; else brew services start yabai; echo starting yabai; fi

