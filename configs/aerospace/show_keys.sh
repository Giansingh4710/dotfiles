#!/bin/bash

text=$(cat <<-END
  (alt = option key)

  alt-h = 'focus left'
  alt-j = 'focus down'
  alt-k = 'focus up'
  alt-l = 'focus right'
  alt-f = 'fullscreen'
  alt-shift-minus = 'resize smart -50'
  alt-shift-equal = 'resize smart +50'

  alt-1 = go to workspace 1
  alt-2 = go to workspace 2
  ... till alt-9


  alt-shift-1 = move window to workspace 1
  alt-shift-2 = move window to workspace 2
  ... till alt-shift-9


  alt-tab = 'workspace-back-and-forth'
  alt-shift-tab = 'move-workspace-to-monitor --wrap-around next'

  alt-shift-semicolon = 'mode service' #enters you into service mode
  keys available after in service mode
    / - show keys
    r - reload config
    l - list aerospace windows
    t - Toggle between floating and tiling layout
    = - reset layout

    alt-h = ['join-with left', 'mode main']
    alt-j = ['join-with down', 'mode main']
    alt-k = ['join-with up', 'mode main']
    alt-l = ['join-with right', 'mode main']

END)

~/dotfiles/scripts/code/notify.sh "$text" "the alt/option keys"
