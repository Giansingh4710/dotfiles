-- ranger like file explorer
local status_ok, lir = pcall(require, "lir")
if not status_ok then
  return
end

local actions = require("lir.actions")
local clipboard_actions = require("lir.clipboard.actions")

local mappings = {
  ["<C-s>"] = actions.split,
  ["<C-t>"] = actions.tabedit,
  ["@"] = actions.cd,
  ["A"] = actions.mkdir,
  ["Y"] = actions.yank_path,
  ["a"] = actions.newfile,
  ["c"] = clipboard_actions.copy,
  ["d"] = actions.delete,
  ["h"] = actions.up,
  ["i"] = actions.toggle_show_hidden,
  ["l"] = actions.edit,
  ["p"] = clipboard_actions.paste,
  ["q"] = actions.quit,
  ["r"] = actions.rename,
  ["v"] = actions.vsplit,
  ["x"] = clipboard_actions.cut,
  ["?"] = function()
    ShowMappingsWindow()
  end,
}

lir.setup({
  show_hidden_files = true,
  devicons = {
    enable = true,
  },
  mappings = mappings,
  float = {
    winblend = 0,
    curdir_window = {
      enable = true,
      highlight_dirname = true,
    },
  },
  hide_cursor = false,
  on_init = function()
    vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, true, {})
  end,
})

function ShowMappingsWindow()
  local theInfo = {
    "<C-s> = split",
    "<C-t> = tabedit",
    "@ = cd",
    "A = mkdir",
    "Y = yank_path",
    "a = newfile",
    "d = delete",
    "h = up",
    "i = toggle_show_hidden",
    "l = edit",
    "q = quit",
    "r = rename",
    "v = vsplit",
  }
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = 30,
    height = #theInfo + 3,
    row = 0,
    col = 10,
    style = "minimal",
    --[[ focusable=false, ]]
    border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
  })
  vim.api.nvim_win_set_buf(win, buf)
  vim.api.nvim_buf_set_lines(buf, 0, 0, true,theInfo)
  vim.keymap.set("n", "?", ":quit<CR>", { noremap = true, silent = false, buffer = buf })
  vim.keymap.set("n", "q", ":quit<CR>", { noremap = true, silent = false, buffer = buf })
  vim.keymap.set("n", "<ESC>", ":quit<CR>", { noremap = true, silent = false, buffer = buf })
end
