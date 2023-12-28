#!/bin/bash

filesForSymLink=( #everything that goes in ~/
	"./configs/.bashrc"
	"./configs/.bash_aliases"
	"./configs/.vimrc"
	"./configs/.zshrc"
	"./configs/.tmux.conf"
	"./configs/.vrapperrc" # eclipse(java) vim plugin
)

foldersForSymLink=( #everything that goes in ~/.config
	"./configs/nvim"
	"./configs/yabai"     # tiling window manager
	"./configs/skhd"      # keybindings for window manager etc
	"./configs/alacritty" # terminal
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
		base_name=${item#./configs/}
		pathToItem=~/dotfiles/configs/$base_name
		whereToPutItem="$folderToPutIn/$base_name"

		if [ -e "$whereToPutItem" ]; then
			cp -r "$whereToPutItem" ~/OLD_FILES/
			if [ -L "$whereToPutItem" ]; then
				unlink "$whereToPutItem"
			else
				rm -r "$whereToPutItem"
			fi
		fi

		ln -sf "$pathToItem" "$whereToPutItem"
		if [ $? -eq 0 ]; then
			echo "symlink created for $item"
		else
			echo "Error linking $pathToItem -> $whereToPutItem "
		fi
	done
}

makeSymLinks ~ "${filesForSymLink[@]}"
makeSymLinks ~/.config "${foldersForSymLink[@]}"

exit

if [[ "$OSTYPE" == "darwin2"* ]]; then
	echo Downloading Brew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" #install brew

	# Needed for stuff to run in ./scripts folder
	brew install python3
	brew install yt-dlp
	pip3 install selenium
	pip3 install requests
	pip3 install BeautifulSoup4
	pip3 install mutagen

	# brew install --cask warp
	# brew install --cask alacritty
	# brew install koekeishiya/formulae/yabai # window tile manager
	# brew install koekeishiya/formulae/skhd # key binding for stuff like yabai and anything
	# brew install --cask rectangle

fi
