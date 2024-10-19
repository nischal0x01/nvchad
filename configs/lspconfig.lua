local lspconfig = require("lspconfig")  -- Only require lspconfig once
local util = require("lspconfig/util")  -- Utilities for configuring root directories and more

-- Load common on_attach and capabilities from your base config
local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities

-- Common LSP settings
local servers = {
    clangd = {},  -- Default clangd configuration
    gopls = {     -- Custom configuration for gopls
        cmd = {"gopls"},
        filetypes = {"go", "gomod", "gowork", "gotmpl"},
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
            gopls = {
                completeUnimported = true,
                usePlaceholders = true,
                analyses = {
                    unusedparams = true,
                },
            },
        },
    },
}
-- Setup each server
for server, config in pairs(servers) do
    lspconfig[server].setup(vim.tbl_deep_extend("force", {
        on_attach = on_attach,
        capabilities = capabilities,
    }, config))
end
