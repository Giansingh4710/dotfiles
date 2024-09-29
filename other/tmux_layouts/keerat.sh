#!/bin/bash

# C-m is enter
cdToMainDir="cd ~/Desktop/dev/webdev/keerat/"
SESH="keerat"
tmux has-session -t $SESH 2>/dev/null
if [ $? != 0 ]; then
  tmux new-session -d -s $SESH -n "server"
  tmux send-keys -t $SESH:server  "$cdToMainDir" C-m
  tmux send-keys -t $SESH:server  "nvm use '18.17.0'" C-m
  tmux send-keys -t $SESH:server  "sleep 2" C-m # so getshabads can take port 3000
  tmux send-keys -t $SESH:server  "npm run dev" C-m

  tmux new-window -t $SESH -n "editor"
  tmux send-keys -t $SESH:editor  "$cdToMainDir" C-m
  tmux send-keys -t $SESH:editor  "nvim ." C-m

  tmux new-window -t $SESH -n "yt_dl"
  tmux send-keys -t $SESH:yt_dl  "cd ~/Desktop/dev/webdev/keerat/app/Keertan/AkhandKeertan/scraping/dl_all_links_from_yt_link/" C-m

  tmux new-window -t $SESH -n "getshabads"
  tmux send-keys -t $SESH:getshabads  "cd ~/Desktop/dev/webdev/getshabads/" C-m
  tmux send-keys -t $SESH:getshabads  "npm run dev" C-m

  tmux select-window -t $SESH:editor
else
  echo "$SESH session already exists"
fi

open -n -a "Brave Browser" "http://localhost:3001"
tmux attach -t $SESH
