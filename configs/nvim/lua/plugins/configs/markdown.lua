local function read_obsidian_daily_notes_config()
  local function convert_obsidian_date_format_to_lua(obsidian_format)
    if not obsidian_format then
      return "_"
    end

    local function escape_pattern(text) -- First, escape any literal characters that would interfere with gsub
      return text:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")
    end

    local format_map = { -- Map of Obsidian date patterns to Lua strftime patterns
      ["YYYY"] = "%Y", -- Year with century
      ["YY"] = "%y", -- Year without century
      ["MMMM"] = "%B", -- Full month name
      ["MMM"] = "%b", -- Abbreviated month name
      ["MM"] = "%m", -- Month as number (01-12)
      ["M"] = "%m", -- Month as number (1-12)
      ["DD"] = "%d", -- Day of month (01-31)
      ["D"] = "%d", -- Day of month (1-31)
      ["ddd"] = "%a", -- Abbreviated weekday name
      ["dddd"] = "%A", -- Full weekday name
    }

    local patterns = {} -- Sort patterns by length (longest first) to ensure proper replacement
    for k in pairs(format_map) do
      table.insert(patterns, k)
    end
    table.sort(patterns, function(a, b)
      return #a > #b
    end)

    local result = obsidian_format -- Replace each pattern with its Lua equivalent
    for _, obsidian_pat in ipairs(patterns) do
      local escaped_pat = escape_pattern(obsidian_pat)
      result = result:gsub(escaped_pat, format_map[obsidian_pat])
    end

    result = result:gsub("([^%%/%s,%-])", "%%%1") -- Escape any remaining literal characters for strftime

    return result
  end

  local config_path = os.getenv("HOME")
    .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/KhojDil/.obsidian/daily-notes.json" -- Path to the daily notes config file

  local file = io.open(config_path, "r") -- Read the file
  if not file then
    return nil, "Could not open config file"
  end

  local content = file:read("*all") -- Read the entire file content
  file:close()

  local ok, json_data = pcall(vim.fn.json_decode, content)
  if not ok then
    return nil, "Failed to parse JSON"
  end

  return {
    folder = json_data.folder,
    date_format = convert_obsidian_date_format_to_lua(json_data.format),
    template = json_data.template,
  }
end

local daily_notes_config = read_obsidian_daily_notes_config() or {}
-- print(vim.inspect(daily_notes_config))

return {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    opts = {
      enabled = true, -- Whether Markdown should be rendered by default or not
      max_file_size = 10.0, -- Maximum file size (in MB) that this plugin will attempt to render Any file larger than this will effectively be ignored
      debounce = 100, -- Milliseconds that must pass before updating marks, updates occur within the context of the visible window, not the entire buffer
      preset = "none", -- 'obsidian', 'lazy', 'none'
      log_level = "error",
      log_runtime = false,
      file_types = { "markdown" },
      injections = {
        gitcommit = {
          enabled = true,
          query = [[
                    ((message) @injection.content
                        (#set! injection.combined)
                        (#set! injection.include-children)
                        (#set! injection.language "markdown"))
                ]],
        },
      },
      render_modes = { "n", "c", "t" }, -- Vim modes that will show a rendered view of the markdown file, :h mode(). All other modes will be unaffected by this plugin
      anti_conceal = {
        enabled = true, -- This enables hiding any added text on the line the cursor is on
        ignore = {
          code_background = true,
          sign = true,
        },
        above = 0, -- Number of lines above cursor to show
        below = 0, -- Number of lines below cursor to show
      },
      padding = {
        highlight = "Normal", -- Highlight to use when adding whitespace, should match background
      },
      on = {
        attach = function() end, -- Called when plugin initially attaches to a buffer
        render = function() end, -- Called after plugin renders a buffer
      },
      heading = {
        enabled = true, -- Turn on / off heading icon & background rendering
        sign = true, -- Turn on / off any sign column related rendering
        -- Determines how icons fill the available space:
        position = "overlay", -- 'right', 'inline', 'overlay'
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        signs = { "󰫎 " },
        width = "full",
        left_margin = 0,
        left_pad = 0,
        right_pad = 0,
        min_width = 0,
        border = false,
        border_virtual = false,
        border_prefix = false,
        above = "▄",
        below = "▀",
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH2Bg",
          "RenderMarkdownH3Bg",
          "RenderMarkdownH4Bg",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH6Bg",
        },
        foregrounds = {
          "RenderMarkdownH1",
          "RenderMarkdownH2",
          "RenderMarkdownH3",
          "RenderMarkdownH4",
          "RenderMarkdownH5",
          "RenderMarkdownH6",
        },
      },
      paragraph = {
        enabled = true, -- Turn on / off paragraph rendering
        left_margin = 0,
        min_width = 0,
      },
      code = {
        enabled = true, -- Turn on / off code block & inline code rendering
        sign = true, -- Turn on / off any sign column related rendering
        style = "full", -- 'none', 'normal', 'language', 'full'
        position = "left", -- Determines where language icon is rendered: 'left', 'right'
        language_pad = 0,
        language_name = true,
        disable_background = { "diff" },
        width = "full",
        left_margin = 0,
        left_pad = 0,
        right_pad = 0,
        min_width = 0,
        border = "thin",
        above = "▄",
        below = "▀",
        highlight = "RenderMarkdownCode",
        highlight_inline = "RenderMarkdownCodeInline",
        highlight_language = nil,
      },
      dash = {
        -- Turn on / off thematic break rendering
        enabled = true,
        -- Replaces '---'|'***'|'___'|'* * *' of 'thematic_break'
        -- The icon gets repeated across the window's width
        icon = "─",
        -- Width of the generated line:
        --  <integer>: a hard coded width value
        --  full:      full width of the window
        width = "full",
        -- Highlight for the whole line generated from the icon
        highlight = "RenderMarkdownDash",
      },
      bullet = {
        -- Turn on / off list bullet rendering
        enabled = true,
        -- Replaces '-'|'+'|'*' of 'list_item'
        -- How deeply nested the list is determines the 'level', how far down at that level determines the 'index'
        -- If a function is provided both of these values are passed in using 1 based indexing
        -- If a list is provided we index into it using a cycle based on the level
        -- If the value at that level is also a list we further index into it using a clamp based on the index
        -- If the item is a 'checkbox' a conceal is used to hide the bullet instead
        icons = { "●", "○", "◆", "◇" },
        -- Replaces 'n.'|'n)' of 'list_item'
        -- How deeply nested the list is determines the 'level', how far down at that level determines the 'index'
        -- If a function is provided both of these values are passed in using 1 based indexing
        -- If a list is provided we index into it using a cycle based on the level
        -- If the value at that level is also a list we further index into it using a clamp based on the index
        ordered_icons = function(level, index, value)
          value = vim.trim(value)
          local value_index = tonumber(value:sub(1, #value - 1))
          return string.format("%d.", value_index > 1 and value_index or index)
        end,
        -- Padding to add to the left of bullet point
        left_pad = 0,
        -- Padding to add to the right of bullet point
        right_pad = 0,
        -- Highlight for the bullet icon
        highlight = "RenderMarkdownBullet",
      },
      checkbox = {
        enabled = true, -- Turn on / off checkbox state rendering
        position = "inline",
        unchecked = {
          icon = "󰄱 ", -- Replaces '[ ]' of 'task_list_marker_unchecked'
          highlight = "RenderMarkdownUnchecked",
          scope_highlight = nil,
        },
        checked = {
          icon = "󰱒 ", -- Replaces '[x]' of 'task_list_marker_checked'
          highlight = "RenderMarkdownChecked",
          scope_highlight = nil,
        },
        custom = {
          todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
        },
      },
      quote = {
        enabled = true, -- Turn on / off block quote & callout rendering
        icon = "▋", -- Replaces '>' of 'block_quote'
        repeat_linebreak = false,
        highlight = "RenderMarkdownQuote",
      },
      pipe_table = {
        enabled = true, -- Turn on / off pipe table rendering
        preset = "none", -- 'heavy', 'double', 'round', 'none'
        style = "full", -- Determines how the table as a whole is rendered: 'full', 'normal', 'none'
        -- Determines how individual cells of a table are rendered:
        --  overlay: writes completely over the table, removing conceal behavior and highlights
        --  raw:     replaces only the '|' characters in each row, leaving the cells unmodified
        --  padded:  raw + cells are padded to maximum visual width for each column
        --  trimmed: padded except empty space is subtracted from visual width calculation
        cell = "padded",
        padding = 1,
        min_width = 0,
            -- Characters used to replace table border
            -- Correspond to top(3), delimiter(3), bottom(3), vertical, & horizontal
            -- stylua: ignore
            border = {
                '┌', '┬', '┐',
                '├', '┼', '┤',
                '└', '┴', '┘',
                '│', '─',
            },
        alignment_indicator = "━",
        head = "RenderMarkdownTableHead",
        row = "RenderMarkdownTableRow",
        filler = "RenderMarkdownTableFill",
      },
      callout = {
        note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
        tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
        important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
        warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
        caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
        -- Obsidian: https://help.obsidian.md/Editing+and+formatting/Callouts
        abstract = { raw = "[!ABSTRACT]", rendered = "󰨸 Abstract", highlight = "RenderMarkdownInfo" },
        summary = { raw = "[!SUMMARY]", rendered = "󰨸 Summary", highlight = "RenderMarkdownInfo" },
        tldr = { raw = "[!TLDR]", rendered = "󰨸 Tldr", highlight = "RenderMarkdownInfo" },
        info = { raw = "[!INFO]", rendered = "󰋽 Info", highlight = "RenderMarkdownInfo" },
        todo = { raw = "[!TODO]", rendered = "󰗡 Todo", highlight = "RenderMarkdownInfo" },
        hint = { raw = "[!HINT]", rendered = "󰌶 Hint", highlight = "RenderMarkdownSuccess" },
        success = { raw = "[!SUCCESS]", rendered = "󰄬 Success", highlight = "RenderMarkdownSuccess" },
        check = { raw = "[!CHECK]", rendered = "󰄬 Check", highlight = "RenderMarkdownSuccess" },
        done = { raw = "[!DONE]", rendered = "󰄬 Done", highlight = "RenderMarkdownSuccess" },
        question = { raw = "[!QUESTION]", rendered = "󰘥 Question", highlight = "RenderMarkdownWarn" },
        help = { raw = "[!HELP]", rendered = "󰘥 Help", highlight = "RenderMarkdownWarn" },
        faq = { raw = "[!FAQ]", rendered = "󰘥 Faq", highlight = "RenderMarkdownWarn" },
        attention = { raw = "[!ATTENTION]", rendered = "󰀪 Attention", highlight = "RenderMarkdownWarn" },
        failure = { raw = "[!FAILURE]", rendered = "󰅖 Failure", highlight = "RenderMarkdownError" },
        fail = { raw = "[!FAIL]", rendered = "󰅖 Fail", highlight = "RenderMarkdownError" },
        missing = { raw = "[!MISSING]", rendered = "󰅖 Missing", highlight = "RenderMarkdownError" },
        danger = { raw = "[!DANGER]", rendered = "󱐌 Danger", highlight = "RenderMarkdownError" },
        error = { raw = "[!ERROR]", rendered = "󱐌 Error", highlight = "RenderMarkdownError" },
        bug = { raw = "[!BUG]", rendered = "󰨰 Bug", highlight = "RenderMarkdownError" },
        example = { raw = "[!EXAMPLE]", rendered = "󰉹 Example", highlight = "RenderMarkdownHint" },
        quote = { raw = "[!QUOTE]", rendered = "󱆨 Quote", highlight = "RenderMarkdownQuote" },
        cite = { raw = "[!CITE]", rendered = "󱆨 Cite", highlight = "RenderMarkdownQuote" },
      },
      link = {
        enabled = true, -- Turn on / off inline link icon rendering
        footnote = {
          superscript = true, -- Replace value with superscript equivalent
          prefix = "", -- Added before link content when converting to superscript
          suffix = "", -- Added after link content when converting to superscript
        },
        image = "󰥶 ", -- Inlined with 'image' elements
        email = "󰀓 ", -- Inlined with 'email_autolink' elements
        hyperlink = "󰌹 ", -- Fallback icon for 'inline_link' and 'uri_autolink' elements
        highlight = "RenderMarkdownLink", -- Applies to the inlined icon as a fallback
        wiki = { icon = "󱗖 ", highlight = "RenderMarkdownWikiLink" }, -- Applies to WikiLink elements
        custom = {
          web = { pattern = "^http", icon = "󰖟 " },
          youtube = { pattern = "youtube%.com", icon = "󰗃 " },
          github = { pattern = "github%.com", icon = "󰊤 " },
          neovim = { pattern = "neovim%.io", icon = " " },
          stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
          discord = { pattern = "discord%.com", icon = "󰙯 " },
          reddit = { pattern = "reddit%.com", icon = "󰑍 " },
        },
      },
      sign = {
        enabled = true, -- Turn on / off sign rendering
        highlight = "RenderMarkdownSign", -- Applies to background of sign text
      },
      -- Mimics Obsidian inline highlights when content is surrounded by double equals
      -- The equals on both ends are concealed and the inner content is highlighted
      inline_highlight = {
        enabled = true, -- Turn on / off inline highlight rendering
        highlight = "RenderMarkdownInlineHighlight", -- Applies to background of surrounded text
      },
      -- Mimic org-indent-mode behavior by indenting everything under a heading based on the
      -- level of the heading. Indenting starts from level 2 headings onward.
      indent = {
        -- Turn on / off org-indent-mode
        enabled = false,
        -- Amount of additional padding added for each heading level
        per_level = 2,
        -- Heading levels <= this value will not be indented
        -- Use 0 to begin indenting from the very first level
        skip_level = 1,
        -- Do not indent heading titles, only the body
        skip_heading = false,
      },
      html = {
        -- Turn on / off all HTML rendering
        enabled = true,
        comment = {
          -- Turn on / off HTML comment concealing
          conceal = true,
          -- Optional text to inline before the concealed comment
          text = nil,
          -- Highlight for the inlined text
          highlight = "RenderMarkdownHtmlComment",
        },
      },
      -- Window options to use that change between rendered and raw view
      win_options = {
        -- See :h 'conceallevel'
        conceallevel = {
          -- Used when not being rendered, get user setting
          default = vim.api.nvim_get_option_value("conceallevel", {}),
          -- Used when being rendered, concealed text is completely hidden
          rendered = 3,
        },
        -- See :h 'concealcursor'
        concealcursor = {
          -- Used when not being rendered, get user setting
          default = vim.api.nvim_get_option_value("concealcursor", {}),
          -- Used when being rendered, disable concealing text in all modes
          rendered = "",
        },
      },
      overrides = {
        buftype = {
          nofile = {
            padding = { highlight = "NormalFloat" },
            sign = { enabled = false },
          },
        },
        filetype = {},
      },
      custom_handlers = {},
    },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required.
    },
    opts = {
      ui = { enable = false },
      workspaces = {
        {
          name = "KhojDil",
          path = "/Users/gians/Library/Mobile Documents/iCloud~md~obsidian/Documents/KhojDil/",
        },
      },

      templates = {
        folder = daily_notes_config.folder,
      },
      daily_notes = {
        folder = daily_notes_config.folder or "_",
        date_format = daily_notes_config.date_format or "_",
        template = daily_notes_config.template, -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        alias_format = nil,
        default_tags = nil,
      },

      completion = {
        nvim_cmp = true, -- Set to false to disable completion.
        min_chars = 2, -- Trigger completion at 2 chars.
      },

      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },
    },
  },
}
