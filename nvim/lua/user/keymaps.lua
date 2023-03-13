local opts = { noremap = true, silent = false }

local keymap = vim.keymap.set

-- all keys that use <leader> will be in whichkey.lua file
vim.g.mapleader = " "
vim.g.maplocalleader = " "
keymap("n", "<C-Space>", "<cmd>WhichKey \\<leader><cr>", opts)
keymap("i", "jk", "<ESC>", opts)

-- Modes normal_mode = "n", insert_mode = "i", visual_mode = "v", visual_block_mode = "x", term_mode = "t", command_mode = "c",

keymap("n", "H", "^", opts) -- I hate typing these
keymap("n", "L", "$", opts)
keymap("v", "H", "^", opts)
keymap("v", "L", "$", opts)
keymap("x", "H", "^", opts)
keymap("x", "L", "$", opts)
keymap("o", "H", "^", opts)
keymap("o", "L", "$", opts)

keymap("v", "<", "<gv", opts) -- Stay in indent mode
keymap("v", ">", ">gv", opts)

keymap("v", "J", ":m '>+1<CR>gv=gv", opts) -- move lines in v mode
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

keymap("v", "x", '"_d', opts) --no save to register
keymap("x", "x", '"_d', opts)

-- NOTE: the fact that tab and ctrl-i are the same is stupid
keymap("n", "<C-w>t", ":tabnew %<CR>",opts)

--snippets
keymap("n",",cpp", ':r ~/dotfiles/skeletons/cpp<CR>gg"_dd4j',opts)
keymap("n",",html", ':r ~/dotfiles/skeletons/html<CR>gg"_dd9j',opts)
keymap("n", ",java", ':r !bash ~/dotfiles/skeletons/java.sh %<CR>gg"_dd2j',opts)

keymap('n','gF','"hyiW:e <C-r>h<CR>', opts) --go file but make file under cursor (put in h register)
