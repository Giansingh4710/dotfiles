local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	-- ensure_installed = "all",
	ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "tsx", "typescript", "help", "vim" },
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
