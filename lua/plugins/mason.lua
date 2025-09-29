-- Centralized Mason package management
-- LSP servers, linters, and formatters are automatically installed
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- Language servers
        "ansible-language-server",
        "bash-language-server",
        "esbonio", -- reStructuredText/Sphinx LSP

        -- Linters
        "ansible-lint",
        "shellcheck",

        -- Formatters
        "shfmt",
      },
    },
  },
}