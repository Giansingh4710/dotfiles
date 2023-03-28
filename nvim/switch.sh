#!/bin/bash

#bash uses global variables by default
options=$(ls ./other_configs)
currentConfig=""

function get_current_config() {
	for conf in $options; do
		if [[ -f "./other_configs/$conf/init.lua" ]]; then
			continue
		fi
		export currentConfig="$conf"
		return
	done

	echo "Error: Can't find current config"
	exit
}

function move_nvim_conf() {
	mv ./init.lua "./other_configs/$1/init.lua"

	if [[ -d ./lua ]]; then
		mv ./lua "./other_configs/$1/lua"
	fi
}

function use_nvim_conf() {
	mv "./other_configs/$1/init.lua" ./init.lua
	if [[ -d "./other_configs/$1/lua" ]]; then
		mv "./other_configs/$1/lua" ./lua
	fi
}

get_current_config
echo "Config being used: $currentConfig"

PS3="Enter the Config you want to use: "
select choice in $options; do
	if
		[[ $choice == "Kickstart" ]] ||
			[[ $choice == "AstroNvim" ]] ||
			[[ $choice == "MyConfig" ]]
	then
		move_nvim_conf "$currentConfig"
		use_nvim_conf "$choice"
	fi
	break
done
