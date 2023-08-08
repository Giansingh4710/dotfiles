vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { silent = false }
local keymap = vim.keymap.set

require("user.helper_funcs")

Sections_For_Whichkey = {
	l = { name = " LSP" },
	-- d = { name = " Debugger" },
	-- b = { name = "󰓩 Buffers" },
	-- g = { name = " Git" },
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
keymap("v", "<", "<gv", opts) -- Stay in indent mode
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
keymap("n", ",cpp", ":-1r ~/dotfiles/skeletons/cpp<CR>", { desc = "C++ snippet" })
keymap("n", ",c", ":-1r ~/dotfiles/skeletons/c<CR>", { desc = "C snippet" })
keymap("n", ",html", ":-1r ~/dotfiles/skeletons/html<CR>", { desc = "html snippet" })
keymap("n", ",java", ':r !bash ~/dotfiles/skeletons/java.sh %<CR>gg"_ddf.dt ', { desc = "Java snippet" })

keymap("n", "gF", '"hyiW:e <C-r>h<CR>', { desc = "Go make file" }) --go file but make file under cursor (put in h register)

keymap("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment Visual Mode" })
keymap("v", "<leader>p", '"_dP', { desc = "Paste Without Yank" })
keymap("v", "<leader>r", 'y:%s/<C-r>"//gc<LEFT><LEFT><LEFT>', { desc = "Replace Old Fashion" })

keymap("n", "<leader>r", 'yiw:%s/<C-R>"//gc<LEFT><LEFT><LEFT>', { desc = "Replace Word Old Fashion" })
keymap("n", "<leader>cc", ":lua require'notify'.dismiss()<CR>", { desc = "Clear all Notifications" })
keymap("n", "<leader>C", "<cmd>GetRandomColor<CR>", { desc = "Generate Random Color" })
keymap("n", "<leader>n", ":call ToggleNERDTree()<CR>", { desc = "Toggle NERDTree" })
keymap("n", "<leader>D", ":bdelete<CR>", { desc = "Buffer Delete" })
keymap("n", "<leader>e", ":lua require'lir.float'.toggle()<CR>", { desc = "lir File Explorer" })
keymap("n", "<leader>v", "<cmd>vsplit<cr>", { desc = "vsplit" })
keymap("n", "<leader>q", ":call QuickFixToggle()<CR>", { desc = "Toggle Quick Fix List" })
keymap("n", "<leader>t", ":tabnew<CR>:Ex<CR>", { desc = "New Tab" })
keymap("n", "<leader>m", "<cmd>Mason<CR>", { desc = "Mason (LSP)" })
keymap("n", "<leader><leader>", ":w<CR>:so %<CR>", { desc = "Save and Source" })
keymap("n", "<leader>V", ":tabnew $MYVIMRC<CR>", { desc = "edit Vimrc" })
keymap("n", "<leader><CR>", ":nohlsearch<CR>", { desc = "No Highlight" })
keymap("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment" })
keymap("n", "<leader>E", ":lua ToggleCharAtEndOfLine()<CR>", { desc = "Toggle EOL Char" })
keymap("n", "<leader>F", "<cmd>ToggleFoldMethod<CR>", { desc = "Toggle Fold Method" })
keymap("n", "<leader>s", ":lua Split_long_line()<CR>", { noremap = true, silent = true, desc = "Split line" })
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file Executable (chmod +x)" })
keymap("n", "<leader>N", ":lua SaveToAppleNotes()<CR>", { desc = "Save to Apple Notes" })
keymap("n", "<leader>S", ":lua Search_Exact_Phrase()<CR>", { desc = "Search" })

Sections_For_Whichkey["f"] = { name = " Find" }
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffer" })
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

Sections_For_Whichkey["d"] = { name = " Debugger or Diff" }
Sections_For_Whichkey["d"]["g"] = { name = " Git" }
keymap("n", "<leader>dw", ":call DiffWindo()<CR>", { desc = "Diff Windows(files)" })
keymap("n", "<leader>dgF", ":DiffviewFileHistory<CR>", { desc = "Diff of All FILES (Git)" })
keymap("n", "<leader>dgf", ":DiffviewFileHistory %<CR>", { desc = "Diff File (Git)" })
keymap("n", "<leader>dgt", ":DiffviewToggleFiles<CR>", { desc = "Diff toggle File Panel (Git)" })
keymap("n", "<leader>dgc", ":DiffviewClose<CR>", { desc = "Diff Close (Git)" })

keymap("n", "<F5>", ":lua require('dap').continue()<CR>", { desc = "Debugger: Start" })
keymap("n", "<F17>", ":lua require('dap').terminate()<CR>", { desc = "Debugger: Stop" }) -- Shift+F5
keymap("n", "<F29>", ":lua require('dap').restart_frame()<CR>", { desc = "Debugger: Restart" }) -- Control+F5
keymap("n", "<F6>", ":lua require('dap').pause()<CR>", { desc = "Debugger: Pause" })
keymap("n", "<F9>", ":lua require('dap').toggle_breakpoint()<CR>", { desc = "Debugger: Toggle Breakpoint" })
keymap("n", "<F10>", ":lua require('dap').step_over()<CR>", { desc = "Debugger: Step Over" })
keymap("n", "<F11>", ":lua require('dap').step_into()<CR>", { desc = "Debugger: Step Into" })
keymap("n", "<F23>", ":lua require('dap').step_out()<CR>", { desc = "Debugger: Step Out" }) -- Shift+F11
keymap("n", "<leader>db", ":lua require('dap').toggle_breakpoint()<CR>", { desc = "Toggle Breakpoint (F9)" })
keymap(
	"n",
	"<leader>dB",
	":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ desc = "Set Breakpoint with condition" }
)
keymap("n", "<leader>dR", ":lua require('dap').clear_breakpoints()<CR>", { desc = "Reset Breakpoints" })
keymap("n", "<leader>dc", ":lua require('dap').continue()<CR>", { desc = "Start/Continue (F5)" })
keymap("n", "<leader>di", ":lua require('dap').step_into()<CR>", { desc = "Step Into (F11)" })
keymap("n", "<leader>do", ":lua require('dap').step_over()<CR>", { desc = "Step Over (F10)" })
keymap("n", "<leader>dO", ":lua require('dap').step_out()<CR>", { desc = "Step Out (S-F11)" })
keymap("n", "<leader>dq", ":lua require('dap').close()<CR>", { desc = "Close Session" })
keymap("n", "<leader>dQ", ":lua require('dap').terminate()<CR>", { desc = "Terminate Session (S-F5)" })
keymap("n", "<leader>dp", ":lua require('dap').pause()<CR>", { desc = "Pause (F6)" })
keymap("n", "<leader>dr", ":lua require('dap').restart_frame()<CR>", { desc = "Restart (C-F5)" })
-- keymap("n", "<leader>dR", ":lua require('dap').repl.toggle()<CR>", { desc = "Toggle REPL" })
keymap("n", "<leader>du", ":lua require('dapui').toggle()<CR>", { desc = "Toggle Debugger UI" })
keymap("n", "<leader>dh", ":lua require('dap.ui.widgets').hover()<CR>", { desc = "Debugger Hover" })
keymap("n", "<leader>dn", ":lua require('dap').run_to_cursor()<CR>", { desc = "Run To Cursor" })
keymap("n", "<leader>dlf", ":Telescope dap frames<CR>", { desc = "Debugger Frames" })
keymap("n", "<leader>dC", ":Telescope dap commands<CR>", { desc = "Debugger Commands" })
keymap("n", "<leader>dlb", ":Telescope dap list_breakpoints<CR>", { desc = "Debugger Breakpoints" })

keymap("n", "<leader>d?", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end, { desc = "Debugger Scopes" })
-- keymap("n", "<leader>dk", ':lua require'dap'.up()<CR>zz')
-- keymap("n", "<leader>dj", ':lua require'dap'.down()<CR>zz')
-- keymap("n", "<leader>dr", ':lua require'dap'.repl.toggle({}, "vsplit")<CR><C-w>l')

keymap("n", "<leader>lf", ":lua vim.lsp.buf.format()<CR>", { noremap = true, silent = false, desc = "Format" })
