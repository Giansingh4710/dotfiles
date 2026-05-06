local function oil_files_to_quickfix()
  if vim.bo.filetype ~= "oil" then
    return
  end
  local oil = require("oil")
  local dir = oil.get_current_dir()

  local entries = {}
  for i = 1, vim.fn.line("$") do
    local entry = oil.get_entry_on_line(0, i)
    if entry and entry.type == "file" then
      table.insert(entries, { filename = dir .. entry.name })
    end
  end
  if #entries == 0 then
    return
  end

  vim.fn.setqflist(entries)
  return vim.cmd.copen()
end

return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- file explorers
  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = true,
      hijack_netrw = true,
      restore_win_options = true,
      view_options = {
        show_hidden = true,
      },
      delete_to_trash = true,
      keymaps = {
        ["<C-q>"] = oil_files_to_quickfix,
      },
    },
    dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
  },
  {
    "simonmclean/triptych.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-tree/nvim-web-devicons", -- optional for icons
      "antosha417/nvim-lsp-file-operations", -- optional LSP integration
    },
    opts = {}, -- config options here
    keys = {
      { "<leader>-", ":Triptych<CR>" },
    },
  },
}
