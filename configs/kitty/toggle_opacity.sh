#!/bin/bash

# ~/dotfiles/scripts/code/notify.sh "Toggle opacity and blur"

file=~/dotfiles/configs/kitty/blur_on

if [ -e $file ]; then
  kitty @ set-background-opacity 0.4
  rm $file
else
  kitty @ set-background-opacity 0.9
  touch $file
fi
