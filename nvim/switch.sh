#!/bin/bash

if [ -f ./kickstart.lua ];then
  mv ./init.lua ./my.lua
  mv ./kickstart.lua ./init.lua
else
  mv ./init.lua ./kickstart.lua
  mv ./my.lua ./init.lua
fi
