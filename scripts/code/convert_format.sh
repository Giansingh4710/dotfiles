#!/bin/bash

# Prompt if args not given
if [ "$#" -lt 2 ]; then
  read -rp "Enter the directory to search in: " TARGET_DIR
  read -rp "Enter the output file extension (e.g. mp4, mp3): " OUT_EXT
else
  TARGET_DIR="$1"
  OUT_EXT="$2"
fi

echo "🔍 Searching in: $TARGET_DIR"
echo "🎯 Converting to: .$OUT_EXT"

# Find files safely
find "$TARGET_DIR" -type f ! -name "*.${OUT_EXT}" -print0 |
while IFS= read -r -d '' input_file; do
  [ -z "$input_file" ] && continue

  input_ext="${input_file##*.}"
  base="${input_file%.*}"
  output_file="${base}.${OUT_EXT}"

  echo "🔄 Converting: \"$input_file\" → \"$output_file\""

  # Skip if output already exists
  if [ -f "$output_file" ]; then
    echo "⚠️  Skipping: $output_file already exists"
    continue
  fi

  # Convert
  if [[ "$input_ext" == "mkv" && "$OUT_EXT" == "mp4" ]]; then
    ffmpeg -y -i "$input_file" -map 0 -map -0:s -c copy "$output_file"
  else
    ffmpeg -y -i "$input_file" "$output_file"
  fi

  if [ $? -eq 0 ]; then
    echo "✅ Success: $output_file"
    # Optional: rm "$input_file"
  else
    echo "❌ Failed: \"$input_file\""
  fi

done
