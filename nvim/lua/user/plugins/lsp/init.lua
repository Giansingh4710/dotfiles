local servers = {
  --[[ https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md ]]
  "bashls",
  "clangd",
  "lua_ls",
  "pyright",
  "emmet_ls",
  "html",
  "phpactor",
  "tsserver",
}

require("user.plugins.lsp.handler").setup()
require("mason").setup()
require("mason-lspconfig").setup({ensure_installed = servers ,automatic_installation = true})

local lspconfig = require("lspconfig")
local on_attach = require("user.plugins.lsp.handler").on_attach
local capabilities = require("user.plugins.lsp.handler").capabilities

for _, server in pairs(servers) do
  lspconfig[server].setup({capabilities = capabilities,on_attach = on_attach,})
end

lspconfig["emmet_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

lspconfig["lua_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = { -- custom settings for lua
    Lua = {
      diagnostics = {globals = { "vim" }},-- make the language server recognize "vim" global
      workspace = { -- make language server aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})

require("toggle_lsp_diagnostics").init({
  underline = false,
  virtual_text = { prefix = "XXX", spacing = 5 },
})
require("user.plugins.lsp.null_ls")
require("lspsaga").setup({
  scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },-- keybinds for navigation in lspsaga window
  definition = {edit = "<CR>"}, -- use enter to open file with definition preview
  ui = {
    colors = {
      normal_bg = "#022746",
    },
  },
})
