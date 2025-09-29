return {
  {
    "coder/claudecode.nvim",
    dependencies = {
      "snacks.nvim", -- LazyVim includes this
    },
    opts = {
      -- Use snacks.nvim for terminal integration
      terminal = {
        provider = "snacks",
      },
      -- Use git project root as working directory
      working_directory = "git_root",
    },
    keys = {
      {
        "<C-,>",
        "<cmd>ClaudeCode<cr>",
        desc = "Toggle Claude Code",
        mode = { "n", "v" },
      },
      {
        "<leader>cc",
        "<cmd>ClaudeCode<cr>",
        desc = "Toggle Claude Code",
        mode = { "n", "v" },
      },
      {
        "<leader>cs",
        "<cmd>ClaudeCodeSend<cr>",
        desc = "Send selection to Claude",
        mode = "v",
      },
      {
        "<leader>ca",
        "<cmd>ClaudeCodeDiffAccept<cr>",
        desc = "Accept Claude diff",
        mode = "n",
      },
      {
        "<leader>cd",
        "<cmd>ClaudeCodeDiffDeny<cr>",
        desc = "Deny Claude diff",
        mode = "n",
      },
    },
  },
}