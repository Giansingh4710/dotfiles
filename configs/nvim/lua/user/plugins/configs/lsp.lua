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
          -- Setup lsp_signature on attach
          local lsp_signature = require("lsp_signature")
          lsp_signature.on_attach({}, event.buf)
        end,
      })

      local lspconfig = require("lspconfig")
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Swift LSP (sourcekit-lsp) setup using new vim.lsp.config API (Neovim 0.11+)
      -- Known issues: inlay hints cause timeouts, dynamic registration not fully supported
      -- vim.lsp.config.sourcekit = {
      --   cmd = { "sourcekit-lsp" },
      --   filetypes = { "swift" },
      --   root_markers = { "Package.swift", ".git", "buildServer.json" },
      --   capabilities = lsp_capabilities,
      --   settings = {
      --     sourcekit = {
      --       -- Disable background indexing which can cause slowdowns
      --       backgroundIndexing = false,
      --     },
      --   },
      -- }

      -- Setup autocmd to start sourcekit-lsp for Swift files
      -- vim.api.nvim_create_autocmd("FileType", {
      --   pattern = "swift",
      --   callback = function(args)
      --     vim.lsp.enable("sourcekit")
      --
      --     -- Disable inlay hints to prevent timeout issues (see: swiftlang/sourcekit-lsp#2021)
      --     vim.defer_fn(function()
      --       local clients = vim.lsp.get_clients({ bufnr = args.buf, name = "sourcekit" })
      --       for _, client in ipairs(clients) do
      --         if client.server_capabilities.inlayHintProvider then
      --           vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
      --         end
      --       end
      --     end, 100)
      --   end,
      -- })

      -- Reduce diagnostic update frequency to prevent slowdowns
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        update_in_insert = false, -- Don't update diagnostics while typing
        virtual_text = {
          spacing = 4,
          prefix = "●",
        },
      })

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
    "j-hui/fidget.nvim",
    opts = {},
  },
  -- {
  --   "wojciech-kulik/xcodebuild.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --     "MunifTanjim/nui.nvim",
  --     "nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
  --   },
  --   config = function()
  --     require("xcodebuild").setup({
  --       -- put some options here or leave it empty to use default settings
  --     })
  --   end,
  -- },
}
