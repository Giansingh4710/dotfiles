local null_ls = require("null-ls")

null_ls.setup({
  --[[ debug = false, ]]
  sources = {
    -- null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.shellcheck, --sudo apt install shellcheck
    null_ls.builtins.diagnostics.tidy, -- Tidy corrects and cleans up HTML and XML file 

    null_ls.builtins.completion.spell,

    null_ls.builtins.formatting.autoflake, -- removes Unused in py files
    null_ls.builtins.formatting.autopep8, -- py formatting
    null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),

    null_ls.builtins.formatting.beautysh, -- bash beauty

    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.shfmt, --go install mvdan.cc/sh/v3/cmd/shfmt@latest
    null_ls.builtins.formatting.google_java_format,

    null_ls.builtins.formatting.codespell, -- miss spellings

    null_ls.builtins.formatting.fixjson,
    null_ls.builtins.formatting.deno_fmt, -- js/react stuff
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.prettier.with({
      extra_filetypes = { "toml" },
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    }),
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
