#!/bin/bash

function cleanup {
	print_size "$totalBytes"
	echo "Exited"
}
trap cleanup EXIT

function print_size {
	bytes=$1
	megabytes=$(echo "scale=2; $bytes / (1024 * 1024)" | bc)
	echo
	echo "${megabytes} MB"
	gigabytes=$(echo "scale=2; $bytes / (1024 * 1024 * 1024)" | bc)
	echo "${gigabytes} GB"
}

function rawurlencode() {
	echo "$1" | sed 's/ /%20/g; s/"/%22/g; s/(/%28/g; s/)/%29/g; s/{/%7B/g; s/}/%7D/g; s/,/%2C/g'
}

file_path="$1"
if [ -z "$file_path" ]; then
  echo "Enter a file path: "
  read -r file_path
fi

totalBytes=0
trackNum=0
while IFS= read -r line; do
	url=$(rawurlencode "$line")
	trackNum=$((trackNum + 1))
	curl_cmd=$(curl -Is "$url")
	if [ $? -ne 0 ]; then
		echo "Failed to fetch: $url"
		exit
	fi

	content_type=$(echo "$curl_cmd" | grep -i '^Content-Type:' | awk -F' ' '{print $2}')
	if [[ "$content_type" == *audio* ]]; then
		bytes=$(echo "$curl_cmd" | grep -i content-length | awk '{print $2}')
		len=${#bytes}
		bytes=${bytes::len-1}
		echo "$bytes, $url"
		totalBytes=$((totalBytes + bytes))
	else
		echo "Not an audio file: $url"
		exit
	fi
done <"$file_path"
print_size "$totalBytes"
