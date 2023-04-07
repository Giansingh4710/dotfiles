local configs = require("nvim-treesitter.configs")

configs.setup({
	-- ensure_installed = "all",
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"css",
		"html",
		"java",
		"javascript",
		"json",
		"lua",
		"php",
		"python",
		"regex",
		"sql",
		"tsx",
		"vim",
		"vimdoc",
	},
	indent = { enable = true, disable = { "python" } },
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "css" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	auto_install = false,
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-s>",
			node_incremental = "<c-s>",
			-- scope_incremental = '<c-s>',
			node_decremental = "<c-d>",
		},
	},
})
