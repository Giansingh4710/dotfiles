local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
keymap("n", "<C-Space>", "<cmd>WhichKey \\<leader><cr>", opts)
keymap("n", "<C-i>", "<C-i>", opts)

keymap("i", "jk", "<ESC>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- I hate typing these
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)
keymap("v", "H", "^", opts)
keymap("v", "L", "$", opts)
keymap("x", "H", "^", opts)
keymap("x", "L", "$", opts)
keymap("o", "H", "^", opts)
keymap("o", "L", "$", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

--no save to register
keymap("v", "p", '"_dP', opts)
keymap("v", "x", '"_d', opts)
keymap("x", "x", '"_d', opts)
-- keymap("v", "P", '"_dP', opts)

-- Custom
keymap("n", "<c-h>", "<cmd>nohlsearch<cr>", opts)
-- NOTE: the fact that tab and ctrl-i are the same is stupid
-- keymap("n", "<TAB>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]

keymap("n", "<m-q>", ":call QuickFixToggle()<cr>", opts)
keymap("n", "<c-l>", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
----------------------------------------------------------------------------
--my key maps

keymap("n", "<C-w>t", ":tabnew %<CR>",opts)

--replace words faster
keymap("n" ,"<leader>r", 'yiw:%s/<C-R>"//gc<LEFT><LEFT><LEFT>',opts)
keymap("v" ,"<leader>r", 'y:%s/<C-r>"//gc<LEFT><LEFT><LEFT>',opts)
keymap("n" ,"<leader>t", ':tabnew<CR>:Ex<CR>',opts)
keymap("n" ,"<leader>ev",':tabnew $MYVIMRC<CR>:cd %:p:h<CR>',opts)
keymap("n" ,"<leader>sv",':w<cr>:source $MYVIMRC <CR>',opts)

vim.cmd [[
  function! DiffWindo()
      if &diff
          :windo diffoff
      else
          if len(tabpagebuflist()) > 1
              ":windo diffthis
              :10 wincmd l "go to the right most pane
              :diffthis
              :wincmd h "go to the pane on left and compare it to that
              :diffthis 
          else
              :vs
              :Ex
          endif
      endif
  endfunction
]]


--Comment.nvim Toggle using count
vim.keymap.set('n', '<leader>/', "v:count == 0 ? '<Plug>(comment_toggle_current_linewise)' : '<Plug>(comment_toggle_linewise_count)'", { expr = true, remap = true })
vim.keymap.set('n', 'gbc', "v:count == 0 ? '<Plug>(comment_toggle_current_blockwise)' : '<Plug>(comment_toggle_blockwise_count)'", { expr = true, remap = true })
-- Toggle in Op-pending mode
vim.keymap.set('n', 'gc', '<Plug>(comment_toggle_linewise)')
vim.keymap.set('n', 'gb', '<Plug>(comment_toggle_blockwise)')
-- Toggle in VISUAL mode
vim.keymap.set('x', '<leader>/', '<Plug>(comment_toggle_linewise_visual)')
vim.keymap.set('x', 'gb', '<Plug>(comment_toggle_blockwise_visual)')

-- keymap("n","<C-n>", ":NERDTree<CR>",opts)
keymap("n","<C-t>", ":NERDTreeToggle<CR>",opts)
keymap("n","<C-f>", ":NERDTreeFind<CR>",opts)

vim.cmd("nnoremap <expr> <leader>n g:NERDTree.IsOpen() ? ':NERDTreeClose<CR>' : @%=='' ? ':NERDTreeToggle<CR>' : ':NERDTreeFind<CR>'")
-- vim.cmd("nnoremap <expr> <leader>n g:NERDTree.IsOpen() ? ':NERDTreeClose<CR>' : ':NERDTreeFind<CR>'")

--snippets
keymap("n",",cpp", ':r ~/dotfiles/skeletons/cpp<CR>gg"_dd4j',opts)
keymap("n",",html", ':r ~/dotfiles/skeletons/html<CR>gg"_dd9j',opts)
keymap("n", ",java", ':r !bash ~/dotfiles/skeletons/java.sh %<CR>gg"_dd2j',opts)

keymap("n","sc", 'Bi"<esc>f i"<esc>',opts)

