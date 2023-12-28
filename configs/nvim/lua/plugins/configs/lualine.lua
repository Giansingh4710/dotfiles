local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local icons = require("user.icons")

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = icons.diagnostics.Error, warn = icons.diagnostics.Warning },
	colored = true,
	update_in_insert = true,
	always_visible = true,
}

local diff = {
	"diff",
	colored = true,
	symbols = {
		added = icons.diagnostics.Added,
		modified = icons.diagnostics.Modified,
		removed = icons.diagnostics.Removed,
	}, -- changes diff symbols
	cond = hide_in_width,
}

local mode = {
	"mode",
	fmt = function(str)
		--[[ return "-- " .. str .. " --" ]]
		return str
	end,
}

local filetype = {
	"filetype",
	icons_enabled = true,
	-- icon = nil
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
	padding = 0,
}

local filename = {
	"filename",
	file_status = true, -- displays file status (readonly status, modified status)
	path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
}

local lsp_server_name = function()
	local msg = icons.diagnostics.Error
	local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
	local clients = vim.lsp.get_active_clients()
	if next(clients) == nil then
		return msg
	end

	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if client.name ~= "null-ls" and filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			return client.name
		end
	end
	return msg
end

local lsp_server_info = {
	lsp_server_name,
	icon = " LSP:",
	color = { fg = "#EC7E22", gui = "bold" },
}

local config = {
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = "auto",
		-- component_separators = { left = "", right = "" },
		-- section_separators = { left = "", right = "" },
		component_separators = "|",
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "toggleterm" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { branch, filename },
		lualine_b = { diagnostics },
		lualine_c = { filetype, diff },
		lualine_x = {
			lsp_server_info,
			"filesize",
			"encoding",
			"fileformat",
		},
		-- lualine_x = { "progress", spaces , "encoding", filetype },
		lualine_y = { location },
		lualine_z = { "mode" },
	},
}

lualine.setup(config)
