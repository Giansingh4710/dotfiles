#!/bin/bash

base="/Users/gians/dotfiles/scripts/code"
opts=("$base"/*)             # Create an array of files in the ./code/ directory
opts=("${opts[@]#$base/}") # Remove ".../code/" prefix from each file name

DEFAULT="true"
for i in "$@"; do
  case $i in
    -sn|--show-numbers)
      DEFAULT="false"
      SHOW_NUMBERS="true"
      shift # past argument=value
      ;;
    -r=*|--run=*)
      DEFAULT="false"
      RUN_NUM="${i#*=}"
      shift # past argument=value
      ;;
    -*|--*)
      echo "Unknown option $i"
      exit 1
      ;;
    *)
      ;;
  esac
done

if [ "$DEFAULT" == "true" ]; then
  opt=$(printf "%s\n" "${opts[@]}" | fzf --height 40% --reverse --border --prompt="Select a script: ")
else
  if [ "$SHOW_NUMBERS" == "true" ]; then
    for i in "${!opts[@]}"; do
      printf "%s: %s\n" "$((i + 1))" "${opts[$i]}"
    done
  fi

  if [ -z "$RUN_NUM" ];then
    read -p "Enter the Number: " -r RUN_NUM
  fi

  index=$((RUN_NUM - 1))
  opt="${opts[$index]}"
fi

echo "Selected: $opt"
"$base/$opt"
