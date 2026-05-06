return {
 { "hrsh7th/cmp-buffer" },
 { "hrsh7th/cmp-path" },
 { "hrsh7th/cmp-nvim-lsp" },
 { "hrsh7th/cmp-nvim-lua" },
 {
   "hrsh7th/nvim-cmp",
   dependencies = {
     "L3MON4D3/LuaSnip",
     "rafamadriz/friendly-snippets",
   },
   config = function()
     local cmp = require("cmp")
     local luasnip = require("luasnip")
     require("luasnip/loaders/from_vscode").lazy_load()

     -- vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "#33ffB9", italic = true })
     -- vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#FF3333", italic = true })
     -- vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#77EEF5" })
     -- vim.api.nvim_set_hl(0, "CmpItemKind", { fg = "#FFC300" })

     cmp.setup({
       completion = {
         completeopt = "menu,menuone",
       },
       window = {
         completion = cmp.config.window.bordered(),
         documentation = cmp.config.window.bordered(),
       },
       snippet = {
         expand = function(args)
           luasnip.lsp_expand(args.body)
         end,
       },
       formatting = {
         fields = { "menu", "abbr", "kind" },
         format = function(entry, vim_item)
           -- local icons = require("user.icons").kind
           local kind = vim_item.kind
           -- vim_item.kind = icons[kind] .. "  " .. kind
           vim_item.menu = ({
             nvim_lsp = "[LSP]",
             nvim_lua = "[Lua]",
             luasnip = "[Snip]",
             buffer = "[Buff]",
             path = "[Path]",
           })[entry.source.name]
           return vim_item
         end,
       },
       mapping = cmp.mapping.preset.insert({
         ["<C-k>"] = cmp.mapping.select_prev_item(),
         ["<C-j>"] = cmp.mapping.select_next_item(),
         ["<C-h>"] = cmp.mapping.select_prev_item(),
         ["<C-l>"] = cmp.mapping.select_next_item(),
         ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
         ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
         ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
         ["<C-e>"] = cmp.mapping({
           i = cmp.mapping.abort(),
           c = cmp.mapping.close(),
         }),
         ["<CR>"] = cmp.mapping.confirm({ select = true }),
       }),
       sources = {
         { name = "nvim_lsp" },
         { name = "nvim_lua" },
         { name = "luasnip" },
         { name = "buffer" },
         { name = "path" },
       },
       confirm_opts = {
         behavior = cmp.ConfirmBehavior.Replace,
         select = false,
       },
     })
   end,
 },
}
