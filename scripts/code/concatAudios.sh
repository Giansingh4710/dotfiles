#!/bin/bash

function ask() {
	read -p "$1 (Y/n): " resp
	if [ -z "$resp" ]; then
		response_lc="y" # empty is Yes
	else
		response_lc=$(echo "$resp" | tr '[:upper:]' '[:lower:]') # case insensitive
	fi

	[ "$response_lc" = "y" ]
}

function copy_file_types_and_make_mp3() {
	file_ext="$1"
	if [ "$file_ext" == "mp3" ]; then
		for file in "$input_folder"/*.mp3; do
			cp "$file" "$temp_dir/"
		done
		return
	fi

	for file in "$input_folder"/*."$file_ext"; do
		if [ ! -f "$file" ]; then
			# echo "file: $file"
			continue
		fi
		ffmpeg -i "$file" "$temp_dir/$(basename "${file%.*}").mp3"
	done
}

input_folder="$1"
if [ -z "$input_folder" ]; then
	echo "Enter a folder path: "
	read -r input_folder
fi

output_file="$2"
if [ -z "$output_file" ]; then
	echo "Enter a file path: "
	read -r output_file
fi

# everything in the temp directory should be mp3 files
# temp_dir=$(mktemp -d) # Create a temporary directory for converted files
temp_dir="TEMP"
mkdir "$temp_dir"

if ask "2x audio speed?"; then
	DOUBLE_SPEED=true
fi

copy_file_types_and_make_mp3 "mp3"
copy_file_types_and_make_mp3 "m4a"
copy_file_types_and_make_mp3 "wav"

if [ "$DOUBLE_SPEED" = true ]; then
	for file in "$temp_dir"/*.mp3; do
		temp_file=the_temp_2x.mp3
		ffmpeg -i "$file" -filter:a "atempo=2.0" -vn "$temp_file"
		mv "$temp_file" "$file"
		sleep 1
	done
fi

echo "Conversion complete. Now concatenating files..."
sleep 2

# ffmpeg -i "concat:lav1.mp3|lav2.mp3|lav3.mp3|lav4.mp3" -c copy fullLav.mp3
inside_concat="concat:"
for file in "$temp_dir"/*; do
	echo "file: $file"
	inside_concat+="$file|"
done
inside_concat=${inside_concat%?} # remove the last character
ffmpeg -i "$inside_concat" -c copy "$output_file"

# process_batch() {
# 	local concat_batch=""
# 	for file in "$@"; do
# 		concat_batch+="$file|"
# 	done
# 	concat_batch=${concat_batch%?} # Remove the last character
# 	ffmpeg -i "concat:$concat_batch" -c copy -bsf:a aac_adtstoasc "$output_file" || exit 1
# }
#
# batch_size=5 # Adjust this value as needed
# file_batch=()
# count=0
# for file in "$temp_dir"/*; do
# 	file_batch+=("$file")
# 	((count++))
# 	if [ $count -eq $batch_size ]; then
# 		process_batch "${file_batch[@]}"
# 		file_batch=()
# 		count=0
# 	fi
# done
#
# # Process the remaining files (if any)
# if [ ${#file_batch[@]} -gt 0 ]; then
# 	process_batch "${file_batch[@]}"
# fi

rm -rf "$temp_dir"
echo "Concatenation complete. Output file: $output_file"
