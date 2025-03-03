--[[ /Users/gians/.local/share/nvim ]]
-- require "user.options" means import lua/user/options.lua

require("user.options")
require("user.autocmds")
require("user.keymaps")
require("user.lazy")

-- lua/plugins/configs/ folder will be loaded automatically
RandomColorScheme()
require("which-key").add(AllKeymapGroups) -- from keymaps.lua
