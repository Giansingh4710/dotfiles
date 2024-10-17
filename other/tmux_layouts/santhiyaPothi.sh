#!/bin/bash

# C-m is enter
cd "$HOME/Desktop/dev/mobile/SanthiyaPothi/"
SESH="santhiyaPothi"
tmux has-session -t $SESH 2>/dev/null
if [ $? != 0 ]; then
  tmux new-session -d -s $SESH
  tmux send-keys -t $SESH:1  "yarn start" C-m

  tmux new-window -t $SESH
  tmux send-keys -t $SESH:2  'yarn ios --simulator="iPhone 14"' C-m
  tmux send-keys -t $SESH:2  "nvim ." C-m
else
  echo "$SESH session already exists"
fi

tmux attach -t $SESH
