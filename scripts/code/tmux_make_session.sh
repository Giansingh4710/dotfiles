#!/bin/bash

name="$1"
if [ -z "$name" ]; then
    nvim ~/.tmuxifier/layouts/
    exit 0
fi
tmuxifier new-session "$name"
nvim ~/.tmuxifier/layouts/"$name".session.sh
