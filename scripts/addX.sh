#!/bin/bash

addRWX(){
  for item in *
  do
    if [ -f "$item" ];then
      chmod u+x "$item"
      echo "added executabe: $item"
    elif [ -d "$item" ];then
      cd "$item"
      addRWX
      cd ../
    fi
  done
}

addRWX
