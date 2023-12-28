#!/bin/bash

text=$(cat <<-END
  = - equal 
  f - fullscreen 
  r - restart 
  t - toggle Yabai 
  p - Pop Window 
  g - toggle gap 
  s - toggle split type
  m - mirror y-axis 
END)

~/dotfiles/scripts/code/notify.sh "$text" "the alt/option key"
