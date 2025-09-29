return {
  -- Detect Ansible files and set filetype
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ansiblels = {
          filetypes = { "yaml.ansible", "ansible" },
          settings = {
            ansible = {
              python = {
                interpreterPath = "python3",
              },
              ansible = {
                path = "ansible",
              },
              validation = {
                enabled = true,
                lint = {
                  enabled = true,
                  path = "ansible-lint",
                },
              },
            },
          },
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = {
          "*/playbooks/*.yml",
          "*/playbooks/*.yaml",
          "*/roles/*/tasks/*.yml",
          "*/roles/*/handlers/*.yml",
          "*/group_vars/*",
          "*/host_vars/*",
        },
        callback = function()
          vim.bo.filetype = "yaml.ansible"
        end,
      })
    end,
  },
}