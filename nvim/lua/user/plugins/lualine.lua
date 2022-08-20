local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local icons = require "user.plugins.icons"

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error =  " ", warn =  " "},
    colored = true,
    update_in_insert = true,
    always_visible = true,
}

local diff = {
    "diff",
    colored = false,
    symbols = { added = " ", modified = " ", removed = " ", }, -- changes diff symbols
    cond = hide_in_width,
}

local mode = {
    "mode",
    fmt = function(str)
    return "-- " .. str .. " --"
    end,
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

local location = {
    "location",
    padding = 0,
}

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    -- component_separators = { left = "", right = "" },
    -- section_separators = { left = "", right = "" },
    -- disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "toggleterm" },
    disabled_filetypes = { "alpha", "dashboard", "toggleterm" },
    always_divide_middle = true,
  },
  sections = {
    -- lualine_a = { branch, diagnostics },
    lualine_a = { branch },
    lualine_b = { diagnostics },
    lualine_c = {{
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
    }},
    lualine_x = { diff,"encoding", "fileformat", filetype },
    -- lualine_x = { diff, --[[ spaces ,]] "encoding", filetype },
    lualine_y = { location },
    lualine_z = { "progress" },
  },
  -- sections = {
  --       lualine_a = {'mode'},
  --       lualine_b = {'branch', 'diff', 'diagnostics'},
  --       lualine_c = {{
  --           'filename',
  --           file_status = true, -- displays file status (readonly status, modified status)
  --           path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
  --       }},
  --       lualine_x = {'encoding', 'fileformat', 'filetype'},
  --       lualine_y = {'progress'},
  --       lualine_z = {'location'}
  --   },
}

--[[ lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {"branch"},
    lualine_c = { diagnostics },
    lualine_x = { diff, spaces, "encoding", filetype },
    lualine_y = { location },
    lualine_z = { "progress" },
  },
} ]]





