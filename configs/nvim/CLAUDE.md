# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a highly customized Neovim configuration using lazy.nvim as the plugin manager. The configuration totals ~2,000+ lines of Lua code with a modular architecture that balances power-user features with maintainability. It includes deep macOS integration, Obsidian note-taking workflow, and support for 10+ programming languages.

## Architecture

### Bootstrap Sequence (init.lua)
1. Load helper functions (`user.helper_funcs`)
2. Load vim options (`user.options`)
3. Load keymaps (`user.keymaps`)
4. Load autocommands (`user.autocmds`)
5. Initialize lazy.nvim plugin manager (`user.lazy`)
6. Apply random colorscheme via `RandomColorScheme()`

### Directory Structure
```
lua/
├── user/                      # Core user configuration
│   ├── lazy.lua              # Plugin manager bootstrap
│   ├── options.lua           # All vim.opt settings
│   ├── keymaps.lua           # All keybindings (uses custom map() function)
│   ├── autocmds.lua          # Autocommands
│   ├── helper_funcs.lua      # Custom commands & utility functions
│   └── icons.lua             # Icon definitions for UI
└── plugins/
    └── configs/              # Plugin specs (auto-imported by lazy.nvim)
        ├── lsp.lua           # LSP configuration
        ├── cmp.lua           # Completion
        ├── treesitter.lua    # Syntax highlighting
        ├── telescope.lua     # Fuzzy finder
        ├── formatter.lua     # Language formatters
        ├── git.lua           # Git integration
        ├── markdown.lua      # Markdown & Obsidian
        ├── ui.lua            # Colorschemes & UI enhancements
        ├── snacks.lua        # Snacks.nvim utilities
        ├── toggleterm.lua    # Terminal management
        └── [15+ other plugin configs]

after/
└── ftplugin/
    └── markdown.lua          # Markdown table formatting
```

### Plugin Management Pattern
- All plugin specs in `lua/plugins/configs/` are automatically imported via `{ import = "plugins.configs" }`
- Each file exports a table of plugin specs following lazy.nvim's format
- Multiple related plugins can be grouped in the same file

### Keymap Architecture
- `lua/user/keymaps.lua` defines a custom `map()` function that tracks all keybindings
- All keymaps are organized into groups (Find, Terminal, Diff, Git, LSP, Buffers, Markdown, Harpoon, Obsidian)
- Keymaps are stored in global `AllKeymapGroups` table for potential WhichKey integration
- Space is the leader key

## Key Configuration Files

### lua/user/helper_funcs.lua (372 lines)
Contains 20+ custom commands and utility functions:
- **macOS Integration**: `MacOSQuicklook()` for file preview via QuickLook
- **Apple Notes Sync**: `SaveToAppleNotes()` and `ReadFromAppleNotes()` for todo.md syncing
- **Formatting**: `CSVFormat` for CSV data, `Split_long_line()` for 80-char line splitting
- **Color Management**: `RandomColorScheme()` cycles through favorite themes
- **Toggle Commands**: AutoPairs, FoldMethod, Clipboard, diagnostics
- **Obsidian Integration**: Daily notes config parser (reads JSON, converts date formats)

### lua/user/autocmds.lua
- Highlight on yank
- Project-specific autocmds (Keerat web project - runs scripts on TRACKS.js save)
- Apple Notes sync on todo.md save/read
- Kitty terminal config auto-reload on save

### lua/plugins/configs/lsp.lua
- LSP servers via Mason: lua_ls, ts_ls, gopls, clangd, pyright, bashls, rust_analyzer, etc.
- **Custom handlers**:
  - TypeScript: `OrganizeImports` command
  - Go: Uses gofumpt via gopls
  - Clang: UTF-16 offset encoding
- Keybindings attached on LspAttach (gd, gr, K, <leader>ca, etc.)

### lua/plugins/configs/formatter.lua
- Language-specific formatters: stylua, prettier, black, gofmt, shfmt, swiftformat, clang-format, ktlint, etc.
- Auto-removes trailing whitespace for all filetypes
- Custom SQL formatter using `pg_format`

### lua/plugins/configs/markdown.lua (largest config - 19K)
- markdown-preview.nvim for browser preview
- render-markdown.nvim for in-editor rendering
- Obsidian.nvim with custom daily notes config parser
- Table formatting via after/ftplugin/markdown.lua

## Common Development Commands

### Plugin Management
- `:Lazy` - Open lazy.nvim UI for installing/updating/removing plugins
- `:Mason` - Manage LSP servers, formatters, linters
- `:TSUpdate` - Update Treesitter parsers

### LSP Operations
- `:LspInfo` - Check LSP client status
- `:Format` - Format current buffer using formatter.nvim
- `:OrganizeImports` - Organize TypeScript/JavaScript imports
- `gd` - Go to definition
- `gr` - Go to references (via Telescope)
- `K` - Hover documentation
- `<leader>ca` - Code actions

### Custom Commands
- `:CSVFormat` - Format CSV data intelligently
- `:TableFormat` - Format markdown tables (auto-loaded in markdown files)
- `:ToggleFoldMethod` - Switch between indent and treesitter folding
- `:GetRandomColor` - Generate random hex color
- `:OilYankPath` - Copy file path from Oil file explorer
- `:WordCount` - Count words in document
- `:FormatXML` - Pretty print XML using Python
- `:MacOSQuicklook` - Preview current file in macOS QuickLook
- `:SaveToAppleNotes` / `:ReadFromAppleNotes` - Sync with Apple Notes app

### File Navigation
- `<leader>ff` - Find files (Telescope)
- `<leader>fg` - Live grep (Telescope)
- `<leader>fb` - Find buffers (Telescope)
- `-` - Open Oil file explorer (default netrw replacement)
- Harpoon marks for quick file navigation

### Terminal
- `<C-\>` - Toggle floating terminal
- `:ToggleTerm` - Open terminal in various modes (float/horizontal/vertical)
- Pre-configured terminals: lazygit, node, htop, python

## Important Implementation Details

### macOS-Specific Features
This config includes several macOS-specific integrations:
- QuickLook file preview via `open -a "Quick Look Previewer"`
- Apple Notes sync using AppleScript
- Kitty terminal config reload via SIGUSR1

When modifying these features, test on macOS or add platform detection guards.

### Project-Specific Autocmds
The Keerat web project has special autocmds that run shell scripts on TRACKS.js save. When editing `lua/user/autocmds.lua`, be aware these are user-specific paths that may not exist on other systems.

### Obsidian Integration
The Obsidian.nvim config uses a custom parser to read daily notes config from `~/Desktop/todo.md` at line 138. The parser extracts JSON config and converts date formats. This tight coupling means changes to Obsidian plugin config may require updating the parser logic in `lua/user/helper_funcs.lua`.

### Keymap Tracking System
The custom `map()` function in `lua/user/keymaps.lua` tracks all keybindings in the `AllKeymapGroups` global table. This is designed for WhichKey integration (currently commented out in init.lua). When adding new keymaps, use the `map()` function instead of `vim.keymap.set()` to maintain consistency.

### LSP Handler Overrides
Several LSP servers have custom handlers:
- **TypeScript**: Custom organize imports command
- **Go**: Configured to use gofumpt formatting
- **Clang**: UTF-16 encoding workaround

When debugging LSP issues, check if custom handlers in `lua/plugins/configs/lsp.lua` are interfering.

### Formatter Priority
The formatter.nvim config defines formatters per filetype. These take precedence over LSP formatting. If formatting behavior seems incorrect, check both `lua/plugins/configs/formatter.lua` and the LSP server's formatting settings.

## Language Support

Configured LSP servers and formatters for:
- **JavaScript/TypeScript**: ts_ls, prettier, eslint
- **Python**: pyright, black, isort
- **Go**: gopls (with gofumpt)
- **Lua**: lua_ls, stylua
- **Rust**: rust_analyzer
- **C/C++**: clangd, clang-format
- **Shell**: bashls, shfmt
- **Swift**: sourcekit-lsp, swiftformat
- **PHP**: intelephense
- **Kotlin**: kotlin_language_server, ktlint
- **Java**: jdtls
- **SQL**: pg_format (PostgreSQL)

## File Organization Principles

When making changes:
1. **User settings** (options, keymaps, autocmds) go in `lua/user/`
2. **Plugin specs** go in `lua/plugins/configs/`
3. **Filetype-specific config** goes in `after/ftplugin/`
4. **Custom utility functions** go in `lua/user/helper_funcs.lua`
5. Never modify lazy.nvim bootstrap in `lua/user/lazy.lua` unless necessary

## Testing Changes

1. Restart Neovim to reload init.lua
2. Use `:Lazy reload [plugin]` to reload a specific plugin
3. Use `:source %` to reload the current Lua file
4. Check `:messages` for error messages
5. Use `:LspInfo` to verify LSP server status
6. Use `:checkhealth` for diagnostic information

## Additional Context

- The config uses `lazy = false` by default (plugins load at startup, not lazily)
- Random colorscheme is applied on every Neovim launch
- The config maintains backward compatibility with commented-out LazyVim integration
- Lock file (`lazy-lock.json`) tracks plugin versions for reproducibility
