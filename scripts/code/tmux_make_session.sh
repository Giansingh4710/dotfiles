#!/bin/bash

name="$1"
if [ -z "$name" ]; then
    nvim ~/dotfiles/other/tmux_layouts/
    exit 0
fi

nvim ~/dotfiles/other/tmux_layouts/"$name".sh
