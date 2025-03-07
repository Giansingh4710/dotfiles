--[[ /Users/gians/.local/share/nvim ]]
-- require "user.options" means import lua/user/options.lua
-- lua/plugins/configs/ folder will be loaded automatically

require("user.helper_funcs")

require("user.options")
require("user.keymaps")
require("user.autocmds")
require("user.lazy")

RandomColorScheme()
-- require("which-key").add(AllKeymapGroups) -- from keymaps.lua
