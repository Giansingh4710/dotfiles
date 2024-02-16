vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { silent = false }
local keymap = vim.keymap.set

require("user.helper_funcs")

Sections_For_Whichkey = {
  l = { name = " LSP" },
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
keymap("i", "jk", "<ESC>", opts)
keymap({ "n", "v", "x" }, "H", "^", opts) -- I hate typing these
keymap({ "n", "v", "x" }, "L", "$", opts)
keymap("v", "<", "<gv", opts)             -- Stay in indent mode
keymap("v", ">", ">gv", opts)

-- scroll the viewport faster
keymap("n", "<C-e>", "3<c-e>", opts)
keymap("n", "<C-y>", "3<c-y>", opts)

keymap("v", "x", '"_d', opts) --no save to register
keymap("x", "x", '"_d', opts)

keymap("n", "<C-w>t", ":tabnew %<CR>", opts) -- NOTE: the fact that tab and ctrl-i are the same is stupid

keymap("n", "<C-w>H", ":wincmd <<CR>", { desc = "Change window size" })
keymap("n", "<C-w>J", ":wincmd +<CR>", { desc = "Change window size" })
keymap("n", "<C-w>K", ":wincmd -<CR>", { desc = "Change window size" })
keymap("n", "<C-w>L", ":wincmd ><CR>", { desc = "Change window size" })

--snippets
keymap("n", ",cc", ":-1r ~/dotfiles/other/skeletons/c<CR>", { desc = "C snippet" })
keymap("n", ",cpp", ":-1r ~/dotfiles/other/skeletons/cpp<CR>", { desc = "C++ snippet" })
keymap("n", ",html", ":-1r ~/dotfiles/other/skeletons/html<CR>", { desc = "html snippet" })
keymap("n", ",java", ':r !bash ~/dotfiles/other/skeletons/java.sh %<CR>gg"_ddf.dt ', { desc = "Java snippet" })

keymap("n", "gF", '"hyiW:e <C-r>h<CR>', { desc = "Go make file" }) --go file but make file under cursor (put in h register)

keymap("v", "<leader>M", "!bc<CR>", { desc = "Math" })
keymap("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment Visual Mode" })
keymap("v", "<leader>p", '"_dP', { desc = "Paste Without Yank" })
keymap("v", "<leader>r", ":%s/<C-r><C-w>//gc<LEFT><LEFT><LEFT>", { desc = "Replace Old Fashion" })

keymap("n", "<leader><leader>", ":w<CR>:source $MYVIMRC<CR>", { desc = "Save and Source Nvim config" })
keymap("n", "<leader>M", "V!bc<CR>", { desc = "Math" })
keymap("n", "<leader>r", ":%s/<C-R><C-w>//gc<LEFT><LEFT><LEFT>", { desc = "Replace Word Old Fashion" })
keymap("n", "<leader>cc", ":lua require'notify'.dismiss()<CR>", { desc = "Clear all Notifications" })
keymap("n", "<leader>cd", ":Copilot disable<CR>", { desc = "Disable Copilot" })
keymap("n", "<leader>C", "<cmd>GetRandomColor<CR>", { desc = "Generate Random Color" })
keymap("n", "<leader>n", ":call ToggleNERDTree()<CR>", { desc = "Toggle NERDTree" })
keymap("n", "<leader>e", ":lua require'lir.float'.toggle()<CR>", { desc = "lir File Explorer" })
keymap("n", "<leader>v", "<cmd>vsplit<cr>", { desc = "vsplit" })
keymap("n", "<leader>q", ":call QuickFixToggle()<CR>", { desc = "Toggle Quick Fix List" })
keymap("n", "<leader>t", ":tabnew<CR>:Ex<CR>", { desc = "New Tab" })
keymap("n", "<leader>m", "<cmd>Mason<CR>", { desc = "Mason (LSP)" })
keymap("n", "<leader>V", ":tabnew $MYVIMRC<CR>", { desc = "edit Vimrc" })
keymap("n", "<leader><CR>", ":nohlsearch<CR>", { desc = "No Highlight" })
keymap("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment" })
keymap("n", "<leader>E", ":lua ToggleCharAtEndOfLine()<CR>", { desc = "Toggle EOL Char" })
keymap("n", "<leader>F", "<cmd>ToggleFoldMethod<CR>", { desc = "Toggle Fold Method" })
keymap("n", "<leader>s", ":lua Split_long_line()<CR>", { noremap = true, silent = true, desc = "Split line" })
keymap("n", "<leader>x", "<cmd>!chmod +x %;./%<CR>", { desc = "Make file Executable (chmod +x)" })
keymap("n", "<leader>N", ":lua SaveToAppleNotes()<CR>", { desc = "Save to Apple Notes" })
keymap("n", "<leader>S", ":lua Search_Exact_Phrase()<CR>", { desc = "Search" })

Sections_For_Whichkey["f"] = { name = " Find" }
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffer" })
keymap("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>", { desc = "Colorscheme" })
keymap("n", "<leader>fC", "<cmd>Telescope commands<cr>", { desc = "Commands" })
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap("n", "<leader>ft", "<cmd>Telescope live_grep<cr>", { desc = "Find Text" })
keymap("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", { desc = "Find String" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })
keymap("n", "<leader>fH", "<cmd>Telescope highlights<cr>", { desc = "Highlights" })
keymap("n", "<leader>fl", "<cmd>Telescope resume<cr>", { desc = "Last Search" })
keymap("n", "<leader>fm", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent File" })
keymap("n", "<leader>fR", "<cmd>Telescope registers<cr>", { desc = "Registers" })
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })

Sections_For_Whichkey["T"] = { name = " Terminal" }
keymap("n", "<leader>Tn", "<cmd>lua _NODE_TOGGLE()<cr>", { desc = "Node" })
keymap("n", "<leader>Tu", "<cmd>lua _NCDU_TOGGLE()<cr>", { desc = "NCDU" })
keymap("n", "<leader>Tt", "<cmd>lua _HTOP_TOGGLE()<cr>", { desc = "Htop" })
keymap("n", "<leader>Tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", { desc = "Python" })
keymap("n", "<leader>Tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float" })
keymap("n", "<leader>Th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "Horizontal" })
keymap("n", "<leader>Tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "Vertical" })

Sections_For_Whichkey["d"] = { name = " Diff" }
Sections_For_Whichkey["d"]["g"] = { name = " Git" }
keymap("n", "<leader>dw", ":call DiffWindo()<CR>", { desc = "Diff Windows(files)" })
keymap("n", "<leader>dgF", ":DiffviewFileHistory<CR>", { desc = "Diff of All FILES (Git)" })
keymap("n", "<leader>dgf", ":DiffviewFileHistory %<CR>", { desc = "Diff File (Git)" })
keymap("n", "<leader>dgt", ":DiffviewToggleFiles<CR>", { desc = "Diff toggle File Panel (Git)" })
keymap("n", "<leader>dgc", ":DiffviewClose<CR>", { desc = "Diff Close (Git)" })

Sections_For_Whichkey["g"] = { name = " Git" }
keymap("n", "<leader>gj", ":Gitsigns next_hunk<CR>", { desc = "Next Git Hunk" })
keymap("n", "<leader>gk", ":Gitsigns prev_hunk<CR>", { desc = "Previous Git Hunk" })
keymap("n", "<leader>gd", ":Gitsigns diffthis<CR>", { desc = "Git Diffthis" })
keymap("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Git Reset Hunk" })
keymap("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Git Preview Hunk" })
keymap("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "Git Blame Line" })

Sections_For_Whichkey["h"] = { name = "Harpoon" }
keymap("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", { desc = "Mark file with harpoon" })
keymap("n", "<leader>hh", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", { desc = "Go to previous harpoon mark" })
keymap("n", "<leader>hl", "<cmd>lua require('harpoon.ui').nav_next()<cr>", { desc = "Go to next harpoon mark" })
keymap("n", "<leader>hm", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { desc = "Show harpoon marks" })

keymap("n", "<leader>lf", ":lua vim.lsp.buf.format()<CR>", { noremap = true, silent = false, desc = "Format" })
keymap("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "Info" })
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", { desc = "Format" })
keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code Action" })
keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", { desc = "Next diagnostic" })
keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", { desc = "Previous diagnostic" })
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename" })
keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", { desc = "Diagnostic Quickfix" })
keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })
keymap("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { desc = "Workspace Symbols" })
keymap("n", "<leader>lt", "<cmd>ToggleDiag<cr>", { desc = "Toggle Diagnostics" })

keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {desc="Go to implementation"})
keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", {desc="Telescope References"})
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {desc="Go to Definition"})
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", {desc="Show Line diagnostics"})

Sections_For_Whichkey["b"] = { name = "󰓩 Buffers" }
keymap("n", "<leader>bd", ":bdelete<CR>", { desc = "Buffer Delete" })
keymap("n", "<leader>bn", ":bnext<CR>", { desc = "Buffer Next" })
keymap("n", "<leader>bp", ":bprev<CR>", { desc = "Buffer Prev" })

keymap("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
