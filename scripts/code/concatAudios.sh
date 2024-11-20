#!/bin/bash

# Create a temporary file to store the list of files
echo "# This is a comment" > concat_list.txt

# Find all common audio files, sort them numerically
find . -maxdepth 1 \( -name "*.mp3" -o -name "*.m4a" -o -name "*.wav" -o -name "*.aac" -o -name "*.ogg" -o -name "*.flac" -o -name "*.wma" \) | sort -V | while read -r file; do
  file="${file#./}" # Remove the ./ prefix from the filename
  echo "file '$file'" >> concat_list.txt
done

if [ ! -s concat_list.txt ]; then
  echo "No audio files found in the current directory!"
  rm concat_list.txt
  exit 1
fi

# Get the extension of the first file to determine output format
first_file=$(head -n 2 concat_list.txt | tail -n 1 | cut -d "'" -f 2)
extension="${first_file##*.}"

# Create output filename
output_file="combined_output.$extension"

# Use ffmpeg to concatenate all files
ffmpeg -f concat -safe 0 -i concat_list.txt -c copy "$output_file"

# Check if ffmpeg was successful
if [ $? -eq 0 ]; then
  echo "Successfully concatenated all audio files into $output_file"
  echo "Total files concatenated: $(grep -c "^file" concat_list.txt)"
else
  echo "Error occurred during concatenation!"
  echo "Note: Some formats may not support direct stream copy."
  echo "Try using the -transcode option to force transcoding."
fi

# Clean up the temporary file
rm concat_list.txt

# Function to convert to MP3 if needed
transcode_to_mp3() {
  local input="$1"
  ffmpeg -i "$input" -codec:a libmp3lame -q:a 0 "combined_output.mp3"
  if [ $? -eq 0 ]; then
    rm "$input"
    echo "Successfully transcoded to combined_output.mp3"
  else
    echo "Error during transcoding!"
  fi
}

# Add help message if script is called with -h or --help
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  echo "Usage: $0 [OPTIONS]"
  echo "Concatenates all audio files in the current directory."
  echo ""
  echo "Options:"
  echo "  -h, --help      Show this help message"
  echo "  -transcode      Force transcoding to MP3 instead of stream copy"
  exit 0
fi

# If -transcode option is used, convert to MP3
if [ "$1" == "-transcode" ]; then
  transcode_to_mp3 "$output_file"
fi
