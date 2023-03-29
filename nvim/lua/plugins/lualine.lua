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
	colored = false,
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

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local get_servers = function()
	local clients = vim.lsp.get_active_clients()
	if #clients == 0 then
		return
	end

	local servers = "["
	for _, client in ipairs(clients) do
		if client.name == "null-ls" then
		else
			servers = servers .. client.name .. ","
		end
	end

	local servers = string.sub(servers, 1, -2) -- extract substring from index 1 to second-last character
	local servers = servers .. "]"

	return servers
end

local lsp_server_name = function()
	local msg = "No Active Lsp"
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

local config = {
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "toggleterm" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { branch, diagnostics },
		lualine_c = {
			{
				"filename",
				file_status = true, -- displays file status (readonly status, modified status)
				path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
			},
		},
		lualine_x = {
			{
				lsp_server_name,
				icon = " LSP:",
				color = { fg = "#C7988B", gui = "bold" },
			},
			"encoding",
			"fileformat",
			filetype,
		},
		-- lualine_x = { diff, spaces , "encoding", filetype },
		lualine_y = { location },
		lualine_z = { "progress" },
	},
}

lualine.setup(config)
