#!/bin/bash

base="/Users/gians/dotfiles/scripts/code"
opts=("$base"/*)             # Create an array of files in the ./code/ directory
opts=("${opts[@]#$base/}") # Remove ".../code/" prefix from each file name

source_scripts=(
  "/Users/gians/dotfiles/scripts/code/go_to_class.sh"
  "/Users/gians/dotfiles/scripts/code/switch_nvim_configs.sh"
)

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
  for i in "${!opts[@]}"; do
    if [ "${opts[$i]}" == "$opt" ]; then
      RUN_NUM=$((i + 1))
      break
    fi
  done
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

fileToRun="$base/$opt"
"$fileToRun"
echo "Selected: $opt (-r=$RUN_NUM)"
