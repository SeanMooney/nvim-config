return {
  {
    "stevearc/conform.nvim",
    opts = {
      -- Disable format on save
      format_on_save = false,
    },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
  },
}