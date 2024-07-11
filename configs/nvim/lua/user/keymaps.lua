vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set

local function keymap_opts(desc)
  return { silent = false, desc = desc }
end

require("user.helper_funcs")

Sections_For_Whichkey = {
  -- l = { name = " LSP" },
  -- d = { name = " Debugger" },
}

--[[
  normal_mode = "n",
  insert_mode = "i",
  visual_mode = "v",
  visual_block_mode = "x",
  term_mode = "t",
  command_mode = "c",
]]
keymap("i", "jk", "<ESC>")
keymap({ "n", "v", "x" }, "H", "^") -- I hate typing these
keymap({ "n", "v", "x" }, "L", "$")
keymap("v", "<", "<gv") -- Stay in indent mode
keymap("v", ">", ">gv")
keymap("n", "<C-w>t", ":tabnew %<CR>") -- NOTE: the fact that tab and ctrl-i are the same is stupid

keymap("n", "<C-w>H", ":wincmd <<CR>", keymap_opts("Change window size"))
keymap("n", "<C-w>J", ":wincmd +<CR>", keymap_opts("Change window size"))
keymap("n", "<C-w>K", ":wincmd -<CR>", keymap_opts("Change window size"))
keymap("n", "<C-w>L", ":wincmd ><CR>", keymap_opts("Change window size"))

--snippets
keymap("n", ",cc", ":-1r ~/dotfiles/other/skeletons/c<CR>", keymap_opts("C snippet"))
keymap("n", ",cpp", ":-1r ~/dotfiles/other/skeletons/cpp<CR>", keymap_opts("C++ snippet"))
keymap("n", ",html", ":-1r ~/dotfiles/other/skeletons/html<CR>", keymap_opts("html snippet"))
keymap("n", ",java", ':r !bash ~/dotfiles/other/skeletons/java.sh %<CR>gg"_ddf.dt ', keymap_opts("Java snippet"))

keymap("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", keymap_opts("Comment Visual Mode"))
keymap("v", "<leader>p", '"_dP', keymap_opts("Paste Without Yank"))
keymap("v", "<leader>r", ":%s/<C-r><C-w>//gc<LEFT><LEFT><LEFT>", keymap_opts("Replace Old Fashion"))

keymap("n", "<leader><leader>", ":w<CR>:source $MYVIMRC<CR>", keymap_opts("Save and Source Nvim config"))
keymap("n", "<leader>M", "V!bc<CR>", keymap_opts("Math"))
keymap("n", "<leader>r", ":%s/<C-R><C-w>//gc<LEFT><LEFT><LEFT>", keymap_opts("Replace Word Old Fashion"))
keymap("n", "<leader>cd", ":Copilot disable<CR>", keymap_opts("Disable Copilot"))
keymap("n", "<leader>gc", ":GetRandomColor<CR>", keymap_opts("Generate Random Color"))
keymap("n", "<leader>e", ":call ToggleNERDTree()<CR>", keymap_opts("Toggle Explorer (NERDTree)"))
keymap("n", "<leader>v", ":vsplit<cr>", keymap_opts("vsplit"))
keymap("n", "<leader>q", ":call QuickFixToggle()<CR>", keymap_opts("Toggle Quick Fix List"))
keymap("n", "<leader>t", ":tabnew<CR>:Ex<CR>", keymap_opts("New Tab"))
keymap("n", "<leader>m", ":Mason<CR>", keymap_opts("Mason (LSP)"))
keymap("n", "<leader>V", ":tabnew $MYVIMRC<CR>", keymap_opts("edit Vimrc"))
keymap("n", "<leader><CR>", ":nohlsearch<CR>", keymap_opts("No Highlight"))
keymap("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", keymap_opts("Comment"))
keymap("n", "<leader>E", ":lua ToggleCharAtEndOfLine()<CR>", keymap_opts("Toggle EOL Char"))
keymap("n", "<leader>F", ":ToggleFoldMethod<CR>", keymap_opts("Toggle Fold Method"))
keymap("n", "<leader>s", ":lua Split_long_line()<CR>", keymap_opts("Split line"))
keymap("n", "<leader>x", ":!chmod +x %;./%<CR>", keymap_opts("Make file Executable (chmod +x)"))
keymap("n", "<leader>S", ":lua Search_Exact_Phrase()<CR>", keymap_opts("Search"))

Sections_For_Whichkey["f"] = { name = " Find" }
keymap("n", "<leader>fb", ":Telescope buffers<cr>", keymap_opts("Find Buffer"))
keymap("n", "<leader>fc", ":Telescope colorscheme<cr>", keymap_opts("Colorscheme"))
keymap("n", "<leader>fC", ":Telescope commands<cr>", keymap_opts("Commands"))
keymap("n", "<leader>ff", ":Telescope find_files<cr>", keymap_opts("Find files"))
keymap("n", "<leader>ft", ":Telescope live_grep<cr>", keymap_opts("Find Text"))
keymap("n", "<leader>fs", ":Telescope grep_string<cr>", keymap_opts("Find String"))
keymap("n", "<leader>fh", ":Telescope help_tags<cr>", keymap_opts("Help"))
keymap("n", "<leader>fH", ":Telescope highlights<cr>", keymap_opts("Highlights"))
keymap("n", "<leader>fl", ":Telescope resume<cr>", keymap_opts("Last Search"))
keymap("n", "<leader>fm", ":Telescope man_pages<cr>", keymap_opts("Man Pages"))
keymap("n", "<leader>fr", ":Telescope oldfiles<cr>", keymap_opts("Recent File"))
keymap("n", "<leader>fR", ":Telescope registers<cr>", keymap_opts("Registers"))
keymap("n", "<leader>fk", ":Telescope keymaps<cr>", keymap_opts("Keymaps"))

Sections_For_Whichkey["T"] = { name = " Terminal" }
keymap("n", "<leader>Tn", ":lua _NODE_TOGGLE()<cr>", keymap_opts("Node"))
keymap("n", "<leader>Tu", ":lua _NCDU_TOGGLE()<cr>", keymap_opts("NCDU"))
keymap("n", "<leader>Tt", ":lua _HTOP_TOGGLE()<cr>", keymap_opts("Htop"))
keymap("n", "<leader>Tp", ":lua _PYTHON_TOGGLE()<cr>", keymap_opts("Python"))
keymap("n", "<leader>Tf", ":ToggleTerm direction=float<cr>", keymap_opts("Float"))
keymap("n", "<leader>Th", ":ToggleTerm size=10 direction=horizontal<cr>", keymap_opts("Horizontal"))
keymap("n", "<leader>Tv", ":ToggleTerm size=80 direction=vertical<cr>", keymap_opts("Vertical"))

Sections_For_Whichkey["d"] = { name = " Diff" }
Sections_For_Whichkey["d"]["v"] = { name = " Diffview (git)" }
keymap("n", "<leader>dw", ":call DiffWindo()<CR>", keymap_opts("Diff Windows(files)"))
keymap("n", "<leader>dvo", ":DiffviewOpen<CR>", keymap_opts("Diffview Open"))
keymap("n", "<leader>dvc", ":DiffviewClose<CR>", keymap_opts("Diffview Close"))
keymap("n", "<leader>dvF", ":DiffviewFileHistory<CR>", keymap_opts("Diff of All FILES (Git)"))
keymap("n", "<leader>dvf", ":DiffviewFileHistory %<CR>", keymap_opts("Diff File (Git)"))

Sections_For_Whichkey["g"] = { name = " Git" }
keymap("n", "<leader>gj", ":Gitsigns next_hunk<CR>", keymap_opts("Next Git Hunk"))
keymap("n", "<leader>gk", ":Gitsigns prev_hunk<CR>", keymap_opts("Previous Git Hunk"))
keymap("n", "<leader>gd", ":Gitsigns diffthis<CR>", keymap_opts("Git Diffthis"))
keymap("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", keymap_opts("Git Reset Hunk"))
keymap("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", keymap_opts("Git Preview Hunk"))
keymap("n", "<leader>gb", ":Gitsigns blame_line<CR>", keymap_opts("Git Blame Line"))

Sections_For_Whichkey["l"] = { name = " LSP" }
-- keymap("n", "<leader>lf", ":lua vim.lsp.buf.format()<CR>", keymap_opts("Format"))
keymap("n", "<leader>lf", ":Format<CR>", keymap_opts("Format"))
keymap("n", "<leader>li", ":LspInfo<cr>", keymap_opts("Info"))
keymap("n", "<leader>la", ":lua vim.lsp.buf.code_action()<cr>", keymap_opts("Code Action"))
keymap("n", "<leader>lj", ":lua vim.diagnostic.goto_next({buffer=0})<cr>", keymap_opts("Next diagnostic"))
keymap("n", "<leader>lk", ":lua vim.diagnostic.goto_prev({buffer=0})<cr>", keymap_opts("Previous diagnostic"))
keymap("n", "<leader>lr", ":lua vim.lsp.buf.rename()<cr>", keymap_opts("Rename"))
keymap("n", "<leader>lq", ":lua vim.diagnostic.setloclist()<CR>", keymap_opts("Diagnostic Quickfix"))
keymap("n", "<leader>ls", ":lua vim.lsp.buf.signature_help()<CR>", keymap_opts("Signature help"))
keymap("n", "<leader>lS", ":Telescope lsp_dynamic_workspace_symbols<cr>", keymap_opts("Workspace Symbols"))
keymap("n", "<leader>lt", ":ToggleDiag<cr>", keymap_opts("Toggle Diagnostics"))
keymap("n", "<leader>lo", ":Lspsaga outline<CR>", keymap_opts("Toggle Outile"))
keymap("n", "<leader>lca", ":Lspsaga code_action<CR>", keymap_opts("Code Action"))
keymap("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", keymap_opts("Previous Diagnostic"))
keymap("n", "]d", ":Lspsaga diagnostic_jump_next<CR>", keymap_opts("Next Diagnostic"))
keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", keymap_opts("Go to implementation"))
keymap("n", "gr", ":Telescope lsp_references<CR>", keymap_opts("Telescope References"))
keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", keymap_opts("Go to Definition"))
keymap("n", "gl", ":lua vim.diagnostic.open_float()<CR>", keymap_opts("Show Line diagnostics"))
keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", keymap_opts("Hover Info"))

Sections_For_Whichkey["b"] = { name = "󰓩 Buffers" }
keymap("n", "<leader>bd", ":bdelete<CR>", keymap_opts("Buffer Delete"))
keymap("n", "<leader>bn", ":bnext<CR>", keymap_opts("Buffer Next"))
keymap("n", "<leader>bp", ":bprev<CR>", keymap_opts("Buffer Prev"))

Sections_For_Whichkey["h"] = { name = " Harpoon" }
keymap("n", "<leader>ha", ":lua Harpoon:list():add()<CR>", keymap_opts("Add current file to harpoon"))
keymap("n", "<leader>hl", ":lua Harpoon.ui:toggle_quick_menu(Harpoon:list())<CR>", keymap_opts("Toggle harpoon menu"))
keymap("n", "<leader>h1", ":lua Harpoon:list():select(1)<CR>", keymap_opts("Select harpoon item 1"))
keymap("n", "<leader>h2", ":lua Harpoon:list():select(2)<CR>", keymap_opts("Select harpoon item 2"))
keymap("n", "<leader>h3", ":lua Harpoon:list():select(3)<CR>", keymap_opts("Select harpoon item 3"))
keymap("n", "<leader>h4", ":lua Harpoon:list():select(4)<CR>", keymap_opts("Select harpoon item 4"))
keymap("n", "<leader>h5", ":lua Harpoon:list():select(5)<CR>", keymap_opts("Select harpoon item 5"))
keymap("n", "<leader>h6", ":lua Harpoon:list():select(6)<CR>", keymap_opts("Select harpoon item 6"))
keymap("n", "<leader>ht", ":lua Toggle_telescope_haroon(Harpoon:list())<CR>", keymap_opts("Toggle harpoon telescope"))

keymap("n", "-", ":Oil<CR>", keymap_opts("Open parent directory"))
