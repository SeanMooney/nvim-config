return {
  {
    "coder/claudecode.nvim",
    lazy = true, -- Load only when keymaps are used
    dependencies = {
      "snacks.nvim", -- LazyVim includes this
    },
    opts = {
      -- Use snacks.nvim for terminal integration
      terminal = {
        provider = "snacks",
        auto_close = false, -- Keep terminal open after Claude exits
        split_side = "right", -- Terminal on right side
        split_width_percentage = 40, -- 40% width split for better readability
      },
      -- Use git project root as working directory
      git_repo_cwd = true,
      auto_start = true, -- Automatically start Claude server when needed
      -- Diff view customizations
      diff = {
        auto_close_on_accept = true, -- Close diff view after accepting
        vertical_split = true, -- Use vertical split for diffs
        resize_on_diff = false, -- Don't resize terminal when opening diffs
      },
    },
    keys = {
      -- which-key group
      { "<leader>a", group = "ai", icon = "󰧑" },
      {
        "<leader>ac",
        "<cmd>ClaudeCode<cr>",
        desc = "Toggle",
        mode = { "n", "v" },
      },
      {
        "<leader>af",
        "<cmd>ClaudeCodeFocus<cr>",
        desc = "Focus",
        mode = "n",
      },
      {
        "<leader>as",
        "<cmd>ClaudeCodeSend<cr>",
        desc = "Send Selection",
        mode = "v",
      },
      {
        "<leader>aa",
        "<cmd>ClaudeCodeDiffAccept<cr>",
        desc = "Accept Diff",
        mode = "n",
      },
      {
        "<leader>ar",
        "<cmd>ClaudeCodeDiffDeny<cr>",
        desc = "Reject Diff",
        mode = "n",
      },
      {
        "<leader>aR",
        "<cmd>ClaudeCodeRestart<cr>",
        desc = "Restart",
        mode = "n",
      },
      {
        "<leader>ai",
        "<cmd>ClaudeCodeStatus<cr>",
        desc = "Status",
        mode = "n",
      },
    },
  },
}