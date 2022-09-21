local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

local icons = require("user.icons")

gitsigns.setup {
  signs = {
    add = { hl = "GitSignsAdd", text = icons.git.Add , numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = icons.git.Mod, numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = icons.git.Remove, numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = icons.git.Remove, numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = icons.git.Remove, numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
}

