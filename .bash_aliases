#!/bin/bash

if [ -f ~/dotfiles/scripts/alias.sh ]; then
    . ~/dotfiles/scripts/alias.sh
fi

alias vim="nvim"
alias vimrc="vim ~/dotfiles/configs/nvim/init.lua"
alias toggleyabai="~/dotfiles/configs/skhd/toggleyabai.sh"
alias nvims="~/dotfiles/nvim/switch_configs.sh"

alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias df='df -h' # disk free, in Gigabytes, not bytes
alias lpath='echo $PATH | tr ":" "\n"' # list the PATH separated by new lines

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	alias cs="cd /mnt/c/Users/gians/Desktop/CS/"
	alias schoolstuff="cd /mnt/c/Users/gians/Desktop/CS/SchoolStuff"
	alias webdev="cd /mnt/c/Users/gians/Desktop/CS/WebDev"
	alias open="xdg-open"
	alias start="explorer.exe"
	alias settings="vim /mnt/c/Users/gians/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
	alias randShabad="python3 /mnt/c/Users/gians/Desktop/CS/pythons/randomstuff/randSikhStuff/randShabad.py"
fi

if [[ "$OSTYPE" == "darwin2"* ]]; then
  alias rm=trash
  alias ios='open -a /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
	alias python="python3"
	alias py="python3"
	alias pip="pip3"
  alias icloud="cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/"
fi

if [[ ~ == "/Users/gians" ]];then
	alias dev="cd /Users/gians/Desktop/dev"
	alias webdev="cd /Users/gians/Desktop/dev/webdev"
	alias mobile="cd /Users/gians/Desktop/dev/mobile"
  alias ssa="vim /Users/gians/Desktop/NJIT/SSA/SSA23-24.txt"
fi

cap () { tee /tmp/capture.out; } # capture the output of a command so it can be retrieved with ret
ret () { cat /tmp/capture.out; } # return the output of the most recent command that was captured by cap
