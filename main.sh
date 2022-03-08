#!/bin/bash
filesForSymLink=(".vimrc" ".bashrc" ".tmux.conf" "nvim/")
pathToSymLink=(~/.vimrc ~/.bashrc ~/.tmux.conf ~/.config/nvim/)
for i in ${!filesForSymLink[@]}
do
    sudo ln -sf ~/.dotfiles/${filesForSymLink[i]} ${pathToSymLink[i]} 
    #echo "symlink created for ${filesForSymLink[i]}"
done
