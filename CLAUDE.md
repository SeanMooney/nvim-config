# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on [LazyVim](https://github.com/LazyVim/LazyVim), a Neovim starter template that uses the lazy.nvim plugin manager. This configuration is located in `~/.config/nvim/` and follows LazyVim's modular structure.

## Architecture

### Entry Point
- **init.lua**: Bootstraps the configuration by requiring `config.lazy`

### Core Configuration (`lua/config/`)
- **lazy.lua**: Sets up lazy.nvim plugin manager, defines plugin loading behavior, and configures performance optimizations
- **options.lua**: Neovim options (extends LazyVim defaults)
- **keymaps.lua**: Custom keymaps (extends LazyVim defaults)
- **autocmds.lua**: Autocommands (extends LazyVim defaults)

### Plugin System (`lua/plugins/`)
- Each `.lua` file in this directory is automatically loaded by lazy.nvim
- Plugin files can add new plugins, disable/enable LazyVim plugins, or override LazyVim plugin configurations
- Use tables to return plugin specifications
- **example.lua**: Contains comprehensive examples of plugin configuration patterns (currently disabled with early return)

### Plugin Configuration Patterns
1. **Adding plugins**: Return a table with plugin spec: `{ "author/plugin-name" }`
2. **Configuring plugins**: Use `opts` table or function to merge/override options
3. **Disabling plugins**: Set `enabled = false` in plugin spec
4. **LSP setup**: Configure servers via `nvim-lspconfig` opts with `servers` table
5. **Extending lists**: Use `vim.list_extend()` to append to default lists (e.g., treesitter parsers)
6. **Overriding defaults**: Use `opts` function that returns new table to completely replace defaults

## LazyVim Integration

This configuration inherits all default plugins, keymaps, options, and autocmds from LazyVim. Key defaults include:
- Default keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
- Default options: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
- Default autocmds: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

## Development Commands

### Code Formatting
```bash
stylua .
```
Formats all Lua files using StyLua with the configuration in `stylua.toml` (2-space indentation, 120 column width).

### Plugin Management
Within Neovim:
- `:Lazy` - Open lazy.nvim UI to view, update, and manage plugins
- `:Lazy update` - Update all plugins
- `:Lazy sync` - Install missing plugins and update existing ones
- `:Lazy check` - Check for plugin updates

### Testing Configuration
```bash
nvim --headless "+Lazy! sync" +qa  # Install/sync plugins without opening UI
nvim -u NONE  # Start Neovim without any config (for troubleshooting)
```

## Plugin Loading Strategy

- LazyVim plugins are lazy-loaded by default
- Custom plugins in `lua/plugins/` load during startup (unless explicitly marked `lazy = true`)
- Plugins can be lazy-loaded based on:
  - Events (e.g., `event = "VeryLazy"`)
  - Commands
  - Keymaps
  - File types

## LSP and Tools

LSP servers and tools are managed via Mason. The configuration uses:
- **mason.nvim**: Package manager for LSP servers, formatters, and linters
- **mason-lspconfig.nvim**: Bridge between Mason and nvim-lspconfig
- **nvim-lspconfig**: LSP configuration

To add new LSP servers, add them to the `ensure_installed` table in a Mason plugin spec, or configure them in `nvim-lspconfig` opts under `servers`.