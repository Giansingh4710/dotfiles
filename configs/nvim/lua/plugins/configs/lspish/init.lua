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
  "jdtls"
}

require("plugins.configs.lspish.handler").setup()
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = servers, automatic_installation = true })

local lspconfig = require("lspconfig")
local on_attach = require("plugins.configs.lspish.handler").on_attach
local capabilities = require("plugins.configs.lspish.handler").capabilities

for _, server in pairs(servers) do
  lspconfig[server].setup({ capabilities = capabilities, on_attach = on_attach })
end

lspconfig["tsserver"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  commands = {
    OrganizeImports = {
      function()
        vim.lsp.buf.execute_command({
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = "Organize Imports"
        })
      end,
      description = "Organize Imports",
    },
  },
})

lspconfig["lua_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } }, -- make the language server recognize "vim" global
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})

capabilities.offsetEncoding = { "utf-16" } -- for clangd to remove error
lspconfig["clangd"].setup({ capabilities = capabilities })

require("plugins.configs.lspish.null_ls")

require("lspsaga").setup({
  scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" }, -- keybinds for navigation in lspsaga window
  definition = { edit = "<CR>" },                                  -- use enter to open file with definition preview
  ui = {
    colors = {
      normal_bg = "#022746",
    },
  },
})

