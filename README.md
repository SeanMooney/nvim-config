# 💤 My Neovim Configuration

A minimal Neovim setup based on [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) principles, using the [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager. Optimized for modern development workflows with AI integration and essential utilities.

## Features

### Core Enhancements
- **Auto-Reload Files** - Automatically reload files changed on disk without prompting (like Emacs auto-revert-mode)
- **Spell Checking** - Auto-enabled for markdown, git commits, and text files
- **Clipboard Integration** - Synced with system clipboard
- **Smart Search** - Case-insensitive unless uppercase letters are used

### AI Integration
- **Claude Code** - Native integration with Anthropic's Claude AI assistant
  - Toggle Claude terminal: `<Space>ac`
  - Send selection to Claude: `<Space>as` (visual mode)
  - Accept/Reject AI diffs: `<Space>aa` / `<Space>ar`
  - Status and control: `<Space>ai`, `<Space>aR` (restart)

### Essential Utilities
- **Snacks.nvim** - Comprehensive utility collection providing:
  - Dashboard on startup
  - File explorer
  - Notifications
  - Terminal integration
  - And more

## Quick Start

### For Vim Users New to Neovim

If you're coming from vanilla Vim, here are the key differences you'll encounter:

**The Leader Key Concept**
- The **leader key** is a prefix that unlocks custom commands
- In this config, `<Space>` is the leader
- Example: `<Space>ac` = "Space, then a, then c" = Toggle Claude Code
- This replaces the need to memorize `:CommandName` for common operations

**Modern Features Not in Vanilla Vim**
- **LSP (Language Server Protocol)** - Real IDE features: go-to-definition (`gd`), auto-complete, inline errors
- **lazy.nvim** - Fast plugin manager with lazy loading capabilities
- **AI Integration** - Claude Code assistant directly in your editor

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

**Basic Navigation:**
- `<Esc>` - Clear search highlights
- `<C-h/j/k/l>` - Navigate between windows
- `<Esc><Esc>` - Exit terminal mode

**AI Assistant:**
- `<Space>ac` - Toggle Claude Code terminal
- `<Space>af` - Focus Claude Code terminal
- `<Space>as` - Send selection to Claude (visual mode)
- `<Space>aa` - Accept AI diff
- `<Space>ar` - Reject AI diff
- `<Space>aR` - Restart Claude Code
- `<Space>ai` - Show Claude Code status

### Plugin Management
- `:Lazy` - Open plugin manager UI
- `:Lazy update` - Update all plugins
- `:Lazy sync` - Sync plugins with config

## Tips & Troubleshooting

### Common Issues
- **Clipboard not working?** Neovim uses system clipboard - install `xclip` (Linux) or ensure `pbcopy` is available (macOS)
- **Colors look wrong?** Ensure your terminal supports true color (24-bit)
- **Plugin errors on startup?** Run `:Lazy sync` to reinstall/update plugins

### Getting Help
- **In-editor**: `:help <topic>` (e.g., `:help options`, `:help lsp`)
- **Plugin docs**: `:Lazy` then press `?` for help on any plugin
- **Configuration guide**: See [CLAUDE.md](CLAUDE.md) for architecture details

## Configuration Structure

```
~/.config/nvim/
├── init.lua              # Entry point (requires config.lazy)
├── lua/
│   ├── config/           # Core configuration
│   │   ├── lazy.lua      # Plugin manager setup
│   │   ├── options.lua   # Neovim options and basic keymaps
│   │   ├── keymaps.lua   # Additional custom keymaps (optional)
│   │   └── autocmds.lua  # Autocommands
│   └── plugins/          # Plugin configurations
│       ├── claude-code.lua  # Claude AI integration
│       ├── snacks.lua       # Snacks utilities
│       ├── telescope.lua    # Fuzzy finder (optional)
│       └── ui.lua           # UI plugins (optional)
└── lazy-lock.json        # Plugin version lock
```

## Installed Plugins

### Core Plugins

| Plugin | Purpose |
|--------|---------|
| **claudecode.nvim** | AI-powered coding assistant - Claude integration with terminal UI |
| **snacks.nvim** | Comprehensive utility collection - dashboard, explorer, notifications, terminal, etc. |

### Optional Plugins

Additional plugins may be configured in `lua/plugins/telescope.lua` and `lua/plugins/ui.lua` depending on your needs.

## Customization

To customize this configuration:
- **Options**: Edit `lua/config/options.lua` for Neovim settings
- **Keymaps**: Edit `lua/config/keymaps.lua` for additional keybindings
- **Autocmds**: Edit `lua/config/autocmds.lua` for autocommands
- **Plugins**: Add new files to `lua/plugins/` - each file is automatically loaded

See [CLAUDE.md](CLAUDE.md) for detailed architecture and best practices.

## Resources

- [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - Inspiration for this config
- [Neovim Documentation](https://neovim.io/doc)
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [snacks.nvim](https://github.com/folke/snacks.nvim) - Utility collection
