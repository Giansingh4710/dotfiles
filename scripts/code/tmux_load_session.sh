#!/bin/bash


sessionName=$(ls ~/.tmuxifier/layouts/ | fzf)
sessionName=${sessionName%%.*}

tmuxifier load-session $sessionName
