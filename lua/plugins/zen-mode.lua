return {
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 0.95,
        width = 120, -- Width of the Zen window
        height = 1, -- Height (1 = 100% of editor height)
        options = {
          signcolumn = "no", -- Disable signcolumn
          number = false, -- Disable number column
          relativenumber = false, -- Disable relative numbers
          cursorline = false, -- Disable cursorline
          cursorcolumn = false, -- Disable cursor column
          foldcolumn = "0", -- Disable fold column
          list = false, -- Disable whitespace characters
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false, -- Disables the ruler text in the cmd line area
          showcmd = false, -- Disables the command in the last line of the screen
          laststatus = 0, -- Turn off the statusline in zen mode
        },
        twilight = { enabled = true }, -- Enable Twilight integration
        gitsigns = { enabled = false }, -- Disables git signs
        tmux = { enabled = false }, -- Disables the tmux statusline
      },
      on_open = function()
        vim.opt.spell = true -- Enable spell checking in zen mode
      end,
    },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
  },
  {
    "folke/twilight.nvim",
    cmd = "Twilight",
    opts = {
      dimming = {
        alpha = 0.25, -- Amount of dimming
        color = { "Normal", "#ffffff" },
        term_bg = "#000000",
        inactive = false, -- When true, other windows will be fully dimmed
      },
      context = 10, -- Amount of lines to show around the cursor
      treesitter = true, -- Use treesitter for better context detection
      expand = { -- Expand treesitter nodes
        "function",
        "method",
        "table",
        "if_statement",
      },
    },
    keys = {
      { "<leader>uT", "<cmd>Twilight<cr>", desc = "Twilight" },
    },
  },
}