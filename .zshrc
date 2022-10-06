 # run "ZDOTDIR="$(mktemp -d)" p9k_configure" to get the wizard again
 if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
 fi

 # Path to your oh-my-zsh installation.
 export ZSH="$HOME/.oh-my-zsh"

 plugins=(
   git
   zsh-autosuggestions 
   vi-mode
   macos
 )

 source $ZSH/oh-my-zsh.sh

 if [ -f ~/.bash_aliases ]; then
     . ~/.bash_aliases
 fi

 # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
 # [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

 PATH=$PATH:~/.local/bin #for lvim

 #for go
 export GOROOT=/usr/local/go
 export GOPATH=$HOME/go
 export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

 # Generated for envman. Do not edit.
 [ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

 # eval "$(~/.rbenv/bin/rbenv init - zsh)" #for rubyenv(rbenv) for react native

eval "$(starship init zsh)"
# ZSH_THEME="powerlevel10k/powerlevel10k"
