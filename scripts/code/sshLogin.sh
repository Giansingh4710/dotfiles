#!/bin/bash

# pbcopy ; pipe anything to this to copy it 'echo hehehh| pbcopy'

opts=(
	"Jujhar S Ji Server"
	"Aws YankPaste"
)

select opt in "${opts[@]}"; do
	if [[ $opt == "Jujhar S Ji Server" ]]; then
		echo "3?Qwk77y*YjV9Mv," | pbcopy
		ssh root@45.76.2.28
	elif [[ $opt == "Aws YankPaste" ]]; then
		ssh -i ~/Desktop/dev/stuff/yankPasteKeyPair.pem ubuntu@ec2-3-84-143-72.compute-1.amazonaws.com
	fi
	exit
done
