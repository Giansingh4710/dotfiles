return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    Harpoon = require("harpoon") -- global because setting keymaps in ../../user/keymaps.lua
    Harpoon:setup()
  end,
}
