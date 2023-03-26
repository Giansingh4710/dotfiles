-- highlight yanked text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

vim.cmd([[
  augroup Keerat
    autocmd!
    autocmd BufWritePost ~/Desktop/dev/webdev/keerat/listenScreensUtils/index.html !/bin/bash ~/Desktop/dev/webdev/keerat/listenScreensUtils/makeHtml2js.sh
  augroup END
]])
