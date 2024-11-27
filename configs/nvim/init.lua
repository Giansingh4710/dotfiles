--[[ /Users/gians/.local/share/nvim ]]
require("user.options")
require("user.autocommands")
require("user.keymaps")
require("plugins")

RandomColorScheme()
require("which-key").add(All_Keymaps) -- from keymaps.lua
-- I put all my keymaps in this table and then add to which-key because if my
-- plugins fail and have an error, I can still have my keymaps. Not sure If I
-- explained that properly
