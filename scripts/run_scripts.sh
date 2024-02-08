#!/bin/bash

base="/Users/gians/dotfiles/scripts/code"
opts=("$base"/*)             # Create an array of files in the ./code/ directory
opts=("${opts[@]#$base/}") # Remove ".../code/" prefix from each file name

chosen=$1
if [[ $chosen =~ ^[0-9]+$ ]]; then
	index=$((chosen - 1))
	opt="${opts[$index]}"
	echo "Selected: $opt"
  "$base/$opt"
	exit
fi

PS3="Enter the Number: " # Set the prompt for the select loop
select opt in "${opts[@]}"; do
	if [[ $opt ]]; then
		echo "Selected: $opt"
		"$base/$opt" "$@" # Execute the selected file
		exit
	else
		echo "Invalid option. Please try again."
	fi
done
