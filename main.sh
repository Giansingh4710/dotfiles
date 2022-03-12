#!/bin/bash
filesForSymLink=(".bashrc" ".tmux.conf" ".bash_aliases" ".zshrc" "nvim/")
pathToSymLink=(~/.bashrc ~/.tmux.conf ~/.bash_aliases ~/.zshrc ~/.config/nvim)
for i in ${!filesForSymLink[@]}
do
    sudo ln -sf ~/.dotfiles/${filesForSymLink[i]} ${pathToSymLink[i]} 
    #echo "symlink created for ${filesForSymLink[i]}"
done
