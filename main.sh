#!/bin/bash
filesForSymLink=(".vimrc" ".bashrc" ".tmux.conf" "init.vim")
pathToSymLink=(~/.vimrc ~/.bashrc ~/.tmux.conf ~/.config/nvim/init.vim)
for i in ${!filesForSymLink[@]}
do
    sudo ln -sf ~/.dotfiles/${filesForSymLink[i]} ${pathToSymLink[i]} 
    #echo "symlink created for ${filesForSymLink[i]}"
done
