require("Comment").setup({
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

  padding = true, ---Add a space b/w comment and the line
  sticky = true, ---Whether the cursor should stay at its position
  ignore = "^$", ---Lines to be ignored while (un)comment
  toggler = { ---LHS of toggle mappings in NORMAL mode
    line = "gcc", ---Line-comment toggle keymap
    block = "gbc", ---Block-comment toggle keymap
  },
  opleader = { ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    line = "gc", ---Line-comment keymap
    block = "gb", ---Block-comment keymap
  },
  extra = { ---LHS of extra mappings
    above = "gcO", ---Add comment on the line above
    below = "gco", ---Add comment on the line below
    eol = "gcA", ---Add comment at the end of line
  },

  ---Enable keybindings
  mappings = { ---NOTE: If given `false` then the plugin won't create any mappings
    basic = true, ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
    extra = true, ---Extra mapping; `gco`, `gcO`, `gcA`
  },
  post_hook = nil, ---Function to call after (un)comment
})
