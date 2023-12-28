--[[ /Users/gians/.local/share/nvim ]]
require("user.options")
require("user.autocommands")
require("user.keymaps")
require("plugins")

local wk = require("which-key") -- Sections_For_Whichkey from keymaps.lua
wk.register(Sections_For_Whichkey, { prefix = "<leader>" })
