#!/bin/bash

alias vim="nvim"
alias vimv="~/dotfiles/vimv.sh"
alias vimrc="vim ~/dotfiles/nvim/init.lua"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias cs288="cd /mnt/c/Users/gians/Desktop/CS/SchoolStuff/CS288"
  alias cs="cd /mnt/c/Users/gians/Desktop/CS/"
  alias schoolstuff="cd /mnt/c/Users/gians/Desktop/CS/SchoolStuff"
  alias webdev="cd /mnt/c/Users/gians/Desktop/CS/WebDev"
  alias pythons="cd /mnt/c/Users/gians/Desktop/CS/pythons"
  alias open="xdg-open"
  alias start="explorer.exe"
  alias settings="vim /mnt/c/Users/gians/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
  alias randShabad="python3 /mnt/c/Users/gians/Desktop/CS/pythons/randomstuff/randSikhStuff/randShabad.py"
fi

if [[ "$OSTYPE" == "darwin21"* ]]; then
  alias python="python3"
  alias py="python3"
  alias pip="pip3"
  alias webdev="cd /Users/gians/Desktop/dev/webdev"
  alias cs288="cd /Users/gians/Desktop/dev/SchoolStuff/CS288"
  alias toggleyabai="~/.config/skhd/toggleyabai.sh"
  alias sdo="open /Applications/Safari.app https://sdoji.xyz/other_pages/all.html"
  alias sdoji="cd /Users/gians/Desktop/dev/webdev/sdo-ji/ ; vim index.html"
fi
