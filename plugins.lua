local overrides = require "custom.configs.overrides"

local plugins = {
 {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "mfussenegger/nvim-dap",
  config= function(_, _)
      require("core.utils").load_mappings("dap")
    end,
  },

  {   "jay-babu/mason-nvim-dap.nvim",
    event= "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap"
    },
    opts={
      handler={},
      ensure_installed={
        "codelldb"
      }
    }
  },
  {
    "williamboman/mason.nvim",
    opts={
      ensure_installed = {
        "clangd",
        "gopls",
        "rust-analyzer",
        "pyright",
        "clang-format",
        "codelldb"
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event= "VeryLazy",
    opts= function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "leoluz/nvim-dap-go",
    ft="go",
    dependencies = "mfussengger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
    end
  },
}



return plugins



