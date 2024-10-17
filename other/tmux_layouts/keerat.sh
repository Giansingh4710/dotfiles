#!/bin/bash

# C-m is enter
cd "$HOME/Desktop/dev/webdev/keerat/"
SESH="keerat"
tmux has-session -t $SESH 2>/dev/null
if [ $? != 0 ]; then
  tmux new-session -d -s $SESH
  tmux send-keys -t $SESH:1  "nvm use '18.17.0'" C-m
  tmux send-keys -t $SESH:1  "sleep 2" C-m # so getshabads can take port 3000
  tmux send-keys -t $SESH:1  "npm run dev" C-m

  tmux new-window -t $SESH
  tmux send-keys -t $SESH:2  "nvim ." C-m

  tmux new-window -t $SESH
  tmux send-keys -t $SESH:3  "cd ~/Desktop/dev/webdev/keerat/app/Keertan/AkhandKeertan/scraping/dl_all_links_from_yt_link/" C-m

  tmux new-window -t $SESH
  tmux send-keys -t $SESH:4  "cd ~/Desktop/dev/webdev/getshabads/" C-m
  tmux send-keys -t $SESH:4  "npm run dev" C-m

  tmux select-window -t $SESH:2
else
  echo "$SESH session already exists"
fi

open -n -a "Brave Browser" "http://localhost:3001"
tmux attach -t $SESH
