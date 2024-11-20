#!/bin/bash

BROWSER="Safari" # default is Safari if nothing is open.
all_processes=$(osascript -e 'tell application "System Events" to get the name of every process whose background only is false')
echo "$all_processes" | grep -q "Brave Browser" # Return Codes: 0: The pattern was found in the input. 1: The pattern was not found. 2: An error occurred (e.g., if the input was invalid).
if [ $? == 0 ]; then
  BROWSER="Brave Browser" # is brave is open, use brave
fi

webdev="$HOME/Desktop/dev/webdev/"
project=$(ls "$webdev" | fzf)
cd "$webdev$project" || exit

SESH="$project"
tmux has-session -t "$SESH" 2>/dev/null
if [ $? != 0 ]; then
  tmux new-session -d -s "$SESH"
  if [ -f "package.json" ]; then
    tmux send-keys -t "$SESH":1  "npm install" C-m
    tmux send-keys -t "$SESH":1  "npm run dev --browser='$BROWSER'" C-m
  else
    tmux send-keys -t "$SESH":1  "live-server --browser='$BROWSER'" C-m
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
