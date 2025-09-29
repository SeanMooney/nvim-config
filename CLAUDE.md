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

## Best Practices

### File Organization
- **options.lua**: ONLY Neovim settings (`vim.opt.*`, `vim.g.*`). NO autocmds, NO function calls that set up behavior.
- **autocmds.lua**: ALL autocommands (`vim.api.nvim_create_autocmd`). Move autocmds out of options.lua.
- **keymaps.lua**: Custom keymaps that aren't plugin-specific. Plugin-specific keymaps should use the `keys` property in plugin specs.

### Mason Package Management
- **Centralize all tool installations** in `lua/plugins/mason.lua` with a single `ensure_installed` list
- **DO NOT** scatter `ensure_installed` across multiple plugin files (ansible.lua, bash.lua, etc.)
- Group packages by type (LSP servers, linters, formatters) with comments
- This makes it easy to audit what tools are installed and avoid duplicates

Example:
```lua
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- Language servers
        "ansible-language-server",
        "bash-language-server",
        -- Linters
        "shellcheck",
        "ansible-lint",
        -- Formatters
        "shfmt",
      },
    },
  },
}
```

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

**To add new LSP servers or tools:**
1. Add them to the `ensure_installed` table in `lua/plugins/mason.lua` (centralized location)
2. Configure the LSP server in the appropriate language-specific file (e.g., `lua/plugins/bash.lua`) using `nvim-lspconfig` opts with the `servers` table
3. Do NOT scatter `ensure_installed` lists across multiple plugin files

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
   - Write for experienced Vim users who are new to Neovim/LazyVim
   - Explain concepts that differ from vanilla Vim
   - Provide practical examples and workflows