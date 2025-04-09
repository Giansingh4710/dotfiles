#!/bin/bash

show_n_run_cmd() {
  the_command=$1
  printf "\nExecuting:\n"
  echo "    ${the_command[*]}"
  echo
  "${the_command[@]}"
}


path=$(pwd)
printf "\nThe Directory: %s\n\n" "$path"

base="/Users/gians/dotfiles/scripts/python_scripts/py_code"
opts=("$base"/*.py)
opts=("${opts[@]#$base/}") # Remove ".../code/" prefix from each file name

DEFAULT="true"
for i in "$@"; do
  case $i in
    -sn|--show-numbers|-help)
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

the_command=(python3 "$base/$opt" "$path")
show_n_run_cmd "${the_command[@]}"
echo "Selected: $opt -r=$RUN_NUM"
