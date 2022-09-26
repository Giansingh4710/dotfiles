#!/bin/sh
filesForSymLink=(
  .bashrc
  .tmux.conf
  .bash_aliases
  .zshrc
  .vimrc
  nvim/
  karabiner/
  skhd/
  yabai/
)

pathToSymLink=(
  ~/.bashrc 
  ~/.tmux.conf 
  ~/.bash_aliases 
  ~/.zshrc 
  ~/.vimrc
  ~/.config/nvim/
  ~/.config/karabiner/
  ~/.config/skhd/
  ~/.config/yabai/
)

for i in ${!filesForSymLink[@]}
do
    ln -sf ~/dotfiles/${filesForSymLink[$i]} ${pathToSymLink[$i]}
    echo "symlink created for ${filesForSymLink[$i]}"
done

