#!/bin/bash

filesForSymLink=( #everything that goes in ~/
	".bashrc"
	".bash_aliases"
	".vimrc"
	# ".zshrc"
	# ".tmux.conf"
	# ".vrapperrc" #eclipse vim plugin
)

foldersForSymLink=( #everything that goes in ~/.config
	"nvim"
	# "karabiner" #change keybindings like hyper on mac. No more use
	"skhd"      # keybindings for window manager etc
	"yabai"     #tiling window manager
)

# chsh -s $(which zsh) #change shell to zsh

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
		pathToItem=~/dotfiles/$item
		whereToPutItem="$folderToPutIn/$item"

		if [ -e "$whereToPutItem" ]; then
			cp -r "$whereToPutItem" ~/OLD_FILES/
      rm "$whereToPutItem"
		fi

		ln -sf "$pathToItem" "$whereToPutItem"
		if [ $? -eq 0 ]; then
			echo "symlink created for $item"
		else
			echo "Error linking $pathToItem -> $whereToPutItem "
		fi
	done
  echo Symlinks created
  echo
}

makeSymLinks ~ "${filesForSymLink[@]}"
# makeSymLinks ~/.config "${foldersForSymLink[@]}"

if [[ "$OSTYPE" == "darwin2"* ]]; then
  echo Downloading Brew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" #install brew
	# Needed for stuff to run in script folder
	brew install python3
	brew install yt-dlp
	pip3 install selenium
	pip3 install requests
	pip3 install BeautifulSoup4
	pip3 install mutagen

	# brew install koekeishiya/formulae/yabai # window tile manager
	# brew install koekeishiya/formulae/skhd # key binding for stuff like yabai and anything
	# brew services start yabai
	# brew services start skhd
	# brew install --cask rectangle
fi
