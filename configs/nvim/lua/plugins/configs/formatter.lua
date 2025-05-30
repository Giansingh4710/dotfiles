return {
  {
    "mhartington/formatter.nvim",
    config = function()
      local util = require("formatter.util")

      require("formatter").setup({
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = {
          lua = {
            require("formatter.filetypes.lua").stylua,
            function()
              if util.get_current_buffer_file_name() == "special.lua" then
                return nil
              end
              return {
                exe = "stylua",
                args = {
                  "--indent-type",
                  "Spaces",
                  "--indent-width",
                  vim.opt.shiftwidth:get(),
                  "--search-parent-directories",
                  "--stdin-filepath",
                  util.escape_path(util.get_current_buffer_file_path()),
                  "--",
                  "-",
                },
                stdin = true,
              }
            end,
          },
          json = {
            function()
              return {
                exe = "jq",
                args = { "--indent", "2", "." },
                stdin = true,
              }
            end,
          },
          javascriptreact = {
            function()
              return {
                exe = "prettier",
                args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
                stdin = true,
              }
            end,
          },
          typescriptreact = {
            function()
              return {
                exe = "prettier",
                args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
                stdin = true,
              }
            end,
          },
          typescript = {
            function()
              return {
                exe = "prettier",
                args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
                stdin = true,
              }
            end,
          },
          javascript = {
            function()
              return {
                exe = "prettier",
                args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
                stdin = true,
              }
            end,
          },
          python = {
            function()
              return {
                exe = "black",
                args = { "-" },
                -- args = { "--line-length 200" },
                stdin = true,
              }
            end,
          },
          html = {
            function()
              return {
                exe = "prettier",
                args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
                stdin = true,
              }
            end,
          },
          go = {
            function()
              return {
                exe = "gofmt",
                stdin = true,
              }
            end,
          },
          sh = {
            function()
              return {
                exe = "shfmt",
                args = { "-i", vim.opt.shiftwidth:get(), vim.api.nvim_buf_get_name(0) },
                stdin = true,
              }
              -- return {
              --   exe = "beautysh",
              --   args = { "--indent-size", vim.opt.shiftwidth:get(), vim.api.nvim_buf_get_name(0) },
              --   stdin = false, -- beautysh does not support stdin
              -- }
            end,
          },
          dart = {
            function()
              return {
                exe = "dart format",
                stdin = true,
              }
            end,
          },
          swift = {
            function()
              return {
                exe = "swiftformat",
                stdin = true,
              }
            end,
          },
          php = {
            function()
              return {
                exe = "php-cs-fixer",
                args = { "fix", "$FILENAME" },
                stdin = false,
              }
            end,
          },
          ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace,
          },
        },
      })
    end,
  },
}
