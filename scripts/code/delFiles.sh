#!/bin/bash

deleteFile() {
  for item in *; do
    if [[ "$item" = $1 ]]; then #didn't quote $1 becuase of things like *.out
      if [ "$2" = "yes" ];then
        rm "$item"
        echo "delete $(pwd)/$item"
      else
        echo "$(pwd)/$item"
      fi
    elif [ -d "$item" ]; then
      cd "$item" || exit
      deleteFile "$1" "$2"
      cd ../
    fi
  done

  for item in .*; do
    if [ "$item" = "." ] || [ "$item" = ".." ]; then
      continue
    elif [[ "$item" = $1 ]]; then #didn't quote $1 becuase of things like *.out
      if [ "$2" = "yes" ];then
        rm "$item"
        echo "delete $(pwd)/$item"
      else
        echo "$(pwd)/$item"
      fi
    elif [ -d "$item" ]; then
      cd "$item" || exit
      deleteFile "$1" "$2"
      cd ../
    fi
  done
}

printf "Enter file you would like to delete(Be careful): "
read -r fileType
deleteFile "$fileType" "no"

printf "Are you sure you would like to delete the Files above [y/n]:"
read -r ans
if [ "$ans" = "n" ] || [ "$ans" = "no" ] || [ "$ans" = "N" ] || 
  [ "$ans" = "No" ] || [  "$ans" = "NO" ];then
  echo "Nothing Deleted"
else
  deleteFile "$fileType" "yes"
fi
