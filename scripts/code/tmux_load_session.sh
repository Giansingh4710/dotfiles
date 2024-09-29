#!/bin/bash

sessionName=$(ls ~/dotfiles/other/tmux_layouts/ | fzf)
. "$HOME/dotfiles/other/tmux_layouts/$sessionName"
echo "Done with $sessionName"
