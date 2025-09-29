-- Optional: Enhanced Python REPL integration
-- Requires tmux for vim-slime to work
return {
  -- Send code to Python REPL (iPython, Python, etc.)
  {
    "jpalardy/vim-slime",
    ft = "python",
    enabled = false, -- Enable this if you use tmux for REPL workflows
    config = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_python_ipython = 1
    end,
  },
}