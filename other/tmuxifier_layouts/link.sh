#!/bin/bash

function ask() {
  if [ "$ASK_ALL" = true ]; then
    return 0
  fi

  read -p "$1 (Y/n): " -r resp
  if [ -z "$resp" ]; then
    response_lc="y" # empty is Yes
  else
    response_lc=$(echo "$resp" | tr '[:upper:]' '[:lower:]') # case insensitive
  fi

  [ "$response_lc" = "y" ]
}

if ask "Download tmuxifier"; then
  git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
fi

pathToItem="$HOME/dotfiles/other/tmuxifier_layouts/layouts" # ~/dotfiles/other/tmuxifier_layouts/layouts/
whereToPutItem="$HOME/.tmuxifier/layouts" # ~/.tmuxifier/layouts/

if [ -e "$whereToPutItem" ]; then
  rmdir "$whereToPutItem"
  if [ $? -ne 0 ]; then
    ls -al "$whereToPutItem"
    if ask "Force remove $whereToPutItem"; then
      rm -rf "$whereToPutItem"
    else
      exit 1
    fi
  fi
fi

ln -s "$pathToItem" "$whereToPutItem"
if [ $? -eq 0 ]; then
  echo "symlink created for $pathToItem -> $whereToPutItem"
else
  echo "Error linking $pathToItem -> $whereToPutItem"
fi
