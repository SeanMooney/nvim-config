return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "dockerfile",
        "go",
        "gomod",
        "gowork",
        "json",
        "jsonc",
        "markdown",
        "markdown_inline",
        "python",
        "yaml",
      })
      return opts
    end,
  },
}