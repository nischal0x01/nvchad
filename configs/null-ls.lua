local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Define sources and options for null-ls
local opts = {
  sources = {
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.goimports_reviser,
    null_ls.builtins.formatting.golines,
    null_ls.builtins.formatting.clang_format,
  },
  
  -- Setup formatting on save (BufWritePre)
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
            -- You can specify a timeout or any additional options here if needed
            timeout_ms = 2000,
          })
        end,
      })
    end
  end,
}

-- Setup null-ls
null_ls.setup(opts)
