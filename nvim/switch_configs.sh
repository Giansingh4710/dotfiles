#!/bin/bash
other_configs_dir="/Users/gians/.config/other_nvim_configs"
items=$(ls "$other_configs_dir")
options=""
for item in $items;do
  if [[ $item == *"."* ]]; then
    continue
  fi
  options="$item $options"
done

PS3="Enter the Config you want to use: "
select choice in $options; do
	for conf in $options; do
		if [[ $choice == "$conf" ]];then
    echo NVIM_APPNAME="other_nvim_configs/$choice" nvim
    NVIM_APPNAME="other_nvim_configs/$choice" nvim "$1"
    fi
	done
	break
done
