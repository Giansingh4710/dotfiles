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

# chsh -s $(which zsh) #change shell to zsh

if [ ! -d ~/.config/ ];then
  mkdir ~/.config
  echo Made .config dir
fi

if [ ! -d ~/OLD_FILES ];then
  mkdir ~/OLD_FILES
  echo Made OLD_FILES dir
fi

for i in "${!filesForSymLink[@]}"; do
	theItem=${filesForSymLink[$i]}
	pathToItem=~/dotfiles/$theItem
	whereToPutItem=${pathToSymLink[$i]}
	if [[ "$OSTYPE" != "darwin2"* ]]; then # if not a mac
		if {
			  [ "$theItem" == "karabiner" ] ||
				[ "$theItem" == "skhd" ] ||
				[ "$theItem" == "yabai" ]
		}; then
			# echo "No symlink created because '$theItem' is for MAC ONLY"
			continue
		fi
	fi

  if [ -e "$whereToPutItem" ];then
	  mv "$whereToPutItem" ~/OLD_FILES/
  fi

	ln -sf "$pathToItem" "$whereToPutItem"
	if [ $? -eq 0 ]; then
		echo "symlink created for ${filesForSymLink[$i]}"
	else
		echo "Error linking $pathToItem -> $whereToPutItem "
	fi
done

if [[ "$OSTYPE" == "darwin2"* ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" #install brew
  # Needed for stuff to run in script folder
  brew install python
  brew install yt-dlp
  pip3 install selenium
  pip3 install requests
  pip3 install BeautifulSoup4
  pip3 install mutagen

  # brew install koekeishiya/formulae/yabai #window tile manager
  # brew install koekeishiya/formulae/skhd #key binding for stuff like yabai and anything

  # brew services start yabai
  # brew services start skhd
  #brew services start/stop (name of service)
  #brew services restart --all ; brew service list

  #brew install --cask rectangle

fi

# brew install "$1"
# sudo apt install "$1"
#download neovim
#download node #for lsp and other stuff. Node is node lol
#download shellcheck #lsp for bash (neovim)
#download starship #shows cool stuff in terminal like git and time spent in cli app
#download youtube-dl
#download tmux
#download tree 
