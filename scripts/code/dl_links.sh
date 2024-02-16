#!/bin/bash

download_if_valid() {
	local url="$1"
	if [ -z "$url" ]; then
		return 1
	fi

	base=$(basename "$url")
	clean_url="${url// /%20}"
	curl -L -o "$base" "$clean_url" 
}

file_path="$1"
if [ -z "$file_path" ]; then
  echo "Enter a file path: "
  read -r file_path
fi

if [[ -f "$file_path" ]]; then
	while IFS= read -r line; do
		download_if_valid "$line"
	done <"$file_path"
else
	echo "File not found: $file_path"
fi
