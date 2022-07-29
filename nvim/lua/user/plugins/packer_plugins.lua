local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	-- snapshot = "july-24",
	snapshot_path = fn.stdpath("config") .. "/snapshots",
	max_jobs = 50,
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
		prompt_border = "rounded", -- Border style of prompt popups.
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- Plugin Mangager
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("rcarriga/nvim-notify") --cool notifications
	use("stevearc/dressing.nvim") --cool looks
	use("moll/vim-bbye") --better buffer delete
	use("lewis6991/impatient.nvim") --faster nvim
	use("tversteeg/registers.nvim") --cool displau for registers
	use("kyazdani42/nvim-web-devicons")
	use("akinsho/bufferline.nvim") --top tab line
	use("christianchiarulli/lualine.nvim") -- bottom Statusline
	use("lukas-reineke/indent-blankline.nvim") --shows indent
	use("tamago324/lir.nvim") --file Explorer
	use("numToStr/Comment.nvim") --comments
	use("akinsho/toggleterm.nvim")
	use("folke/which-key.nvim")
	use("NvChad/nvim-colorizer.lua") --show colors in css files stc
	use("lunarvim/onedarker.nvim") --colorschemes
	use "lunarvim/darkplus.nvim" --colorschemes
	use("lunarvim/colorschemes") --colorschemes
	use("preservim/nerdtree")
	use("christoomey/vim-tmux-navigator") --tmux and vim window switcher BEST
	use("MattesGroeger/vim-bookmarks") -- view marks

	-- Lua Development
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("nvim-lua/popup.nvim")
	use("christianchiarulli/lua-dev.nvim")
	-- use "folke/lua-dev.nvim"

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("ray-x/lsp_signature.nvim")
	use("simrat39/symbols-outline.nvim")
	use("b0o/SchemaStore.nvim")
	use("RRethy/vim-illuminate") --highlighs words if over them like match ()
	use("j-hui/fidget.nvim")
	use({ "lvimuser/lsp-inlayhints.nvim", branch = "readme" })

	-- Completion
	use("christianchiarulli/nvim-cmp")
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-emoji")
	use("hrsh7th/cmp-nvim-lua")

	-- Snippet
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- Syntax/Treesitter
	use("nvim-treesitter/nvim-treesitter")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("p00f/nvim-ts-rainbow")
	use("nvim-treesitter/playground")
	use("windwp/nvim-ts-autotag")
	use("nvim-treesitter/nvim-treesitter-textobjects")


	-- Fuzzy Finder/Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-media-files.nvim")
	use("tom-anders/telescope-vim-bookmarks.nvim")

	-- Project
	use("ahmedkhalf/project.nvim")
	use("windwp/nvim-spectre")
	-- Git
	use("lewis6991/gitsigns.nvim")
	use("mattn/webapi-vim")

  -- graveyard
	-- use("ghillb/cybu.nvim")-- cool buffers cycle; J interfers with old vim map
	-- use("folke/tokyonight.nvim") --colorschemes
	-- use("kshenoy/vim-signature") --view your marks


	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
