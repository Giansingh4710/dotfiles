-- highlight yanked text
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.cmd([[
  augroup Keerat
    autocmd!
    autocmd BufWritePost ~/Desktop/dev/webdev/keerat/listenScreensUtils/index.html !/bin/bash ~/Desktop/dev/webdev/keerat/listenScreensUtils/makeHtml2js.sh
  augroup END
]])
