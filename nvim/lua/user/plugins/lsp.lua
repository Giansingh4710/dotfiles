local servers = {
  "bashls",
  "clangd",
  "lua_ls",
  "pyright",
  "emmet_ls",
  --[[ "schemastore", --json ]]
}

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
})

local lspconfig = require("lspconfig")
require("user.plugins.lsp_handler").setup()
for _, server in pairs(servers) do
  local opts = {
    on_attach = require("user.plugins.lsp_handler").on_attach,
    capabilities = require("user.plugins.lsp_handler").capabilities,
    --[[ local capabilities = require("cmp_nvim_lsp").default_capabilities() ]]
  }
  lspconfig[server].setup(opts)
end

--[[ NULL_LS ]]
local null_ls = require("null-ls")
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- https://github.com/prettier-solidity/prettier-plugin-solidity
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier.with({
      extra_filetypes = { "toml" },
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    }),
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.stylua,
    formatting.prettier,
    formatting.shfmt, --go install mvdan.cc/sh/v3/cmd/shfmt@latest
    formatting.google_java_format,
    --[[ diagnostics.eslint, ]]
    diagnostics.shellcheck, --sudo apt install shellcheck
  },
})

require("toggle_lsp_diagnostics").init({
  underline = false,
  virtual_text = { prefix = "XXX", spacing = 5 },
})

