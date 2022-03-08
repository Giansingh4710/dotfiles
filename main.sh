#!/bin/bash
filesForSymLink=(".bashrc" ".tmux.conf" "nvim/")
pathToSymLink=(~/.bashrc ~/.tmux.conf ~/.config/nvim)
for i in ${!filesForSymLink[@]}
do
    sudo ln -sf ~/.dotfiles/${filesForSymLink[i]} ${pathToSymLink[i]} 
    #echo "symlink created for ${filesForSymLink[i]}"
done
