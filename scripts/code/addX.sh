#!/bin/bash

addRWX(){
	allDirs=$(ls -a)
	for item in $allDirs; do
		if [ "$item" = "." ] || [ "$item" = ".." ]; then
			continue
    elif [ -f "$item" ];then
      chmod u+rwx "$item"
      echo "added executabe: $item"
    elif [ -d "$item" ];then
      cd "$item"
      addRWX
      cd ../
    fi
  done
}

echo "Are you sure you want to add read, write, and execute permissions to all files and directories in the current directory? (y/n)"
read -r response
if [ "$response" = "y" ]; then
  addRWX
else
  echo "No changes made."
fi
