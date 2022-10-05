#!/bin/sh

filesForSymLink[0]=.bashrc
filesForSymLink[1]=.tmux.conf
filesForSymLink[2]=.bash_aliases
filesForSymLink[3]=.zshrc
filesForSymLink[4]=.vimrc
filesForSymLink[5]=nvim
filesForSymLink[6]=karabiner #change keybindings like hyper on mac
filesForSymLink[7]=skhd # keybindings for window manager etc
filesForSymLink[8]=yabai #tiling window manager

pathToSymLink[0]=~/.bashrc
pathToSymLink[1]=~/.tmux.conf
pathToSymLink[2]=~/.bash_aliases
pathToSymLink[3]=~/.zshrc
pathToSymLink[4]=~/.vimrc
pathToSymLink[5]=~/.config/nvim
pathToSymLink[6]=~/.config/karabiner
pathToSymLink[7]=~/.config/skhd
pathToSymLink[8]=~/.config/yabai

for i in "${!filesForSymLink[@]}"
do
  theItem=~/dotfiles/${filesForSymLink[$i]}
  whereToPutFile=${pathToSymLink[$i]}
  if [[ "$OSTYPE" != "darwin21"* ]]; then # if mac
    echo Not a Mac
    if { 
      [ "$theItem" = "karabiner" ] ||
        [ "$theItem" = "skhd" ] ||
        [ "$theItem" = "yabai" ]
      };then
      continue
    fi
  fi
  rm -r "$whereToPutFile"
  ln -sf "$theItem" "$whereToPutFile"
  if [ $? -eq 0 ];then
    echo "symlink created for ${filesForSymLink[$i]}"
  else
    echo "Error linking $theItem -> $whereToPutFile "
  fi
done

