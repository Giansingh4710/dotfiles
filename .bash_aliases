#!/bin/bash

alias vim="nvim"
alias vimrc="vim ~/dotfiles/nvim/init.lua"
alias vimv="~/dotfiles/scripts/vimv.sh"
alias addX="~/dotfiles/scripts/addX.sh"
alias dl="~/dotfiles/scripts/download_files/run.sh"
alias delFiles="~/dotfiles/scripts/delFiles.sh"
alias playSDO="~/dotfiles/scripts/playSDO.sh"
alias coolCmds="vim ~/dotfiles/scripts/coolCmds.txt"

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

if [[ "$OSTYPE" == "darwin2"* ]]; then
  alias sshLogin="~/dotfiles/scripts/sshLogin.sh"
  alias gvim="~/dotfiles/scripts/macVim.sh"
  alias python="python3"
  alias py="python3"
  alias pip="pip3"
  alias dev="cd /Users/gians/Desktop/dev"
  alias webdev="cd /Users/gians/Desktop/dev/webdev"
  alias mobile="cd /Users/gians/Desktop/dev/mobile"
  alias cs288="cd /Users/gians/Desktop/dev/SchoolStuff/CS288"
  alias toggleyabai="~/.config/skhd/toggleyabai.sh"
  alias sdo="open /Applications/Safari.app https://sdoji.xyz/other_pages/all.html"
  alias sdoji="cd /Users/gians/Desktop/dev/webdev/sdo-ji/ ; vim index.html"
  alias delDsStore="~/dotfiles/scripts/delDsStore.sh"
fi
