<<<<<<< HEAD
#!/bin/bash
filesForSymLink=(".vimrc" ".bashrc" ".tmux.conf" "init.vim")
pathToSymLink=(~/.vimrc ~/.bashrc ~/.tmux.conf ~/.config/nvim/init.vim)
for i in ${!filesForSymLink[@]}
do
    sudo ln -sf ~/.dotfiles/${filesForSymLink[i]} ${pathToSymLink[i]} 
    #echo "symlink created for ${filesForSymLink[i]}"
done
=======
#!/bin/bash
filesForSymLink=(".vimrc" ".bashrc" ".tmux.conf")
for i in ${!filesForSymLink[@]}
do
    ln -fs ~/.dotfiles/${filesForSymLink[i]} ~/${filesForSymLink[i]} 
    echo "symlink created for ${filesForSymLink[i]}"
done
>>>>>>> 6014fe29767066bc6c4f32a9d3d6bf9263008137
