#!/bin/bash

other_configs_dir="/Users/gians/.config/other_nvim_configs"
items=($(find "$other_configs_dir" -type d ! -name "*.*" -maxdepth 1 -mindepth 1))
default_config="regular"
items+=("$default_config")

dir=$(basename "$other_configs_dir")

items_len=${#items[@]}
if [[ "$items_len" -eq 0 ]]; then
  echo "No items found!!!"
else
  choice=$(printf '%s\n' "${items[@]##*/}" | fzf)
  if [[ "$choice" == "$default_config" ]]; then
    choice=""
    NVIM_APPNAME=""
    # echo "Default Neovim Config Selected"
  else
    abs_path="${dir}/${choice}"
    NVIM_APPNAME="$abs_path"
    # echo "Neovim Config Selected: $choice"
  fi
  export NVIM_APPNAME
  echo "NVIM_APPNAME=$NVIM_APPNAME"
fi
