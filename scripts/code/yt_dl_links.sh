#!/bin/bash

download_if_valid() {
  local url="$1"
  if [ -z "$url" ]; then
    return 1
  fi
  yt-dlp -x --audio-format mp3 --audio-quality 3 --embed-thumbnail --add-metadata "$url"
}

file_path="$1"
if [ -z "$file_path" ]; then
  echo "Enter a file path: "
  read -r file_path
fi

if [[ -f "$file_path" ]]; then
  while IFS= read -r line; do
    echo "$line"
    download_if_valid "$line"
  done <"$file_path"
else
  echo "File not found: $file_path"
fi
