vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- will be case sensitive if you search with a capital letter
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.numberwidth = 2 -- set number column width to 2 {default 4}
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.cursorline = true -- highlight the current line
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.completeopt = "menuone,noselect" -- mostly just for cmp
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.undofile = true -- enable persistent undo
vim.opt.timeout = true
vim.opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.updatetime = 300 -- faster completion (4000ms default)
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.laststatus = 3
vim.opt.showcmd = true -- show incomplete commands
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false -- display lines as one long line
vim.opt.scrolloff = 8 -- is one of my fav
vim.opt.sidescrolloff = 8
vim.opt.fillchars.eob = " "
vim.opt.guifont = "Hack Nerd Font" --(neovide)the font used in graphical neovim applications
vim.opt.colorcolumn = "80"
vim.opt.virtualedit = "block" -- allows cursor to move where there is no text in visual block mode
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.shortmess:append("c")
vim.opt.autochdir = false -- changing to false for harpoon
vim.opt.lazyredraw = false
-- vim.opt.title = true
vim.cmd("set whichwrap+=<,>,[,],h,l") --got to next line if end of line
vim.cmd("set grepprg=git\\ grep\\ -n") -- for searching through :grep
-- vim.cmd("hi Normal guibg=NONE ctermbg=NONE") -- makes backdround transparent -- have function in ./autocommands.lua
-- vim.cmd("set formatoptions-=cro") -- dont add comment when i go to new line from a comment line
-- vim.opt.iskeyword:append("-")

vim.opt.list = true
vim.opt.listchars = { tab = "→ ", eol = "¬", trail = "⋅", extends = "❯", precedes = "❮" }

vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 10 -- foldlevels opened on file open
