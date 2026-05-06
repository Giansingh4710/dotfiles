#!/bin/bash

echo "Running: $0"

echo "Enter a link for youtube-dl: "
read -r link

echo "yt-dlp -F '$link'"

yt-dlp --cookies-from-browser chrome -F "$link"
if [ $? -ne 0 ]; then
  echo "yt-dlp failed"
  exit 1
fi

read -r -p "Enter the number: " num
yt-dlp --cookies-from-browser chrome -f "$num" "$link"

# yt-dlp --dump-json
