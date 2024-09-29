#!/bin/bash

# C-m is enter
cdToMainDir="cd ~/Desktop/dev/mobile/interview/binfin/"

SESH="santhiyaPothi"
tmux has-session -t $SESH 2>/dev/null
if [ $? != 0 ]; then
  tmux new-session -d -s $SESH -n "server"
  tmux send-keys -t $SESH:server  "$cdToMainDir" C-m
  tmux send-keys -t $SESH:server  "open -a Simulator.app" C-m
  tmux send-keys -t $SESH:server  "sleep 5" C-m
  tmux send-keys -t $SESH:server  "flutter run" C-m

  tmux new-window -t $SESH -n "editor"
  tmux send-keys -t $SESH:editor  "$cdToMainDir" C-m
  tmux send-keys -t $SESH:editor  "nvim lib/main.dart" C-m
else
  echo "$SESH session already exists"
fi

tmux attach -t $SESH
