return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
    opts = {
      check_ts = true, -- treesitter integration
      disable_filetype = { "TelescopePrompt" },
      disable_in_macro = false, -- disable when recording or executing a macro
      disable_in_visualblock = false, -- disable when insert after visual block mode
    },
  },
  {
    -- needs treesitter to work
    "windwp/nvim-ts-autotag",
    config = true,
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = false,
  },
}
