
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
 {
  "lewis6991/gitsigns.nvim",
require("gitsigns").setup {
  current_line_blame = true, -- Shows blame info inline
},
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup {
      signs = {
        add          = { hl = "GitSignsAdd",    text = "▎", numhl = "GitSignsAddNr" },
        change       = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr" },
        delete       = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr" },
        topdelete    = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr" },
        changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr" },
      },
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    }
  end,
},
}



return plugins
