local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  --[[ debug = false, ]]
  sources = {
    formatting.prettier.with({
      extra_filetypes = { "toml" },
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    }),
    --[[ null_ls.builtins.diagnostics.eslint, ]]
    null_ls.builtins.completion.spell,
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.stylua,
    formatting.clang_format,
    formatting.shfmt, --go install mvdan.cc/sh/v3/cmd/shfmt@latest
    formatting.google_java_format,
    diagnostics.shellcheck, --sudo apt install shellcheck
  },
})

local mason_null_ls = require("mason-null-ls")
mason_null_ls.setup({
  ensure_installed = {
    -- list of formatters & linters for mason to install
    "prettier", -- ts/js formatter
    "stylua", -- lua formatter
    "black", -- python
  },
  automatic_installation = true,
})
