local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  "github/copilot.vim",
  "tpope/vim-surround",
  "christoomey/vim-tmux-navigator",
  "preservim/nerdtree",
  "stevearc/oil.nvim", -- file Explorer

  -- Colorschemes
  "rafi/awesome-vim-colorschemes",
  "bluz71/vim-nightfly-colors",
  "lunarvim/darkplus.nvim", -- vscode

  "nvim-telescope/telescope.nvim",
  "folke/zen-mode.nvim",
  "nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
  "nvim-lualine/lualine.nvim", -- bottom line
  "akinsho/toggleterm.nvim",

  -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
  { "stevearc/dressing.nvim", opt = {} }, -- cool looks like inputing
  { "folke/which-key.nvim", opts = {} },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl" },
  {
    "numToStr/Comment.nvim",
    opts = {
      padding = true,
      sticky = true,
      mappings = false, -- no default mappings like gcc
    },
    lazy = false,
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
  }, -- show colors in css files stc
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
  },

  -- GIT
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
  },
  {
    "lewis6991/gitsigns.nvim", -- Adds git related signs to the gutter, as well as utilities for managing changes
    opts = {
      signs = {
        add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
        change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
        delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
        topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
        changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
        untracked = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      },
      current_line_blame = true,
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      pcall(require("nvim-treesitter.install").update({ with_sync = true }))
    end,
  },
  "windwp/nvim-ts-autotag", --treesitter autotag
  "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
  { "JoosepAlviste/nvim-ts-context-commentstring", opts = {} }, -- correct comments in html file where there is js,html,css using treesitter

  -- Autocomplete
  "hrsh7th/nvim-cmp", -- The completion plugin
  "hrsh7th/cmp-buffer", -- buffer completions
  "hrsh7th/cmp-path", -- path completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  "mhartington/formatter.nvim",

  -- LSP
  { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",
  "RRethy/vim-illuminate", --highlight other words when on word
  "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim", -- toggle diagnostic
  "ray-x/lsp_signature.nvim", -- show func def when typing
  { "folke/neodev.nvim", opts = {} }, -- Additional lua configuration, makes nvim stuff amazing!
  { "j-hui/fidget.nvim", opts = {} }, -- Useful status updates for LSP
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

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}

require("lazy").setup(plugins)

require("plugins.configs.treesitter")
require("plugins.configs.bufferline") -- top tab line
require("plugins.configs.telescope")
require("plugins.configs.nvim-ts-autotag") --treesitter autotag vscode like tags
require("plugins.configs.lualine") --bottom line
require("plugins.configs.toggleterm")
require("plugins.configs.cmp") -- completion

require("plugins.configs.indentline")
require("plugins.configs.autopairs")
require("plugins.configs.zen-mode")
require("plugins.configs.oil")
require("plugins.configs.formatter")
require("plugins.configs.illuminate")

require("plugins.configs.harpoon")
require("plugins.configs.lspish")
