#!/bin/bash
filesForSymLink=(".vimrc" ".bashrc" ".tmux.conf")
for i in ${!filesForSymLink[@]}
do
    ln -fs ~/.dotfiles/${filesForSymLink[i]} ~/${filesForSymLink[i]} 
    echo "symlink created for ${filesForSymLink[i]}"
done
