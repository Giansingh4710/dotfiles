#!/bin/bash

lst=$(aerospace list-windows --all)
num=$(aerospace list-windows --all | wc -l)

text="number of windows: $num\n\n$lst"
~/dotfiles/scripts/code/notify.sh "$text" "aerospace list-windows --all"
