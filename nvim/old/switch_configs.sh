#!/bin/bash

#bash uses global variables by default
other_configs_dir="$HOME/dotfiles/nvim/other_configs"
options=$(ls "$other_configs_dir")
currentConfig=""

function get_current_config() {
	for conf in $options; do
		if [[ -f "$other_configs_dir/$conf/init.lua" ]]; then
			continue
		fi
		export currentConfig="$conf"
		return
	done

	echo "Error: Can't find current config"
	exit
}

function safe_mv (){ 
	if [[ -e "$1" ]]; then
		mv "$1" "$2"
	fi
}

nvim_dir="$HOME/dotfiles/nvim"
function move_nvim_conf() {
	safe_mv "$nvim_dir/init.lua" "$other_configs_dir/$1/init.lua"
	safe_mv "$nvim_dir/lua" "$other_configs_dir/$1/lua"
	safe_mv "/Users/gians/.local/share/nvim" "/Users/gians/.local/share/${1}_nvim"
	safe_mv "$nvim_dir/lazy-lock.json" "$other_configs_dir/$1/lazy-lock.json"
}

function use_nvim_conf() {
	safe_mv "$other_configs_dir/$1/init.lua" "$nvim_dir/init.lua"
	safe_mv "$other_configs_dir/$1/lua" "$nvim_dir/lua"
	safe_mv "/Users/gians/.local/share/${1}_nvim" "/Users/gians/.local/share/nvim"
	safe_mv "$other_configs_dir/$1/lazy-lock.json" "$nvim_dir/lazy-lock.json"
}

get_current_config
echo "Config being used: $currentConfig"

PS3="Enter the Config you want to use: "
select choice in $options; do
	for conf in $options; do
		if [[ $choice == "$conf" ]];then
		move_nvim_conf "$currentConfig"
		use_nvim_conf "$choice"
    fi
	done
	break
done
