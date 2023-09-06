#!/bin/bash

base_dir="/Users/gians/Desktop/NJIT/classes/"
cd "$base_dir" || exit

directories=($(find . -maxdepth 1 -type d))
# echo "${directories[@]}"

echo "Enter num: "
len=${#directories[@]}
offset=0
if [[ "${directories[0]}" == "" ]]; then
	for ((i = 2; i < len + 1; i++)); do
		echo "$((i - 1)): ${directories[$i]//\.\//}"
	done
  offset=1
else
	for ((i = 1; i < len; i++)); do
		echo "$i: ${directories[$i]//\.\//}"
	done
fi

printf "Enter num: "
read -r choice
choice=$((choice + offset))
cd "${directories[$choice]}" || exit

echo "Changed to: $(pwd)"
