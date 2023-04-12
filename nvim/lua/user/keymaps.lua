vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { silent = false }
local keymap = vim.keymap.set

require("user.helper_funcs")

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
keymap("v", "<", "<gv", opts) -- Stay in indent mode
keymap("v", ">", ">gv", opts)

-- keymap("v", "J", ":m '>+1<CR>gv=gv", opts) -- move lines in v mode
-- keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- scroll the viewport faster
keymap("n", "<C-e>", "3<c-e>", opts)
keymap("n", "<C-y>", "3<c-y>", opts)

keymap("v", "x", '"_d', opts) --no save to register
keymap("x", "x", '"_d', opts)

-- NOTE: the fact that tab and ctrl-i are the same is stupid
keymap("n", "<C-w>t", ":tabnew %<CR>", opts)

--snippets
keymap("n", ",cpp", ":-1r ~/dotfiles/skeletons/cpp<CR>", { desc = "C++ snippet" })
keymap("n", ",c", ":-1r ~/dotfiles/skeletons/c<CR>", { desc = "C snippet" })
keymap("n", ",html", ":-1r ~/dotfiles/skeletons/html<CR>", { desc = "html snippet" })
keymap("n", ",java", ':r !bash ~/dotfiles/skeletons/java.sh %<CR>gg"_dd2j', { desc = "Java snippet" })

keymap("n", "gF", '"hyiW:e <C-r>h<CR>', { desc = "Go make file" }) --go file but make file under cursor (put in h register)
keymap("n", "<leader>r", 'yiw:%s/<C-R>"//gc<LEFT><LEFT><LEFT>', { desc = "Replace Word Old Fashion" })

keymap(
	"n",
	"<leader>cc",
	":lua require'notify'.dismiss({ silent = true, pending = true })<CR>",
	{ desc = "Clear all Notifications" }
)
keymap("n", "<leader>C", "<cmd>GetRandomColor<CR>", { desc = "Generate Random Color" })
keymap("n", "<leader>n", ":call ToggleNERDTree()<CR>", { desc = "Toggle NERDTree" })
keymap("n", "<leader>d", ":call DiffWindo()<CR>", { desc = "Compare Windows" })
keymap("n", "<leader>D", ":bdelete<CR>", { desc = "Buffer Delete" })
keymap("n", "<leader>e", ":lua require'lir.float'.toggle()<CR>", { desc = "lir File Explorer" })
keymap("n", "<leader>m", "<cmd>Mason<CR>", { desc = "Mason (LSP)" })

keymap("n", "<leader>v", "<cmd>vsplit<cr>", { desc = "vsplit" })
keymap("n", "<leader>q", ":call QuickFixToggle()<CR>", { desc = "Toggle Quick Fix List" })
keymap("n", "<leader>t", ":tabnew<CR>:Ex<CR>", { desc = "New Tab" })
keymap("n", "<leader>H", ":bprev<CR>", { desc = "Prev Buff" })
keymap("n", "<leader>L", ":bnext<CR>", { desc = "Next Buff" })
keymap("n", "<leader>S", ":w<CR>:so %<CR>", { desc = "Save and Source" })
keymap("n", "<leader>V", ":tabnew $MYVIMRC<CR>", { desc = "edit Vimrc" })

keymap("n", "<leader><CR>", ":nohlsearch<CR>", { desc = "No Highlight" })
keymap("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment" })

keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffer" })
keymap("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>", { desc = "Colorscheme" })
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap("n", "<leader>ft", "<cmd>Telescope live_grep<cr>", { desc = "Find Text" })
keymap("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", { desc = "Find String" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })
keymap("n", "<leader>fH", "<cmd>Telescope highlights<cr>", { desc = "Highlights" })
keymap("n", "<leader>fl", "<cmd>Telescope resume<cr>", { desc = "Last Search" })
keymap("n", "<leader>fM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
keymap("n", "<leader>fR", "<cmd>Telescope oldfiles<cr>", { desc = "Recent File" })
keymap("n", "<leader>fr", "<cmd>Telescope registers<cr>", { desc = "Registers" })
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
keymap("n", "<leader>fC", "<cmd>Telescope commands<cr>", { desc = "Commands" })

keymap("n", "<leader>sb", "<cmd>Telescope git_branches<cr>", { desc = "Checkout branch" })
keymap("n", "<leader>sc", "<cmd>Telescope colorscheme<cr>", { desc = "Colorscheme" })
keymap("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Find Help" })
keymap("n", "<leader>sM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
keymap("n", "<leader>sr", "<cmd>Telescope oldfiles<cr>", { desc = "Open Recent File" })
keymap("n", "<leader>sR", "<cmd>Telescope registers<cr>", { desc = "Registers" })
keymap("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
keymap("n", "<leader>sC", "<cmd>Telescope commands<cr>", { desc = "Commands" })

keymap("n", "<leader>Tn", "<cmd>lua _NODE_TOGGLE()<cr>", { desc = "Node" })
keymap("n", "<leader>Tu", "<cmd>lua _NCDU_TOGGLE()<cr>", { desc = "NCDU" })
keymap("n", "<leader>Tt", "<cmd>lua _HTOP_TOGGLE()<cr>", { desc = "Htop" })
keymap("n", "<leader>Tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", { desc = "Python" })
keymap("n", "<leader>Tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float" })
keymap("n", "<leader>Th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "Horizontal" })
keymap("n", "<leader>Tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "Vertical" })

keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file Executable (chmod +x)" })

keymap("v", "<leader>r", 'y:%s/<C-r>"//gc<LEFT><LEFT><LEFT>', { desc = "Replace Old Fashion" })
keymap("v", "<leader>p", '"_dP', { desc = "Paste Without Yank" })
keymap("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment Visual Mode" })
keymap("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment Visual Mode" })

keymap("n", "<leader>F", "<cmd>ToggleFoldMethod<CR>", { desc = "Vertical" })

