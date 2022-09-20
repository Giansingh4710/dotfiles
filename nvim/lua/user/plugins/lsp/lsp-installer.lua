-- require("nvim-lsp-installer").setup({
--     automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
--     ui = {
--         icons = {
--             server_installed = "✓",
--             server_pending = "➜",
--             server_uninstalled = "✗"
--         }
--     }
-- })

local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = {
  "html",
  "tsserver",
  "cssls",
  "pyright",
  "jsonls",
  "bashls",
  "sumneko_lua",
  "yamlls",
}

lsp_installer.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.plugins.lsp.handlers").on_attach,
    capabilities = require("user.plugins.lsp.handlers").capabilities,
  }

	if server == "jsonls" then
		local jsonls_opts = require("user.plugins.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	if server == "sumneko_lua" then
		local sumneko_opts = require("user.plugins.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server == "pyright" then
		local pyright_opts = require("user.plugins.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	if server == "solang" then
		local solang_opts = require("user.plugins.lsp.settings.solang")
		opts = vim.tbl_deep_extend("force", solang_opts, opts)
	end

	if server == "solc" then
		local solc_opts = require("user.plugins.lsp.settings.solc")
		opts = vim.tbl_deep_extend("force", solc_opts, opts)
	end

	if server == "emmet_ls" then
		local emmet_ls_opts = require("user.plugins.lsp.settings.emmet_ls")
		opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
	end

	lspconfig[server].setup(opts)
end

