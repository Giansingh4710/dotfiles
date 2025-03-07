#!/bin/bash

# base_dir="/Users/gians/Desktop/NJIT/classes"
base_dir="/Users/gians/Desktop/NJIT/njit_classes"
items=($(find "$base_dir" -maxdepth 1 -name '.*' -prune -o -print))

items_len=${#items[@]}
if [[ "$items_len" -eq 0 ]]; then
  echo "No items found!!!"
else
  choice=$(printf '%s\n' "${items[@]##*/}" | fzf)
  absPath="$base_dir/$choice"
  if [[ -f "$absPath" ]]; then
    nvim "$absPath"
  elif [[ -d "$absPath" ]]; then
    cd "$absPath" || exit
  else
    # echo "NOT a FILE or DIR. Not sure what to do!!!"
    cd "$base_dir" || exit
  fi
fi
