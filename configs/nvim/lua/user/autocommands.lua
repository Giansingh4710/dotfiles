local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    vim.opt_local.foldmethod = "indent"
    vim.opt_local.foldlevel = 0
  end,
  group = vim.api.nvim_create_augroup("MakeFoldIndent", { clear = true }),
  pattern = { "*.txt" },
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
    vim.opt.tabstop = 2 -- insert 2 spaces for a tab
  end,
  group = vim.api.nvim_create_augroup("CS490Group", { clear = true }),
  pattern = { "~/Desktop/NJIT/classes/CS490/group_proj/*" },
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    Transparent()
  end,
})

vim.cmd([[
  augroup Keerat
    autocmd!
    autocmd BufWritePost ~/Desktop/dev/webdev/keerat/app/Keertan/AkhandKeertan/TRACKS.js !/bin/bash ~/Desktop/dev/webdev/keerat/app/Keertan/AllKeertan/writeTracks.sh
    autocmd BufWritePost ~/Desktop/dev/webdev/keerat/app/Keertan/DarbarSahibPuratanKeertanSGPC/TRACKS.js !/bin/bash ~/Desktop/dev/webdev/keerat/app/Keertan/AllKeertan/writeTracks.sh
    autocmd BufWritePost ~/Desktop/dev/webdev/keerat/app/Keertan/TimeBasedRaagKeertan/TRACKS.js !/bin/bash ~/Desktop/dev/webdev/keerat/app/Keertan/AllKeertan/writeTracks.sh
  augroup END
]])

vim.cmd([[
  augroup ThingsToDo
    autocmd!
    autocmd BufWritePost ~/Desktop/todo.md :SaveToAppleNotes
    autocmd BufReadPost ~/Desktop/todo.md :ReadFromAppleNotes
  augroup END
]])
