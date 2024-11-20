--[[ /Users/gians/.local/share/nvim ]]
require("user.options")
require("user.autocommands")
require("user.keymaps")
require("plugins")

RandomColorScheme()
require("which-key").add(All_Keymaps) -- from keymaps.lua
