--[[ uses cmp_nvim_lsp, illuminate, notify ]]
local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = require("cmp_nvim_lsp").default_capabilities(M.capabilities)

require("toggle_lsp_diagnostics").init({
  underline = false,
  virtual_text = { prefix = "XXX", spacing = 5 },
})

local which_key = require("which-key")
local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	local keymap = vim.keymap -- for conciseness
	keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts) -- see outline on right hand side

	local g_mappingsNormMode = {
		D = { "<cmd>Lspsaga lsp_finder<CR>", "Show Definition and References (LSP)" }, -- show definition, references
		R = { "<cmd>lua vim.lsp.buf.references()<CR>", "Quickfix list References (LSP)" },
		d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to Definition (LSP)" }, -- see definition and make edits in window
		--[[ d = { "<cmd>Lspsaga goto_definition<CR>", "Go to Definition (LSP)" }, -- see definition and make edits in window ]]
		i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation (LSP)" }, -- go to implementation
		l = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Show Line diagnostics (LSP)"},
		r = { "<cmd>Telescope lsp_references<CR>", "Telescope References (LSP)" },
		--[[ l = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show Line diagnostics (LSP)" }, -- show  diagnostics for line ]]
		--[[ keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration ]]
		--[[ keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) ]]
	}
	which_key.register(g_mappingsNormMode, {
		mode = "n",
		prefix = "g",
		buffer = bufnr,
		silent = false,
		noremap = true,
		nowait = true,
	})

	local l_mappingsNormMode = {
		f = { "<cmd>lua vim.lsp.buf.format()<CR>", "Format (LSP)" },
		i = { "<cmd>LspInfo<cr>", "Info (LSP)" },
		I = { "<cmd>Mason<cr>", "Mason Info (LSP)" },
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action (LSP)" },
		j = { "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", "Next diagnostic (LSP)" },
		k = { "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", "Previous diagnostic (LSP)" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename (LSP)" },
		q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Diagnostic Quickfix (LSP)" },
		s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help (LSP)" },
		S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
		t = { "<cmd>ToggleDiag<cr>", "Toggle Diagnostics" },
	}
	which_key.register(l_mappingsNormMode, {
		mode = "n",
		prefix = "<leader>l",
		buffer = bufnr,
		silent = false,
		noremap = true,
		nowait = true,
	})
end

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = true, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

--[[ local notify = require("notify") -- .setup({background_colour = "#000000"}) ]]
M.on_attach = function(client, bufnr)
	print(client.name .. " lsp server is attached")
	lsp_keymaps(bufnr)
	require("illuminate").on_attach(client)
end

return M
