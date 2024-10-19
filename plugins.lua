local overrides = require "custom.configs.overrides"

local plugins = {
  -- nvim-dap-ui and its dependencies
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { 
      "mfussenegger/nvim-dap",    -- Debug Adapter Protocol (DAP)
      "nvim-neotest/nvim-nio"     -- Add nvim-nio as a required dependency
    },
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

  -- nvim-dap
  {
    "mfussenegger/nvim-dap",
    config = function(_, _)
      require("core.utils").load_mappings("dap")
    end,
  },

  -- mason-nvim-dap with dependencies
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap"
    },
    opts = {
      handler = {},
      ensure_installed = { "codelldb" }
    }
  },

  -- Mason to ensure required tools are installed
  {
    "williamboman/mason.nvim",
    opts = {
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

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  -- Treesitter configuration with overrides
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  -- null-ls with formatting and other capabilities
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      -- Define sources and options for null-ls
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.gofumpt,
          null_ls.builtins.formatting.goimports_reviser,
          null_ls.builtins.formatting.golines,
          null_ls.builtins.formatting.clang_format,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            -- Clear existing autocmds for the buffer
            vim.api.nvim_clear_autocmds({
              group = augroup,
              buffer = bufnr,
            })

            -- Create a new autocmd for formatting before saving
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  bufnr = bufnr,
                  -- You can specify a timeout or additional options here
                  timeout_ms = 2000,
                })
              end,
            })
          end
        end,
      })
    end,
  },

  -- Go-specific DAP configuration
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function(_, opts)
      require("dap-go").setup(opts)
    end
  },
}

return plugins
