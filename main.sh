#!/bin/bash
filesForSymLink=(".vimrc" ".bashrc")
for i in ${!filesForSymLink[@]}
do
    ln -fs ~/.dotfiles/${filesForSymLink[i]} ~/${filesForSymLink[i]} 
    echo "symlink created for ${filesForSymLink[i]}"
done
