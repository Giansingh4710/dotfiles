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

nvim_dir="$HOME/dotfiles/nvim"
function move_nvim_conf() {
	mv "$nvim_dir/init.lua" "$other_configs_dir/$1/init.lua"

	if [[ -d "$nvim_dir/lua" ]]; then
		mv "$nvim_dir/lua" "$other_configs_dir/$1/lua"
	fi

	if [[ -f "$nvim_dir/lazy-lock.json" ]]; then
		mv "$nvim_dir/lazy-lock.json" "$other_configs_dir/$1/lazy-lock.json"
	fi
}

function use_nvim_conf() {
	mv "$other_configs_dir/$1/init.lua" "$nvim_dir/init.lua"
  
	if [[ -d "$other_configs_dir/$1/lua" ]]; then
		mv "$other_configs_dir/$1/lua" "$nvim_dir/lua"
	fi

	if [[ -f "$other_configs_dir/$1/lazy-lock.json" ]]; then
		mv "$other_configs_dir/$1/lazy-lock.json" "$nvim_dir/lazy-lock.json"
	fi
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
