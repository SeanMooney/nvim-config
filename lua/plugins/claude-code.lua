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
        auto_close = true, -- Close terminal when Claude exits
        split_side = "right", -- Terminal on right side
        split_width_percentage = 0.40, -- 40% width split for better readability
      },
      -- Use git project root as working directory
      git_repo_cwd = true,
      auto_start = true, -- Automatically start Claude server when needed
      -- Diff view customizations
      diff_opts = {
        auto_close_on_accept = true, -- Close diff view after accepting
        auto_close_on_deny = true, -- Close diff view after rejecting
        vertical_split = true, -- Use vertical split for diffs
        open_in_current_tab = true, -- Open diffs in current tab
        keep_terminal_focus = false, -- Focus diff view when opened
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