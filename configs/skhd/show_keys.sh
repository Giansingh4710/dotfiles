#!/bin/bash

text=$(cat <<-END
  (+shift will swap instead of focus)
  h - focus left
  j - focus down
  k - focus up
  l - focus right

  = - equal 
  f - fullscreen 
  p - Pop Window 
  g - toggle gap 
  s - toggle split type
  m - mirror y-axis 

  r - restart 
  t - toggle Yabai on/off
END)

~/dotfiles/scripts/code/notify.sh "$text" "the alt/option keys"
