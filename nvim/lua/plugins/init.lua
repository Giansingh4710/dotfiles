local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	"tpope/vim-surround",
	"christoomey/vim-tmux-navigator", --tmux and vim window switcher BEST
	"preservim/nerdtree",
	"lunarvim/colorschemes", -- Colorschemes

	"nvim-telescope/telescope.nvim",
	"nvim-treesitter/nvim-treesitter",
	"windwp/nvim-ts-autotag", --treesitter autotag
	"chentoast/marks.nvim",
	"folke/zen-mode.nvim",
	"stevearc/dressing.nvim", --cool looks
	"tamago324/lir.nvim", --file Explorer
	"nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
	"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
	"JoosepAlviste/nvim-ts-context-commentstring", -- correct comments in html file where there is js,html,css
	"nvim-lualine/lualine.nvim",
	"akinsho/toggleterm.nvim",
	"lukas-reineke/indent-blankline.nvim",

	"hrsh7th/nvim-cmp", -- The completion plugin
	"hrsh7th/cmp-buffer", -- buffer completions
	"hrsh7th/cmp-path", -- path completions
	"saadparwaiz1/cmp_luasnip", -- snippet completions
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",

	-- snippets
	"L3MON4D3/LuaSnip", --snippet engine
	"rafamadriz/friendly-snippets", -- a bunch of snippets to use


	-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
	{ "numToStr/Comment.nvim", opts = {} },
	{ "NvChad/nvim-colorizer.lua", opts = {} }, --show colors in css files stc
	{ "folke/which-key.nvim", opts = {} },
	{
		"lewis6991/gitsigns.nvim", -- Adds git releated signs to the gutter, as well as utilities for managing changes
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
	},
	{
		"lunarvim/darkplus.nvim", --[[ "darkplus" --vscode ]]
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("darkplus")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "j-hui/fidget.nvim", opts = {} }, -- Useful status updates for LSP
		},
	},

	-- LSP
	"jayp0521/mason-null-ls.nvim", -- bridges gap b/w mason & null-ls
	"jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
	"RRethy/vim-illuminate", --highlight other words when on word
	"WhoIsSethDaniel/toggle-lsp-diagnostics.nvim", -- toggle diagnostic
	"ray-x/lsp_signature.nvim", --show func def when typing

	{
		"glepnir/lspsaga.nvim", -- ui for lsp
		dependencies = { { "kyazdani42/nvim-web-devicons" }, { "nvim-treesitter/nvim-treesitter" } },
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 500,
			background_colour = "#000000",
			max_height = function()
				return math.floor(vim.o.lines * 0.25)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.25)
			end,
		},
	},
}

require("lazy").setup(plugins)

require("plugins.treesitter")
require("plugins.bufferline") --top tab line
require("plugins.marks")
require("plugins.telescope")
require("plugins.nvim-ts-autotag") --treesitter autotag vscode like tags
require("plugins.lualine") --bottom line
require("plugins.toggleterm")
require("plugins.cmp") -- completion

require("plugins.dressing") -- makes things look nice like input
require("plugins.indentline")
require("plugins.lir")
require("plugins.autopairs")
require("plugins.zen-mode")
require("plugins.lsp")