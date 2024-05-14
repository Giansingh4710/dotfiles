#!/bin/bash


from="$1"
to="$2"
if [ "$#" -ne 2 ]; then
  read -p "From: " -r from
  read -p "To: " -r to
fi

tmux swap-window -s :"$from" -t :"$to"

# for ((i=$1; i<$2; i++))
# do
#   tmux swap-window -s :$i -t :$((i+1))
# done
