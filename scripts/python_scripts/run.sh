#!/bin/bash

show_n_run_cmd() {
	the_command=$1
	printf "\nExecuting:\n"
	echo "    ${the_command[*]}"
	echo
	"${the_command[@]}"
}

run_cmd() {
	the_command=$1
	echo "Executing: ${the_command[*]}"
	"${the_command[@]}"
}

path=$(pwd)
printf "\nThe Directory: %s\n\n" "$path"

base="/Users/gians/dotfiles/scripts/python_scripts/py_code"
opts=("$base"/*.py)
opts=("${opts[@]#$base/}") # Remove ".../code/" prefix from each file name

chosen=$1
if [[ $chosen =~ ^[0-9]+$ ]]; then
	index=$((chosen - 1))
	opt="${opts[$index]}"
	echo "Selected: $opt"
	the_command=(python3 "$base/$opt" "$path")
	show_n_run_cmd "${the_command[@]}"
	exit
fi

PS3="Enter the Number: " # Set the prompt for the select loop
select opt in "${opts[@]}"; do
	if [[ $opt ]]; then
		echo "Selected: $opt"
		the_command=(python3 "$base/$opt" "$path")
		show_n_run_cmd "${the_command[@]}"
		exit
	else
		echo "Invalid option. Please try again."
	fi
done
