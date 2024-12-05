vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
  callback = function(event)
    -- put keymaps here in ../../../user/keymaps.lua

    -- local opts = {buffer = event.buf}
    -- vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    -- vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    -- vim.keymap.set('n', '<leader>lws', function() vim.lsp.buf.workspace_symbol() end, opts)
    -- vim.keymap.set('n', '<leader>ld', function() vim.diagnostic.open_float() end, opts)
    -- vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
    -- vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
    -- vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
    -- vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
    -- vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
    -- vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
  end,
})

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    --[[ https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md ]]
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
    "gopls", -- go
  },

  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = lsp_capabilities,
      })
    end,
    lua_ls = function()
      require("lspconfig").lua_ls.setup({
        capabilities = lsp_capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
              },
            },
          },
        },
      })
    end,
    ts_ls = function()
      require("lspconfig").ts_ls.setup({
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
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })
    end,
    clangd = function()
      lsp_capabilities.offsetEncoding = { "utf-16" } -- for clangd to remove error
      require("lspconfig").clangd.setup({
        capabilities = lsp_capabilities,
      })
    end,
  },
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  sources = {
    { name = "path" },
    { name = "nvim_lsp" },
    { name = "luasnip", keyword_length = 2 },
    { name = "buffer", keyword_length = 3 },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
})

require("toggle_lsp_diagnostics").init()
