#!/bin/bash

# C-m is enter
cdToMainDir="cd ~/Desktop/dev/mobile/SanthiyaPothi/"

SESH="santhiyaPothi"
tmux has-session -t $SESH 2>/dev/null
if [ $? != 0 ]; then
  tmux new-session -d -s $SESH -n "server"
  tmux send-keys -t $SESH:server  "$cdToMainDir" C-m
  tmux send-keys -t $SESH:server  "yarn start" C-m

  tmux new-window -t $SESH -n "editor"
  tmux send-keys -t $SESH:editor  "$cdToMainDir" C-m
  tmux send-keys -t $SESH:editor  'yarn ios --simulator="iPhone 14"' C-m
  tmux send-keys -t $SESH:editor  "nvim ." C-m
else
  echo "$SESH session already exists"
fi

tmux attach -t $SESH
