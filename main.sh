#!/bin/bash

filesForSymLink[0]=".bashrc"
filesForSymLink[1]=".tmux.conf"
filesForSymLink[2]=".bash_aliases"
filesForSymLink[3]=".zshrc"
filesForSymLink[4]=".vimrc"
filesForSymLink[5]="nvim"
filesForSymLink[6]="karabiner" #change keybindings like hyper on mac
filesForSymLink[7]="skhd"      # keybindings for window manager etc
filesForSymLink[8]="yabai"     #tiling window manager

pathToSymLink[0]=~/.bashrc
pathToSymLink[1]=~/.tmux.conf
pathToSymLink[2]=~/.bash_aliases
pathToSymLink[3]=~/.zshrc
pathToSymLink[4]=~/.vimrc
pathToSymLink[5]=~/.config/nvim
pathToSymLink[6]=~/.config/karabiner
pathToSymLink[7]=~/.config/skhd
pathToSymLink[8]=~/.config/yabai

for i in "${!filesForSymLink[@]}"; do
	theItem=${filesForSymLink[$i]}
	pathToItem=~/dotfiles/$theItem
	whereToPutItem=${pathToSymLink[$i]}
	if [[ "$OSTYPE" != "darwin21"* ]]; then # if mac
		if {
			  [ "$theItem" == "karabiner" ] ||
				[ "$theItem" == "skhd" ] ||
				[ "$theItem" == "yabai" ]
		}; then
			echo "No symlink created because '$theItem' is for MAC ONLY"
			continue
		fi
	fi
	rm -r "$whereToPutItem"
	ln -sf "$pathToItem" "$whereToPutItem"
	if [ $? -eq 0 ]; then
		echo "symlink created for ${filesForSymLink[$i]}"
	else
		echo "Error linking $pathToItem -> $whereToPutItem "
	fi
done


if [[ "$OSTYPE" == "darwin21"* ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" #install brew

  brew install karabiner-elements #change functions of keys on keyboard
  brew install yabai #window tile manager
  brew install skhd #key binding for stuff like yabai and anything
  #brew services start/stop (name of service)
  #brew services restart --all ; brew service list

  brew install neovim
  brew install node #for lsp and other stuff. Node is node lol
  brew install shellcheck #lsp for bash (neovim)
  brew install rectangle #mac cool move window
  brew install starship #shows cool stuff in terminal like git and time spent in cli app
  brew install youtube-dl
  brew install tmux
  brew install tree 
fi
