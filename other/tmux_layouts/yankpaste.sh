#!/bin/bash

cdToMainDir="cd ~/Desktop/dev/webdev/yankPaste/"
SESH="santhiyaPothi"
tmux has-session -t $SESH 2>/dev/null
if [ $? != 0 ]; then
  tmux new-session -d -s $SESH -n "server"
  tmux send-keys -t $SESH:server  "$cdToMainDir" C-m
  tmux send-keys -t $SESH:server  "npm install" C-m
  tmux send-keys -t $SESH:server  "npm run dev" C-m

  tmux new-window -t $SESH -n "editor"
  tmux send-keys -t $SESH:editor  "$cdToMainDir" C-m
  tmux send-keys -t $SESH:editor  "nvim -p src/client/App.jsx src/server/main.js" C-m
else
  echo "$SESH session already exists"
fi

tmux attach -t $SESH
