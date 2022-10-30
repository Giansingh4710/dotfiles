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

addRWX
