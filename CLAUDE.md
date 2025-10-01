# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) principles, using the lazy.nvim plugin manager. This configuration is located in `~/.config/nvim/` and follows a modular structure with core config and plugins separated.

## Architecture

### Entry Point
- **init.lua**: Bootstraps the configuration by requiring `config.lazy`

### Core Configuration (`lua/config/`)
- **init.lua**: Optional initialization file (if present, loaded before lazy.nvim setup)
- **lazy.lua**: Sets up lazy.nvim plugin manager with `{ import = "plugins" }` spec
- **options.lua**: Neovim options and basic keymaps (Kickstart-based)
- **keymaps.lua**: Additional custom keymaps (if present)
- **autocmds.lua**: Autocommands for file-type specific behavior and auto-reload

### Plugin System (`lua/plugins/`)
- Each `.lua` file returns a plugin spec (table or list of tables) and is automatically loaded by lazy.nvim
- Files are named descriptively: `claude-code.lua`, `snacks.lua`, `telescope.lua`, `ui.lua`
- Plugin-specific keymaps should use the `keys` property in plugin specs for lazy loading

### Plugin Configuration Patterns
1. **Adding plugins**: Return a table with plugin spec: `{ "author/plugin-name" }`
2. **Configuring plugins**: Use `opts` table or function to merge/override options
3. **Disabling plugins**: Set `enabled = false` in plugin spec
4. **LSP setup**: Configure servers via `nvim-lspconfig` opts with `servers` table
5. **Extending lists**: Use `vim.list_extend()` to append to default lists (e.g., treesitter parsers)
6. **Overriding defaults**: Use `opts` function that returns new table to completely replace defaults

## Best Practices

### File Organization
- **options.lua**: ONLY Neovim settings (`vim.opt.*`, `vim.g.*`). NO autocmds, NO function calls that set up behavior.
- **autocmds.lua**: ALL autocommands (`vim.api.nvim_create_autocmd`). Move autocmds out of options.lua.
- **keymaps.lua**: Custom keymaps that aren't plugin-specific. Plugin-specific keymaps should use the `keys` property in plugin specs.

### Current Plugin Files
- **snacks.lua**: `folke/snacks.nvim` - provides dashboard, file explorer, notifications, terminal, and other UI utilities
- **claude-code.lua**: `coder/claudecode.nvim` - Claude AI integration with snacks terminal provider
- **telescope.lua**: Fuzzy finder configuration (if present)
- **ui.lua**: UI-related plugins and theming (if present)

### Opts Merging Pattern
When extending lists in `opts` functions, ALWAYS:
1. Initialize the list if it doesn't exist
2. Extend the list
3. Return the opts table

**Correct pattern:**
```lua
opts = function(_, opts)
  opts.ensure_installed = opts.ensure_installed or {}
  vim.list_extend(opts.ensure_installed, { "bash", "python" })
  return opts
end,
```

**Incorrect patterns:**
```lua
-- Missing return statement
opts = function(_, opts)
  vim.list_extend(opts.ensure_installed or {}, { "bash" })
end,

-- Inline initialization (harder to read and error-prone)
opts = function(_, opts)
  vim.list_extend(opts.ensure_installed or {}, { "bash" })
end,
```

### Avoid Duplicate Plugin Specs
- **One plugin = one spec** in each file
- If you need both `opts` and `init` for the same plugin, combine them in a single spec
- Multiple specs for the same plugin in one file will cause confusion and potential merge issues

**Correct:**
```lua
{
  "neovim/nvim-lspconfig",
  opts = { servers = { bashls = {} } },
  init = function()
    vim.api.nvim_create_autocmd(...)
  end,
}
```

**Incorrect:**
```lua
-- Two separate specs for the same plugin
{ "neovim/nvim-lspconfig", opts = { servers = { bashls = {} } } },
{ "neovim/nvim-lspconfig", init = function() ... end },
```

### Global vs Filetype-Specific Settings
- **Avoid global settings** that should only apply to specific filetypes
- Use autocmds with FileType events for filetype-specific behavior

**Example - Spell checking:**
```lua
-- options.lua - Configure spell checking but don't enable globally
vim.opt.spelllang = { "en_us" }
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

-- autocmds.lua - Enable only for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.spell = true
  end,
})
```

### Treesitter Parser Management
- Avoid duplicating parser names across multiple files
- If a language-specific file (e.g., `bash.lua`) adds a parser, don't add it again in `treesitter.lua`
- Keep the main `treesitter.lua` for parsers that don't have dedicated language files

### LSP Server Configuration
- Configure LSP servers in language-specific plugin files (e.g., `ansible.lua`, `bash.lua`)
- Use the `servers` table in `nvim-lspconfig` opts
- Language-specific settings belong with the language configuration, not scattered

### Plugin Lazy Loading
- Use `lazy = true` for plugins that aren't needed at startup
- Prefer loading via `cmd`, `keys`, `ft`, or `event` triggers
- Example: `cmd = "ZenMode"` will load the plugin only when the command is run

### Comments and Documentation
- Add inline comments explaining non-obvious configurations
- Document WHY you're configuring something, not just WHAT it does
- Use comment headers to organize related plugin specs in files with multiple plugins

### Testing Changes
After making configuration changes:
1. Run `:checkhealth` to verify LSP and tool installations
2. Run `:Lazy profile` to check for slow startup times
3. Test that filetypes are detected correctly
4. Verify autocmds trigger as expected with `:autocmd FileType`

## Development Commands

### Code Formatting
```bash
stylua .
```
Formats all Lua files using StyLua (if stylua.toml is present).

### Plugin Management
Within Neovim:
- `:Lazy` - Open lazy.nvim UI to view, update, and manage plugins
- `:Lazy update` - Update all plugins
- `:Lazy sync` - Install missing plugins and update existing ones
- `:Lazy check` - Check for plugin updates
- `:Lazy profile` - Profile plugin startup times

### Testing Configuration
```bash
nvim --headless "+Lazy! sync" +qa  # Install/sync plugins without opening UI
nvim -u NONE  # Start Neovim without any config (for troubleshooting)
```

## Plugin Loading Strategy

- Plugins load during startup unless explicitly marked `lazy = true`
- Plugins can be lazy-loaded based on:
  - Events (e.g., `event = "VeryLazy"`)
  - Commands (e.g., `cmd = "ClaudeCode"`)
  - Keymaps (e.g., `keys = { "<leader>ac" }`)
  - File types (e.g., `ft = "lua"`)

## Key Configuration Features

### Auto-Reload
- Files are automatically reloaded when changed on disk (configured in autocmds.lua)
- Triggered on `FocusGained`, `BufEnter`, `CursorHold`, `CursorHoldI` events

### Spell Checking
- Configured in options.lua with `spelllang` and `spellfile`
- Auto-enabled for specific filetypes via autocmds (gitcommit, markdown, text, org)

### Claude Code Integration
- Uses snacks.nvim terminal provider
- Diff views open in new tabs with vertical layout
- Terminal split on right side (40% width)
- Keymaps under `<leader>a` prefix (ai group)

## Documentation Guidelines

When adding, modifying, or configuring plugins:

1. **Update README.md** to reflect new functionality:
   - Add new keybindings to the "Essential Keymaps" section
   - Document new features in the "Features" section with clear descriptions
   - Update the plugin table (see below) with any new plugins
   - Add relevant tips to "Tips & Troubleshooting" if the feature has common gotchas

2. **Plugin Table Format** (in README.md):
   - Each plugin should be listed with: Name, Purpose, and When to Use It
   - Focus on user-facing functionality, not implementation details
   - Explain the value proposition clearly for new users

3. **Documentation Standards**:
   - Use `<Space>` notation for leader key, not `<leader>`
   - Include both the keymap and a description of what it does
   - Group related keymaps together (e.g., all git commands under "Git")
   - Provide context for why a feature is useful, not just what it does

4. **When to Update Documentation**:
   - Adding a new plugin to `lua/plugins/`
   - Modifying significant plugin configuration (especially keymaps)
   - Changing options in `lua/config/options.lua` that affect user experience
   - Adding custom keymaps in `lua/config/keymaps.lua`

5. **Keep User-Focused**:
   - Write for experienced Vim users who are new to Neovim
   - Explain concepts that differ from vanilla Vim
   - Provide practical examples and workflows

## Important Reminders

- This is a **Kickstart-based** configuration, not LazyVim
- **No Mason** - LSP servers and tools are installed separately (not managed by this config)
- **Snacks.nvim** provides core UI utilities (dashboard, explorer, notifications, terminal)
- **Leader key** is `<Space>` (configured in lua/config/lazy.lua)
- **Options.lua** contains some keymaps from Kickstart - this is acceptable for this config style