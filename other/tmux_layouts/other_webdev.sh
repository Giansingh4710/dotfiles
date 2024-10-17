#!/bin/bash

webdev="$HOME/Desktop/dev/webdev/"
project=$(ls "$webdev" | fzf)
cd "$webdev$project" || exit

SESH="$project"
tmux has-session -t "$SESH" 2>/dev/null
if [ $? != 0 ]; then
  tmux new-session -d -s "$SESH"
  if [ -f "package.json" ]; then
    tmux send-keys -t "$SESH":1  "npm install" C-m
    tmux send-keys -t "$SESH":1  "npm run dev" C-m
  else
    tmux send-keys -t "$SESH":1  "live-server" C-m
  fi

  tmux new-window -t "$SESH"
  if [ -f "package.json" ]; then
    if [[ -f "src/App.ts" || -f "src/App.tsx" ]]; then
      tmux send-keys -t "$SESH":2  "nvim src/App.ts*" C-m
    elif [[ -f "src/App.js" || -f "src/App.jsx" ]]; then
      tmux send-keys -t "$SESH":2  "nvim src/App.js*" C-m
    else
      tmux send-keys -t "$SESH":2  "nvim ." C-m
    fi
  else
    tmux send-keys -t "$SESH":2  "nvim index.html" C-m
  fi

  tmux select-window -t "$SESH":2
else
  echo "$SESH session already exists"
fi

tmux attach -t "$SESH"
