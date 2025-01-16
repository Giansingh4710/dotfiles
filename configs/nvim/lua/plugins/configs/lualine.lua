-- inspired by https://github.com/benfrain/neovim/blob/main/lua/setup/lualine.lua

return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local function show_macro_recording()
        local recording_register = vim.fn.reg_recording()
        if recording_register == "" then
          return ""
        else
          return "󰑋  " .. recording_register
        end
      end

      local lsp_server_name = function()
        local msg = " "
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end

        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if client.name ~= "null-ls" and filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end

      local lsp_server_info = {
        lsp_server_name,
        icon = " LSP:",
        color = { gui = "bold" },
      }

      local macro = {
        show_macro_recording,
        color = { fg = "#333333", bg = "#ff6666" },
        separator = { left = "", right = "" },
      }

      local filename = {
        "filename",
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
      }

      require("lualine").setup({
        options = {
          -- icons_enabled = false,
          -- theme = "auto",
          -- disabled_filetypes = { "alpha", "dashboard", "toggleterm" },
          -- always_divide_middle = true,

          icons_enabled = true,
          theme = "auto",
          component_separators = "",
          -- section_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {},
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diagnostics", "diff", "selectioncount" },
          lualine_c = { "%=", filename, macro },
          lualine_x = { lsp_server_info, "filetype" },
          lualine_y = { "fileformat", "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },
}
