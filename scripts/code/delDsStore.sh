#!/bin/bash

delDsStore() {
	# allDirs=$(ls -a)
	for item in *; do
		if [ -d "$item" ]; then
			cd "$item" || exit
			delDsStore
			cd ../
		fi
	done

	for item in .*; do
		if [ "$item" = "." ] || [ "$item" = ".." ]; then
			continue
		elif [ "$item" = ".DS_Store" ]; then
			rm .DS_Store
      echo "deleted $(pwd)/$item "
		elif [ -d "$item" ]; then
			cd "$item" || exit
			delDsStore
			cd ../
		fi
	done
}

echo "Removing .DS_Store from: $(pwd)"
delDsStore
