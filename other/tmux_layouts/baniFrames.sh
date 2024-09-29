#!/bin/bash

cdToMainDir="cd ~/Desktop/dev/webdev/BaniFrames/"
SESH="baniFrames"
tmux has-session -t $SESH 2>/dev/null
if [ $? != 0 ]; then
  tmux new-session -d -s $SESH -n "server"
  tmux send-keys -t $SESH:server  "$cdToMainDir" C-m
  tmux send-keys -t $SESH:server  "npm install" C-m
  tmux send-keys -t $SESH:server  "npm run dev" C-m

  tmux new-window -t $SESH -n "editor"
  tmux send-keys -t $SESH:editor  "$cdToMainDir" C-m
  tmux send-keys -t $SESH:editor  "nvim ." C-m

  tmux new-window -t $SESH -n "py_code"
  tmux send-keys -t $SESH:py_code  "cd /Users/gians/Desktop/dev/rand/sikhStuff/Gurbani/GetBanis" C-m
  tmux send-keys -t $SESH:py_code  "nvim ." C-m

  tmux select-window -t $SESH:editor
else
  echo "$SESH session already exists"
fi

tmux attach -t $SESH
