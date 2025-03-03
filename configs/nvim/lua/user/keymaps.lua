vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- local keymap = vim.keymap.set
require("user.helper_funcs")

AllKeymapGroups = {}
local function keymap(mode, keymap_binding, command, desc)
  vim.keymap.set(mode, keymap_binding, command, { silent = false, desc = desc })
  table.insert(AllKeymapGroups, { keymap_binding, command, desc = desc, mode = mode })
end

--[[
  normal_mode = "n",
  insert_mode = "i",
  visual_mode = "v",
  visual_block_mode = "x",
  term_mode = "t",
  command_mode = "c",
]]
keymap("i", "jk", "<ESC>")
-- keymap({ "n", "v", "x" }, "H", "^") -- I hate typing these
-- keymap({ "n", "v", "x" }, "L", "$")
keymap("v", "<", "<gv") -- Stay in indent mode
keymap("v", ">", ">gv")

keymap("n", "<C-e>", "5<C-e>")
keymap("n", "<C-y>", "5<C-y>")

keymap("n", "<C-w>t", ":tabnew %<CR>")
keymap("n", "<C-w>H", ":wincmd <<CR>", "Change window size")
keymap("n", "<C-w>J", ":wincmd +<CR>", "Change window size")
keymap("n", "<C-w>K", ":wincmd -<CR>", "Change window size")
keymap("n", "<C-w>L", ":wincmd ><CR>", "Change window size")

--snippets
-- table.insert(AllKeymapGroups, { ",", group = " Snippets" })
-- keymap("n", ",cc", ":-1r ~/dotfiles/other/skeletons/c<CR>", "C snippet")
-- keymap("n", ",cpp", ":-1r ~/dotfiles/other/skeletons/cpp<CR>", "C++ snippet")
-- keymap("n", ",html", ":-1r ~/dotfiles/other/skeletons/html<CR>", "html snippet")
-- keymap("n", ",java", ':r !bash ~/dotfiles/other/skeletons/java.sh %<CR>gg"_ddf.dt ', "Java snippet")

keymap("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", "Comment Visual Mode")
keymap("v", "<leader>p", '"_dP', "Paste Without Yank")
keymap("v", "<leader>r", 'y:%s/<C-r>"//gc<LEFT><LEFT><LEFT>', "Replace Old Fashion")

keymap("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", "Comment")
keymap("n", "<leader><CR>", ":nohlsearch<CR>", "No Highlight")
keymap("n", "<leader><leader>", ":source $MYVIMRC<CR>", "Save and Source Nvim config")
keymap("n", "<leader>E", ":lua ToggleCharAtEndOfLine()<CR>", "Toggle EOL Char")
keymap("n", "<leader>F", ":ToggleFoldMethod<CR>", "Toggle Fold Method")
keymap("n", "<leader>L", ":Lazy<CR>", "Lazy plugin manager")
keymap("n", "<leader>V", TelescopeSearchVimConfig, "Edit Vimrc")
keymap("n", "<leader>e", ":Neotree filesystem reveal toggle<CR>", "Toggle Explorer (NeoTree)")
keymap("n", "<leader>gC", ":GetRandomColor<CR>", "Generate Random Color")
keymap("n", "<leader>q", ":call QuickFixToggle()<CR>", "Toggle Quick Fix List")
keymap("n", "<leader>r", 'yiw:%s/<C-R>"//gc<LEFT><LEFT><LEFT>', "Replace Word Old Fashion")
keymap("n", "<leader>s", ":lua Split_long_line()<CR>", "Split line")
keymap("n", "<leader>t", ":tabnew %<CR>:Oil<CR>", "New Tab")
keymap("n", "<leader>v", ":vsplit<cr>", "vsplit")
keymap("n", "<leader>x", ":!chmod +x %;./%<CR>", "Make file Executable (chmod +x)")

table.insert(AllKeymapGroups, { "<leader>S", group = "Search (Spectre)" })
keymap("n", "<leader>St", '<cmd>lua require("spectre").toggle()<CR>', "Toggle Spectre")
keymap("n", "<leader>Sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', "Search current word")
keymap("v", "<leader>Sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', "Search current word")
keymap("n", "<leader>Sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', "Search on current file")


table.insert(AllKeymapGroups, { "<leader>f", group = " Find" })
keymap("n", "<leader>fb", ":Telescope buffers<cr>", "Find Buffer")
keymap("n", "<leader>fC", ":Telescope colorscheme<cr>", "Colorscheme")
keymap("n", "<leader>fc", ":Telescope commands<cr>", "Commands")
keymap("n", "<leader>ff", ":Telescope find_files<cr>", "Find files")
keymap("n", "<leader>ft", ":Telescope live_grep<cr>", "Find Text")
keymap("n", "<leader>fs", ":Telescope grep_string<cr>", "Find String")
keymap("n", "<leader>fh", ":Telescope help_tags<cr>", "Help")
keymap("n", "<leader>fH", ":Telescope highlights<cr>", "Highlights")
keymap("n", "<leader>fl", ":Telescope resume<cr>", "Last Search")
keymap("n", "<leader>fm", ":Telescope man_pages<cr>", "Man Pages")
keymap("n", "<leader>fr", ":Telescope oldfiles<cr>", "Recent File")
keymap("n", "<leader>fR", ":Telescope registers<cr>", "Registers")
keymap("n", "<leader>fk", ":Telescope keymaps<cr>", "Keymaps")

table.insert(AllKeymapGroups, { "<leader>T", group = " Terminal" })
keymap("n", "<leader>Tn", ":lua _NODE_TOGGLE()<cr>", "Node")
keymap("n", "<leader>Tu", ":lua _NCDU_TOGGLE()<cr>", "NCDU")
keymap("n", "<leader>Tt", ":lua _HTOP_TOGGLE()<cr>", "Htop")
keymap("n", "<leader>Tp", ":lua _PYTHON_TOGGLE()<cr>", "Python")
keymap("n", "<leader>Tf", ":ToggleTerm direction=float<cr>", "Float")
keymap("n", "<leader>Th", ":ToggleTerm size=10 direction=horizontal<cr>", "Horizontal")
keymap("n", "<leader>Tv", ":ToggleTerm size=80 direction=vertical<cr>", "Vertical")

table.insert(AllKeymapGroups, { "<leader>d", group = " Diff" })
table.insert(AllKeymapGroups, { "<leader>dv", group = " Diffview (git)" })
keymap("n", "<leader>dw", ":call DiffWindo()<CR>", "Diff Windows(files)")
keymap("n", "<leader>dvo", ":DiffviewOpen<CR>", "Diffview Open")
keymap("n", "<leader>dvc", ":DiffviewClose<CR>", "Diffview Close")
keymap("n", "<leader>dvF", ":DiffviewFileHistory<CR>", "Diff of All FILES (Git)")
keymap("n", "<leader>dvf", ":DiffviewFileHistory %<CR>", "Diff File (Git)")

table.insert(AllKeymapGroups, { "<leader>g", group = " Git" })
keymap("n", "<leader>gj", ":Gitsigns next_hunk<CR>", "Next Git Hunk")
keymap("n", "<leader>gk", ":Gitsigns prev_hunk<CR>", "Previous Git Hunk")
keymap("n", "<leader>gd", ":Gitsigns diffthis<CR>", "Git Diffthis")
keymap("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", "Git Reset Hunk")
keymap("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", "Git Preview Hunk")
keymap("n", "<leader>gB", ":Gitsigns blame_line<CR>", "Git Blame Line")

table.insert(AllKeymapGroups, { "<leader>l", group = " LSP" })
-- keymap("n", "<leader>lf", ":lua vim.lsp.buf.format()<CR>", "Format")
keymap("n", "<leader>lm", ":Mason<CR>", "Mason (LSP)")
keymap("n", "<leader>lf", ":Format<CR>", "Format")
keymap("n", "<leader>li", ":LspInfo<cr>", "Info")
keymap("n", "<leader>la", ":lua vim.lsp.buf.code_action()<cr>", "Code Action")
keymap("n", "<leader>lj", ":lua vim.diagnostic.goto_next({buffer=0})<cr>", "Next diagnostic")
keymap("n", "<leader>lk", ":lua vim.diagnostic.goto_prev({buffer=0})<cr>", "Previous diagnostic")
keymap("n", "<leader>lr", ":lua vim.lsp.buf.rename()<cr>", "Rename")
keymap("n", "<leader>lq", ":lua vim.diagnostic.setloclist()<CR>", "Diagnostic Quickfix")
keymap("n", "<leader>ls", ":lua vim.lsp.buf.signature_help()<CR>", "Signature help")
keymap("n", "<leader>lS", ":Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols")
keymap("n", "<leader>lt", ":lua vim.diagnostic.enable(not vim.diagnostic.is_enabled()) <CR>", "Toggle Diagnostics")
keymap("n", "<leader>lo", ":Lspsaga outline<CR>", "Toggle Outile")
keymap("n", "<leader>lca", ":Lspsaga code_action<CR>", "Code Action")
keymap("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", "Previous Diagnostic")
keymap("n", "]d", ":Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic")
keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", "Go to implementation")
keymap("n", "gr", ":Telescope lsp_references<CR>", "Telescope References")
keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", "Go to Definition")
keymap("n", "gl", ":lua vim.diagnostic.open_float()<CR>", "Show Line diagnostics")
keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", "Hover Info")

table.insert(AllKeymapGroups, { "<leader>b", group = "󰓩 Buffers" })
keymap("n", "<leader>bd", ":bdelete<CR>", "Buffer Delete")
keymap("n", "<leader>bn", ":bnext<CR>", "Buffer Next")
keymap("n", "<leader>bp", ":bprev<CR>", "Buffer Prev")

table.insert(AllKeymapGroups, { "<leader>m", group = "📈Markdown" })
keymap("n", "<leader>mp", ":MarkdownPreview<CR>", "Markdown Preview (in browser)")
keymap("n", "<leader>mr", ":RenderMarkdown toggle<CR>", "Render Markdown toggle")

table.insert(AllKeymapGroups, { "<leader>X", group = "󰓩 Xcode" })
keymap("n", "<leader>Xs", ":XcodebuildSetup<CR>", "Setup Xcode Project")

table.insert(AllKeymapGroups, { "<leader>h", group = " Harpoon" })
keymap("n", "<leader>ha", ":lua Harpoon:list():add()<CR>", "Add current file to harpoon")
keymap("n", "<leader>hl", ":lua Harpoon.ui:toggle_quick_menu(Harpoon:list())<CR>", "Toggle harpoon menu")
keymap("n", "<leader>h1", ":lua Harpoon:list():select(1)<CR>", "Select harpoon item 1")
keymap("n", "<leader>h2", ":lua Harpoon:list():select(2)<CR>", "Select harpoon item 2")
keymap("n", "<leader>h3", ":lua Harpoon:list():select(3)<CR>", "Select harpoon item 3")
keymap("n", "<leader>h4", ":lua Harpoon:list():select(4)<CR>", "Select harpoon item 4")
keymap("n", "<leader>h5", ":lua Harpoon:list():select(5)<CR>", "Select harpoon item 5")
keymap("n", "<leader>h6", ":lua Harpoon:list():select(6)<CR>", "Select harpoon item 6")
keymap("n", "<leader>ht", ":lua Toggle_telescope_haroon(Harpoon:list())<CR>", "Toggle harpoon telescope")

table.insert(AllKeymapGroups, { "<leader>o", group = "Obsidian" })
keymap("n", "<leader>oo", ":tabnew /Users/gians/Library/Mobile Documents/iCloud~md~obsidian/Documents <CR>", "Edit Obsidian")
keymap("n", "<leader>ot", ":ObsidianToday ", "Open today note")

keymap("n", "<leader>ct", ":CodeiumToggle<CR>", "Codeium Toggle")

keymap("n", "-", ":Oil<CR>", "Open parent directory")
keymap("n", "yp", ":OilYankPath<CR>", "Yank Path")
keymap("n", "<leader>P", ":MacOSQuicklook<CR>", "Preview file (MacOS)")
