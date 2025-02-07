
local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "clangd",
        "typescript-language-server",
        "eslint-lsp",
        "gopls",
        "rust-analyzer",
        "gofumpt",
        "golines",
        "goimports-revisor",
      },
    },
  },
  {
"neovim/nvim-lspconfig",
    config=function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
 {
    "jose-elias-alvarez/null-ls.nvim",
    ft = "go",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
{
    "mfussenegger/nvim-dap",
    init = function()
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "dreamsofcode-io/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
{
  "kdheepak/lazygit.nvim",
  cmd = { "LazyGit" },
  config = function()
    vim.api.nvim_set_keymap("n", "<leader>lg", ":LazyGit<CR>", { noremap = true, silent = true })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
},
}


return plugins
