# 💤 My Neovim Configuration

A personalized Neovim setup based on [LazyVim](https://github.com/LazyVim/LazyVim), optimized for modern development workflows with AI integration, focused writing, and enhanced git support.

## Features

### Core Enhancements
- **Absolute Line Numbers by Default** - Toggle between absolute and relative with `<Space>uL`
- **Auto-Reload Files** - Automatically reload files changed on disk without prompting (like Emacs auto-revert-mode)
- **Manual Formatting** - Format on demand with `<Space>cf` instead of auto-format on save
- **Spell Checking** - Enabled globally with auto-enable for markdown, git commits, and text files

### AI Integration
- **Claude Code** - Native integration with Anthropic's Claude AI assistant
  - Toggle Claude terminal: `<Space>ac`
  - Send selection to Claude: `<Space>as` (visual mode)
  - Accept/Reject AI diffs: `<Space>aa` / `<Space>ar`
  - Status and control: `<Space>ai`, `<Space>aR` (restart)

### Git Workflow
- **Enhanced Gitsigns** - Inline git blame, hunk navigation, and staging
  - Inline blame showing author, date, and summary
  - Navigate hunks: `]h` / `[h`
  - Stage/reset hunks: `<Space>hs` / `<Space>hr`
  - Preview and diff: `<Space>hp` / `<Space>hd`

### File Management
- **Neo-tree** - Feature-rich file explorer with git integration
  - 40-column sidebar with git status indicators
  - Dotfiles visible by default (toggle with `H`)
  - File operations: add (`a`), delete (`d`), rename (`r`)
  - Git navigation: `]g` / `[g` for modified files

### Focus Mode
- **Zen Mode + Twilight** - Distraction-free writing and coding
  - Zen Mode: `<Space>z` - Centers content, removes UI chrome
  - Twilight: `<Space>uT` - Dims inactive code for focus

## Quick Start

### For Vim Users New to Neovim

If you're coming from vanilla Vim, here are the key differences you'll encounter:

**The Leader Key Concept**
- The **leader key** is a prefix that unlocks hundreds of custom commands
- In this config, `<Space>` is the leader (LazyVim default)
- Press `<Space>` and wait ~300ms - a **which-key** menu appears showing all available commands
- Example: `<Space>ff` = "leader, then f, then f" = Find files
- This replaces the need to memorize `:CommandName` for common operations

**From Vim Commands to Leader-Based Workflow**
| Vim Way | This Config | What It Does |
|---------|-------------|--------------|
| `:e filename` | `<Space>ff` | Find/open files |
| `:grep pattern` | `<Space>fg` | Search in files |
| `:bn` / `:bp` | `<Space><Space>` | Switch buffers (fuzzy finder) |
| `:Explore` | `<Space>e` | File explorer |
| Manual splits | `<Space>-` / `<Space>\|` | Split horizontal/vertical |

**Modern Features Not in Vanilla Vim**
- **LSP (Language Server Protocol)** - Real IDE features: go-to-definition (`gd`), auto-complete, inline errors
- **Treesitter** - Syntax-aware highlighting and text objects (much better than regex-based)
- **Telescope** - Fuzzy finder for files, text, buffers, git commits, and more
- **Auto-pairs** - Brackets, quotes auto-close and indent smartly
- **Git Integration** - See changes inline, stage hunks without leaving editor

**What Still Works the Same**
- All standard Vim motions: `hjkl`, `w`/`b`, `f`/`t`, `d`/`y`/`c` operators
- Macros (`q`), marks (`m`), registers (`"`), visual mode (`v`/`V`)
- Ex commands (`:w`, `:q`, `:s/find/replace/g`)
- Your muscle memory for editing stays intact

**First Steps**
1. Launch `nvim` - plugins auto-install (takes ~1 min first time)
2. Press `<Space>` and explore the which-key menu
3. Try `<Space>ff` to open a file, `<Space>e` for file tree
4. Press `K` over a word for documentation (if in code file)
5. Type `:Lazy` to see installed plugins

### Installation
```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this config
git clone <your-repo-url> ~/.config/nvim

# Launch Neovim (plugins will auto-install)
nvim
```

### Essential Keymaps
All keymaps use `<Space>` (leader key) as the prefix. Press `<Space>` to see available commands via which-key.

**File Navigation:**
- `<Space>ff` - Find files
- `<Space>fg` - Live grep (search in files)
- `<Space>e` - Toggle file explorer
- `<Space><Space>` - Find buffers

**Code Actions:**
- `gd` - Go to definition
- `gr` - Find references
- `<Space>ca` - Code actions
- `<Space>cf` - Format buffer (manual formatting)
- `K` - Hover documentation

**Git:**
- `<Space>gg` - Open Lazygit
- `]h` / `[h` - Next/previous hunk
- `<Space>hs` - Stage hunk
- `<Space>hp` - Preview hunk

**UI Toggles:**
- `<Space>uL` - Toggle relative line numbers
- `<Space>z` - Zen mode
- `<Space>uT` - Twilight (focus mode)

**AI Assistant:**
- `<Space>ac` - Toggle Claude Code
- `<Space>as` - Send selection to Claude (visual mode)
- `<Space>aa` - Accept AI suggestion

### Plugin Management
- `:Lazy` - Open plugin manager UI
- `:Lazy update` - Update all plugins
- `:Lazy sync` - Sync plugins with config

## Tips & Troubleshooting

### Learning the Keybindings
- **Use which-key**: Press `<Space>` and pause - the popup shows all available commands organized by category
- **Follow the pattern**: Most keybinds are mnemonic (`f` = find, `g` = git, `c` = code, `u` = UI toggles)
- **Discover as you go**: Type `:Telescope keymaps` to search all available keybindings

### Working with LSP
- **Auto-complete**: Start typing - suggestions appear automatically (use `<Tab>` / `<S-Tab>` to navigate)
- **Installing language servers**: Open a file, if LSP is missing you'll get a prompt to install via Mason
- **Manual installation**: `:Mason` opens the installer UI - search for your language and press `i` to install
- **Common LSP keybinds**: `gd` (definition), `gr` (references), `<Space>ca` (code actions), `<Space>rn` (rename)

### Fuzzy Finding Tips
- **Telescope tricks**:
  - Use `'` for exact match, `^` for start, `$` for end
  - Multiple terms are AND-ed together: `foo bar` finds files with both
  - In results: `<C-q>` sends results to quickfix list for bulk operations
- **Search in files** (`<Space>fg`): Respects `.gitignore` by default

### Common Gotchas
- **Clipboard not working?** Neovim uses system clipboard - install `xclip` (Linux) or `pbcopy` (macOS)
- **Colors look wrong?** Ensure your terminal supports true color (24-bit)
- **Plugin errors on startup?** Run `:Lazy sync` to reinstall/update plugins
- **LSP not working?** Check `:LspInfo` to see server status, `:Mason` to verify installation

### Performance Tips
- **Lazy loading works**: Most plugins only load when needed - startup is fast (~50ms)
- **Large files**: Treesitter auto-disables on files >100KB to prevent lag
- **Slow searches?** Add directories to `.gitignore` - Telescope respects it

### Getting Help
- **In-editor**: `:help <topic>` (e.g., `:help telescope`, `:help lsp`)
- **LazyVim docs**: Press `<Space>fh` to fuzzy-find help docs
- **Plugin docs**: `:Lazy` then press `?` for help on any plugin

## Configuration Structure

```
~/.config/nvim/
├── init.lua              # Entry point
├── lua/
│   ├── config/           # Core configuration
│   │   ├── lazy.lua      # Plugin manager setup
│   │   ├── options.lua   # Neovim options
│   │   ├── keymaps.lua   # Custom keymaps
│   │   └── autocmds.lua  # Autocommands
│   └── plugins/          # Plugin configurations
│       ├── claude-code.lua
│       ├── git.lua
│       ├── neo-tree.lua
│       └── zen-mode.lua
└── lazy-lock.json        # Plugin version lock
```

## Plugin Reference

### Custom Plugins (Beyond LazyVim Defaults)

| Plugin | Purpose | When to Use It |
|--------|---------|----------------|
| **claudecode.nvim** | AI-powered coding assistant integration | Ask Claude to explain code, generate functions, refactor, or review changes without leaving Neovim |
| **gitsigns.nvim** (enhanced) | Git integration with inline blame and hunk operations | See who changed what and when inline, stage/reset changes by hunk instead of whole files |
| **neo-tree.nvim** (customized) | Visual file explorer with git status | Browse project structure visually, perform file operations with single keys, navigate to modified files |
| **zen-mode.nvim** | Distraction-free writing mode | Writing documentation, focus on single function/file, presenting code to others |
| **twilight.nvim** | Dims inactive code blocks | Complementary to Zen Mode - helps focus on current function/block by dimming surrounding code |

### Key LazyVim Built-in Plugins

These come with LazyVim and provide core functionality:

| Plugin | Purpose | When to Use It |
|--------|---------|----------------|
| **telescope.nvim** | Fuzzy finder for files, text, commands | Primary way to navigate files (`<Space>ff`), search code (`<Space>fg`), switch buffers |
| **nvim-lspconfig** | Language Server Protocol client | Automatic: Provides IDE features (auto-complete, go-to-definition, errors) for any language |
| **mason.nvim** | LSP/tool installer | Install language servers, formatters, linters through UI (`:Mason`) instead of system packages |
| **nvim-treesitter** | Syntax-aware parsing | Automatic: Better highlighting, smart text objects (`vaf` for function, `vac` for class) |
| **which-key.nvim** | Keymap discovery popup | Automatic: Shows available commands when you press `<Space>` - your personal cheat sheet |
| **mini.pairs** | Auto-close brackets/quotes | Automatic: Types closing bracket when you open one, deletes pairs together |
| **conform.nvim** (customized) | Code formatter | Manual formatting with `<Space>cf` - disabled auto-format on save for more control |
| **lazygit.nvim** | TUI git client integration | Full git workflow without leaving editor (`<Space>gg`) - stage, commit, push, resolve conflicts |
| **flash.nvim** | Enhanced motion (replacement for vim-sneak) | Jump to any visible text with `s{char}{char}`, label-based navigation |
| **todo-comments.nvim** | Highlight TODO/FIXME/etc | Find all TODOs in project (`<Space>st`), highlights them in code with distinct colors |
| **trouble.nvim** | Pretty diagnostics list | View all errors/warnings in project (`<Space>xx`), better than quickfix list |
| **bufferline.nvim** | Tab-like buffer display | See all open files at top, mouse-clickable, shows unsaved indicators |

## Customization

All custom configuration extends LazyVim defaults:
- **Options**: Edit `lua/config/options.lua`
- **Keymaps**: Edit `lua/config/keymaps.lua`
- **Plugins**: Add files to `lua/plugins/`

See [CLAUDE.md](CLAUDE.md) for detailed architecture and development guide.

## Resources

- [LazyVim Documentation](https://lazyvim.github.io)
- [Neovim Documentation](https://neovim.io/doc)
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
