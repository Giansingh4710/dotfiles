local which_key = require("which-key")

local icons = require("user.icons")

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 40, -- how many suggestions should be shown in the list?
		},
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = icons.ui.ArrowClosed, -- symbol used in the command line area that shows your active key combo
		separator = icons.ui.ArrowRight, -- symbol used between a key and it's label
		group = icons.ui.Plus, -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]

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

vim.api.nvim_create_user_command("ToggleAutoPairs", function()
	local a = require("nvim-autopairs")
	vim.ui.input({ prompt = "Enter 0 to disable or 1 to enable autopairs: " }, function(input)
		if input == "0" then
			a.disable()
			print("autopairs disabled")
		else
			a.enable()
			print("autopairs enabled")
		end
	end)
end, {})

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = false, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappingsNormMode = {
	a = { "<cmd>ToggleAutoPairs<CR>", "Toggle AutoPairs" },
  n = {":NERDTreeToggle<CR>","Toggle NERDTree"},
	d = { ":call DiffWindo()<CR>", "Compare Windows" },
	e = { ":lua require'lir.float'.toggle()<CR>", "lir File Explorer" },
	r = { 'yiw:%s/<C-R>"//gc<LEFT><LEFT><LEFT>', "Replace Word Old Fashion" },
	v = { "<cmd>vsplit<cr>", "vsplit" },
  q = {":call QuickFixToggle()<CR>","Toggle Quick Fix List"},
  t = {":tabnew<CR>:Ex<CR>","New Tab"},
	H = { ":bprev<CR>", "Prev Buff" },
	L = { ":bnext<CR>", "Next Buff" },
	S = { ":w<CR>:so %<CR>", "Save and Source" },
	V = { ":tabnew $MYVIMRC<CR>", "edit Vimrc" },
	["<CR>"] = { ":nohlsearch<cr>", "NO Highlight" },
  ["/"] = { "<Plug>(comment_toggle_linewise_current)" , "Comment" },

	l = {name = "LSP"}, --implemented with lsp
	b = {
		name = "Bookmarks",
		a = { "<cmd>BookmarkAnnotate<cr>", "Annotate" },
		b = { "<cmd>BookmarkToggle<cr>", "Toggle" },
		c = { "<cmd>BookmarkClearAll<cr>", "Clear All" },
		j = { "<cmd>silent BookmarkPrev<cr>", "Prev" },
		k = { "<cmd>BookmarkNext<cr>", "Next" },
		s = { "<cmd>silent BookmarkShowAll<cr>", "Prev" },
	},
	f = {
		name = "Find",
		b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		f = { "<cmd>Telescope find_files<cr>", "Find files" },
		t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
		s = { "<cmd>Telescope grep_string<cr>", "Find String" },
		h = { "<cmd>Telescope help_tags<cr>", "Help" },
		H = { "<cmd>Telescope highlights<cr>", "Highlights" },
		l = { "<cmd>Telescope resume<cr>", "Last Search" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		R = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
		r = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
	},
	s = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
	},
	T = {
		name = "Terminal",
		n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	},
}

local mappingsVisualMode = {
  r = {'y:%s/<C-r>"//gc<LEFT><LEFT><LEFT>',"Replace Old Fashion"},
  p = {'"_dP',"Paste Without Yank"},
  ["/"] = {'<Plug>(comment_toggle_linewise_visual)',"Comment Visual Mode"},
}

which_key.setup(setup)
which_key.register(mappingsNormMode, opts)
which_key.register(mappingsVisualMode, {
	mode = "v",
	prefix = "<leader>",
	buffer = nil,
	silent = false,
	voremap = true,
	nowait = true,
})

