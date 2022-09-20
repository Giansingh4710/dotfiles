local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("user.plugins.lsp.lsp-installer")
require("user.plugins.lsp.lsp-signature")
require("user.plugins.lsp.handlers").setup()
require("user.plugins.lsp.null-ls")
require("user.plugins.lsp.toggle")
require("py_lsp").setup({
    -- host_python = "bin/python3"
})
