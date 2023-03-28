--[[ uses cmp_nvim_lsp, illuminate, notify ]]
local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = require("cmp_nvim_lsp").default_capabilities(M.capabilities)

require("toggle_lsp_diagnostics").init({
	underline = false,
	virtual_text = { prefix = "XXX", spacing = 5 },
})

local function lsp_keymaps(bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { noremap = true, silent = true, buffer = bufnr, desc = desc })
	end

	nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Info")
	nmap("[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Previous Diagnostic")
	nmap("]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic")
	nmap("<leader>ca", "<cmd>Lspsaga code_action<CR>", "Code Action")
	nmap("<leader>o", "<cmd>Lspsaga outline<CR>", "Toggle Outile")

  nmap("gD","<cmd>Lspsaga lsp_finder<CR>","Show Definition and References" )
  nmap("gR","<cmd>lua vim.lsp.buf.references()<CR>","Quickfix list References" )
  nmap("gi","<cmd>lua vim.lsp.buf.implementation()<CR>","Go to implementation" )
  nmap("gr","<cmd>Telescope lsp_references<CR>","Telescope References" )
  nmap("gd","<cmd>lua vim.lsp.buf.definition()<CR>","Go to Definition" )
  nmap("gl","<cmd>lua vim.diagnostic.open_float()<CR>","Show Line diagnostics" )
  -- nmap("gd","<cmd>Lspsaga goto_definition<CR>","Go to Definition" )
  -- nmap("gl","<cmd>Lspsaga show_line_diagnostics<CR>","Show Line diagnostics" )

  nmap("<leader>lf","<cmd>lua vim.lsp.buf.format()<CR>","Format" )
  nmap("<leader>li","<cmd>LspInfo<cr>","Info" )
  nmap("<leader>lI","<cmd>Mason<cr>","Mason Info" )
  nmap("<leader>la","<cmd>lua vim.lsp.buf.code_action()<cr>","Code Action" )
  nmap("<leader>lj","<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>","Next diagnostic" )
  nmap("<leader>lk","<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>","Previous diagnostic" )
  nmap("<leader>lr","<cmd>lua vim.lsp.buf.rename()<cr>","Rename" )
  nmap("<leader>lq","<cmd>lua vim.diagnostic.setloclist()<CR>","Diagnostic Quickfix" )
  nmap("<leader>ls","<cmd>lua vim.lsp.buf.signature_help()<CR>","Signature help" )
  nmap("<leader>lS","<cmd>Telescope lsp_dynamic_workspace_symbols<cr>","Workspace Symbols" )
  nmap("<leader>lt","<cmd>ToggleDiag<cr>","Toggle Diagnostics" )

	--[[ nmap("<leader>rn", "<cmd>Lspsaga rename<CR>", "Lspsaga Rename") ]]
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

M.on_attach = function(client, bufnr)
	print(client.name .. " lsp attached")
	lsp_keymaps(bufnr)
	require("illuminate").on_attach(client)
end

return M
