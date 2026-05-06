--[[ /Users/gians/.local/share/nvim ]]
-- require "user.options" means import lua/user/options.lua

-- REQUIRED FONT: a Nerd Font v3.x (icons in statusline, file tree, etc).
-- Install on macOS:
--   brew install --cask font-hack-nerd-font font-jetbrains-mono-nerd-font
-- Then set terminal font to "Hack Nerd Font Mono" or "JetBrainsMono Nerd Font Mono".
-- Note: kitty auto-falls-back to any installed Nerd Font; iTerm2/alacritty do not.
-- Old Nerd Fonts (v2.x) miss many icons -- use v3.0+.

require("user.helper_funcs")

require("user.options")
require("user.keymaps")
require("user.autocmds")
require("user.lazy") -- user.plugins defined in there refers to lua/user/plugins/init.lua

RandomColorScheme()
-- require("which-key").add(AllKeymapGroups) -- from keymaps.lua
