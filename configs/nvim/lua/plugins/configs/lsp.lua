return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "nvimdev/lspsaga.nvim",
        config = function()
          require("lspsaga").setup({})
        end,
        dependencies = {
          "nvim-treesitter/nvim-treesitter", -- optional
          "nvim-tree/nvim-web-devicons", -- optional
        },
      },
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

      local lspconfig = require("lspconfig")
      lspconfig.sourcekit.setup({
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
      }) -- for swift

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
            lspconfig[server_name].setup({
              capabilities = lsp_capabilities,
            })
            lsp_signature.on_attach()
          end,
          lua_ls = function()
            lspconfig.lua_ls.setup({
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
            lspconfig.ts_ls.setup({
              root_dir = lspconfig.util.root_pattern("package.json"),
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
            lspconfig.gopls.setup({
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
            lspconfig.clangd.setup({
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
  {
    "wojciech-kulik/xcodebuild.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
    },
    config = function()
      require("xcodebuild").setup({
        -- put some options here or leave it empty to use default settings
      })
    end,
  },
}
