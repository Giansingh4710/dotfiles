local icons = require("user.icons")

return {
  {
    "rafi/awesome-vim-colorschemes",
    "bluz71/vim-nightfly-colors",
    "lunarvim/darkplus.nvim", -- vscode
  },
  {
    "RRethy/vim-illuminate", --highlight other words when on word
    enabled = true,
    config = function()
      require("illuminate").configure({
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        delay = 100,
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn" },
        symbols = { error = icons.diagnostics.Error, warn = icons.diagnostics.Warning },
        colored = true,
        update_in_insert = true,
        always_visible = true,
      }

      local filetype = {
        "filetype",
        icons_enabled = true,
        -- icon = nil
      }

      local branch = {
        "branch",
        icons_enabled = true,
        icon = "",
      }

      local filename = {
        "filename",
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
      }

      local lsp_server_name = function()
        local msg = icons.diagnostics.Error
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
        color = { fg = "#EC7E22", gui = "bold" },
      }

      require("lualine").setup({
        options = {
          icons_enabled = false,
          theme = "auto",
          component_separators = "|",
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "alpha", "dashboard", "toggleterm" },
          always_divide_middle = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { branch, diagnostics },
          lualine_c = { filename, filetype, lsp_server_info },
          lualine_x = { "encoding", "fileformat" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    opts = {
      options = {
        mode = "tabs",
        numbers = "ordinal", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        close_command = "bd", -- can be a string | function, see "Mouse actions"
        right_mouse_command = "bd", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        buffer_close_icon = icons.ui.Close,
        modified_icon = icons.ui.Modified,
        close_icon = icons.ui.CloseCircle,
        left_trunc_marker = icons.ui.LeftCircle,
        right_trunc_marker = icons.ui.RightCircle,
        max_name_length = 30,
        max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
        tab_size = 21,
        diagnostics = true, -- | "nvim_lsp" | "coc",
        diagnostics_update_in_insert = false,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = "slant",
        always_show_bufferline = true,
      },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Blue or blue
        RRGGBBAA = false,
        AARRGGBB = false,
        rgb_fn = false,
        hsl_fn = false,
        css = false,
        css_fn = false,
        mode = "background", -- Set the display mode. Available modes for `mode`: foreground, background,  virtualtext
        -- Available methods are false / true / "normal" / "lsp" / "both"
        tailwind = true,
        -- parsers can contain values used in |user_default_options|
        sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
        virtualtext = "■",
        -- update color values even if buffer is not focused
        -- example use: cmp_menu, cmp_docs
        always_update = false,
      },
    },
  },
  {
    "folke/twilight.nvim",
    opts = {},
  },
}
