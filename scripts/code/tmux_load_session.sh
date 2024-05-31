#!/bin/bash

# download tmuxifier
# git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier

sessionName=$(ls ~/.tmuxifier/layouts/ | fzf)
sessionName=${sessionName%%.*}

tmuxifier load-session "$sessionName"
