#!/bin/bash

if ! command -v ffmpeg &>/dev/null; then
	echo "ffmpeg is not installed. Please install ffmpeg and try again."
	exit 1
fi

if [ -z "$1" ]; then
	echo "Usage: $0 <input_video_file>"
	exit 1
fi

function convert_to_gif() {
  # Control looping with -loop output option but the values are confusing. A value of 0 is infinite looping, -1 is no looping, and 1 will loop once meaning it will play twice. So a value of 10 will cause the GIF to play 11 times.
  in_file="$1"
  out_file="$2"
  ffmpeg -i "$in_file" -vf "fps=10,scale=640:-1:flags=lanczos,split[s0][s1];[s0]palettegen=stats_mode=diff:max_colors=256:reserve_transparent=off[p];[s1][p]paletteuse=dither=floyd_steinberg:diff_mode=rectangle" -loop -1 "$out_file"
}

input_file="$1"
if [ "${input_file##*.}" = "gif" ];
then
  convert_to_gif "$input_file" "gif_$input_file" 
  exit 0
fi


if [ "${input_file##*.}" != "mp4" ] && ! [ -f "$output_mp4" ]; then
  echo "Converting to MP4. $output_mp4"
	made_mp4=true
	output_mp4="${input_file%.*}.mp4"
	ffmpeg -i "$input_file" -c:v libx264 -preset medium -crf 23 -c:a aac -b:a 128k "$output_mp4"
	if [ $? -ne 0 ]; then
		echo "Failed to convert $input_file to MP4"
		exit 1
	fi
fi


# Convert MP4 to GIF
convert_to_gif "$input_file" "${input_file%.*}.gif"
if [ $? -ne 0 ]; then
	echo "Failed to convert $output_mp4 to GIF"
	exit 1
fi

if [ -n "$made_mp4" ]; then
  rm "$output_mp4"
fi
echo "GIF created: $output_gif"
