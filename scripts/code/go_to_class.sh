#!/bin/bash

# base_dir="/Users/gians/Desktop/NJIT/classes"
base_dir="/Users/gians/Desktop/dev/njit_classes/"

directories=($(find "$base_dir" -maxdepth 1 -name ".*" -prune -o -print))
# echo "${directories[@]}"

echo "Enter num: "
len=${#directories[@]}
offset=0
if [[ "${directories[0]}" == "" ]]; then
	for ((i = 2; i < len + 1; i++)); do
		echo "$((i - 1)): ${directories[$i]##*/}"
	done
  offset=1
else
	for ((i = 1; i < len; i++)); do
		echo "$i: ${directories[$i]##*/}"
	done
fi

printf "Enter num: "
read -r choice
choice=$((choice + offset))
if [ -f "${directories[$choice]}" ];then
  vim "${directories[$choice]}"
else
  echo "Changed to: $(pwd)"
  cd "${directories[$choice]}" || exit
fi

