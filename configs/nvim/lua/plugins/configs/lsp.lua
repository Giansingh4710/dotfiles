return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "ray-x/lsp_signature.nvim",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
        callback = function(event)
          -- Keymaps moved to keymaps.lua
        end,
      })

      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lsp_signature = require("lsp_signature")

      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = {
          "emmet_ls",
          "html",
          "ts_ls",
          "tailwindcss",
          "bashls",
          "clangd",
          "lua_ls",
          "pyright",
          "phpactor",
          "kotlin_language_server",
          "gopls",
        },

        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = lsp_capabilities,
            })
            lsp_signature.on_attach()
          end,
          lua_ls = function()
            require("lspconfig").lua_ls.setup({
              capabilities = lsp_capabilities,
              settings = {
                Lua = {
                  runtime = { version = "LuaJIT" },
                  diagnostics = { globals = { "vim" } },
                  workspace = { library = { vim.env.VIMRUNTIME } },
                },
              },
            })
          end,
          ts_ls = function()
            require("lspconfig").ts_ls.setup({
              root_dir = require("lspconfig").util.root_pattern("package.json"),
              single_file = false,
              server_capabilities = {
                documentFormattingProvider = false,
              },

              capabilities = lsp_capabilities,
              commands = {
                OrganizeImports = {
                  function()
                    vim.lsp.buf.execute_command({
                      command = "_typescript.organizeImports",
                      arguments = { vim.api.nvim_buf_get_name(0) },
                      title = "Organize Imports",
                    })
                  end,
                  description = "Organize Imports",
                },
              },
            })
          end,
          gopls = function()
            require("lspconfig").gopls.setup({
              capabilities = lsp_capabilities,
              settings = {
                gopls = {
                  analyses = { unusedparams = true },
                  staticcheck = true,
                  gofumpt = true,
                },
              },
            })
          end,
          clangd = function()
            lsp_capabilities.offsetEncoding = { "utf-16" }
            require("lspconfig").clangd.setup({
              capabilities = lsp_capabilities,
            })
          end,
        },
      })
    end,
  },
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
  },
}
