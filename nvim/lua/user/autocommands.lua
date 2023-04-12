local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

vim.api.nvim_create_autocmd({"BufEnter"}, {
  callback = function()
    vim.opt_local.foldmethod = "indent" 
  end,
  group = vim.api.nvim_create_augroup("MakeFoldIndent", { clear = true }),
  pattern = {"*.txt"},
})

vim.cmd([[
  augroup Keerat
    autocmd!
    autocmd BufWritePost ~/Desktop/dev/webdev/keerat/listenScreensUtils/index.html !/bin/bash ~/Desktop/dev/webdev/keerat/listenScreensUtils/makeHtml2js.sh
  augroup END
]])

