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

  "rafi/awesome-vim-colorschemes",
  "bluz71/vim-nightfly-colors",
  "lunarvim/darkplus.nvim", -- vscode

  "nvim-telescope/telescope.nvim",
  "windwp/nvim-ts-autotag", --treesitter autotag
  "chentoast/marks.nvim",
  "folke/zen-mode.nvim",
  "stevearc/dressing.nvim",                     --cool looks
  "tamago324/lir.nvim",                         --file Explorer
  "nvim-lua/plenary.nvim",                      -- Useful lua functions used by lots of plugins
  "windwp/nvim-autopairs",                      -- Autopairs, integrates with both cmp and treesitter
  "JoosepAlviste/nvim-ts-context-commentstring", -- correct comments in html file where there is js,html,css
  "nvim-lualine/lualine.nvim",
  "akinsho/toggleterm.nvim",
  "lukas-reineke/indent-blankline.nvim",

  "hrsh7th/nvim-cmp",        -- The completion plugin
  "hrsh7th/cmp-buffer",      -- buffer completions
  "hrsh7th/cmp-path",        -- path completions
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  -- snippets
  "L3MON4D3/LuaSnip",            --snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
  { "numToStr/Comment.nvim", opts = {} },
  { "folke/which-key.nvim",  opts = {} },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
    opts = {},
  }, --show colors in css files stc

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
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
    "nvim-telescope/telescope-dap.nvim",
    "theHamsta/nvim-dap-virtual-text",
    "mfussenegger/nvim-dap-python",
  },

  {
    "glepnir/lspsaga.nvim", -- ui for lsp
    dependencies = { { "kyazdani42/nvim-web-devicons" }, { "nvim-treesitter/nvim-treesitter" } },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 500,
      background_colour = "#000000",
      max_height = function()
        return math.floor(vim.o.lines * 0.25)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.25)
      end,
    },
  },
}

require("lazy").setup(plugins)

-- vim.cmd.colorscheme("nightfly")
RandomColorScheme()

require("plugins.treesitter")
require("plugins.bufferline") --top tab line
require("plugins.marks")
require("plugins.telescope")
require("plugins.nvim-ts-autotag") --treesitter autotag vscode like tags
require("plugins.lualine")         --bottom line
require("plugins.toggleterm")
require("plugins.cmp")             -- completion

require("plugins.dressing")        -- makes things look nice like input
require("plugins.indentline")
require("plugins.lir")
require("plugins.autopairs")
require("plugins.zen-mode")
require("plugins.lspish")
