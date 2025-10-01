-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Auto-reload files when changed on disk (like Emacs auto-revert-mode)
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

-- Auto-enable spell checking for specific file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text", "org" },
  callback = function()
    vim.opt_local.spell = true
  end,
})
