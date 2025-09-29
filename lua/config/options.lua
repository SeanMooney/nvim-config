-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Line numbers
vim.opt.relativenumber = false
vim.opt.number = true

-- Auto-reload files changed outside of Neovim (like Emacs auto-revert-mode)
vim.opt.autoread = true

-- Spell checking (enabled per-filetype in autocmds.lua)
vim.opt.spelllang = { "en_us" }
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
