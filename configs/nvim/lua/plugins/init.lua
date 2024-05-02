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
  "tamago324/lir.nvim", --file Explorer
  "stevearc/oil.nvim", --file Explorer

  "rafi/awesome-vim-colorschemes",
  "bluz71/vim-nightfly-colors",
  "lunarvim/darkplus.nvim", -- vscode

  "nvim-telescope/telescope.nvim",
  "windwp/nvim-ts-autotag", --treesitter autotag
  "chentoast/marks.nvim",
  "folke/zen-mode.nvim",
  "stevearc/dressing.nvim",                     --cool looks
  "nvim-lua/plenary.nvim",                      -- Useful lua functions used by lots of plugins
  "windwp/nvim-autopairs",                      -- Autopairs, integrates with both cmp and treesitter
  "JoosepAlviste/nvim-ts-context-commentstring", -- correct comments in html file where there is js,html,css
  "nvim-lualine/lualine.nvim",
  "akinsho/toggleterm.nvim",

  "hrsh7th/nvim-cmp",        -- The completion plugin
  "hrsh7th/cmp-buffer",      -- buffer completions
  "hrsh7th/cmp-path",        -- path completions
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  { "lukas-reineke/indent-blankline.nvim", main = "ibl" },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    version = "v1.*",            -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  },
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
  { "folke/which-key.nvim",                opts = {} },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        pre_hook = function()
          return vim.bo.commentstring
        end,
      })
    end,
    opts = {},
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
    opts = {},
  }, --show colors in css files stc
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
  },

  -- { "tpope/vim-fugitive", opt = {} },
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
  {
    "akinsho/bufferline.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      pcall(require("nvim-treesitter.install").update({ with_sync = true }))
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "folke/neodev.nvim", opts = {} }, -- Additional lua configuration, makes nvim stuff amazing!
      { "j-hui/fidget.nvim", opts = {} }, -- Useful status updates for LSP
    },
  },

  -- LSP
  "jayp0521/mason-null-ls.nvim",                -- bridges gap b/w mason & null-ls
  "jose-elias-alvarez/null-ls.nvim",            -- for formatters and linters
  "RRethy/vim-illuminate",                      --highlight other words when on word
  "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim", -- toggle diagnostic
  "ray-x/lsp_signature.nvim",                   --show func def when typing
  "mfussenegger/nvim-jdtls",                    --java lsp

  {
    "glepnir/lspsaga.nvim", -- ui for lsp
    dependencies = { { "kyazdani42/nvim-web-devicons" }, { "nvim-treesitter/nvim-treesitter" } },
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    opts = {
      global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        excluded_filetypes = { "harpoon" },
        mark_branch = true, -- set marks specific to each git branch inside git repository
        tabline = false, -- enable tabline with harpoon marks
        tabline_prefix = "   ",
        tabline_suffix = "   ",
      },
    },
  },
}

require("lazy").setup(plugins)

require("plugins.configs.treesitter")
require("plugins.configs.bufferline") --top tab line
require("plugins.configs.marks")
require("plugins.configs.telescope")
require("plugins.configs.nvim-ts-autotag") --treesitter autotag vscode like tags
require("plugins.configs.lualine")         --bottom line
require("plugins.configs.toggleterm")
require("plugins.configs.cmp")             -- completion

require("plugins.configs.dressing")        -- makes things look nice like input
require("plugins.configs.indentline")
require("plugins.configs.lir")
require("plugins.configs.autopairs")
require("plugins.configs.zen-mode")
require("plugins.configs.lspish")
require("plugins.configs.oil")
