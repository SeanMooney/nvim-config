-- Toggle between absolute and relative line numbers
vim.keymap.set("n", "<leader>uL", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle relative line numbers" })
