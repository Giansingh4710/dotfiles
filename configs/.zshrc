if [ -f ~/dotfiles/bash_aliases ]; then
    . ~/dotfiles/bash_aliases
fi

eval "$(starship init zsh)" # makes cmd line pretty
eval "$(fzf --zsh)"

