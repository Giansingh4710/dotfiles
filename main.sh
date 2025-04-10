#!/bin/bash

filesForSymLink=( #everything that goes in ~/
  "./configs/.bashrc"
  "./configs/.zshrc"
  "./configs/.vimrc"
  "./configs/.tmux.conf"
  # "./configs/.vrapperrc" # eclipse(java) vim plugin
)

foldersForSymLink=( #everything that goes in ~/.config
  "./configs/nvim"
  "./configs/kitty"     # terminal
  "./configs/aerospace" # tiling window manager
  "./configs/borders"   # border around windows
  # "./configs/yabai"     # tiling window manager
  # "./configs/skhd"      # keybindings for window manager etc

  # "./configs/ghostty"     # terminal
  # "./configs/alacritty" # terminal
  # "./configs/wezterm"     # terminal
)

function ask() {
  if [ "$ASK_ALL" = true ]; then
    return 0
  fi

  read -p "$1 (Y/n): " resp
  if [ -z "$resp" ]; then
    response_lc="y" # empty is Yes
  else
    response_lc=$(echo "$resp" | tr '[:upper:]' '[:lower:]') # case insensitive
  fi

  [ "$response_lc" = "y" ]
}

if [ ! -d ~/.config/ ]; then
  mkdir ~/.config
  echo Made .config dir
fi

if [ ! -d ~/OLD_FILES ]; then
  mkdir ~/OLD_FILES
  echo Made OLD_FILES dir
fi

function makeSymLinks() {
  local folderToPutIn="$1" # Save first argument in a variable
  shift                    # Shift all arguments to the left (original $1 gets lost)
  local items=("$@")       # Rebuild the array with rest of arguments

  for item in "${items[@]}"; do
    base_name=${item#./configs/}
    pathToItem=~/dotfiles/configs/$base_name
    whereToPutItem="$folderToPutIn/$base_name"

    if ask "Link $base_name"; then
      : # do nothing
    else
      continue
    fi

    if [ -e "$whereToPutItem" ]; then
      cp -r "$whereToPutItem" ~/OLD_FILES/
      if [ -L "$whereToPutItem" ]; then
        unlink "$whereToPutItem"
      else
        rm -r "$whereToPutItem"
      fi
    fi

    ln -s "$pathToItem" "$whereToPutItem"
    if [ $? -eq 0 ]; then
      echo "symlink created for $item"
    else
      echo "Error linking $pathToItem -> $whereToPutItem "
    fi
  done
  echo
}

if [ "$1" = "-y" ]; then
  ASK_ALL=true
fi

makeSymLinks ~ "${filesForSymLink[@]}"
# chsh -s $(which zsh) #change shell to zsh

if ask "Download Vim Plug for ~/.vimrc"; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [[ "$OSTYPE" == "darwin2"* ]]; then
  makeSymLinks ~/.config "${foldersForSymLink[@]}"
  if ask "Download Brew"; then
    echo Downloading Brew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" #install brew
  fi

  if ask "Install Brew and Pip Packages"; then # Needed for stuff to run in ./scripts folder
    xargs brew install <./brewlist.txt

    pip3 install selenium
    pip3 install requests
    pip3 install BeautifulSoup4
    pip3 install mutagen
  fi
fi
