return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Use esbonio for Sphinx projects or textLSP for general RST
        esbonio = {}, -- Sphinx-aware RST LSP
      },
    },
  },

  -- Treesitter RST support
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "rst" })
      return opts
    end,
  },

  -- Optional: RST preview plugin
  {
    "gu-fan/riv.vim",
    ft = "rst",
    enabled = false, -- Enable if you want rst-specific features
  },
}