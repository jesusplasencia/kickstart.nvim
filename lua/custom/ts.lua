-- ~/.config/nvim/lua/custom/ts.lua
local lspconfig = require 'lspconfig'
local ts_utils = require 'typescript' -- This is the typescript.nvim plugin

local M = {}

-- Function to set up typescript-language-server client specific configurations
function M.setup_tsserver_client(client, bufnr)
  -- Disable typescript-language-server's built-in formatter, let null-ls (prettier) handle it
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  -- Hook into typescript.nvim utility functions
  ts_utils.setup {
    server = {
      on_attach = ts_utils.on_attach, -- Use typescript.nvim's on_attach for keybinds etc.
    },
    disable_formatting = true, -- Also tell typescript.nvim not to format
  }
  ts_utils.setup_client(client)

  -- You can add typescript-language-server specific keymaps or logic here if needed
end

-- Function to set up eslint-lsp client specific configurations
function M.setup_eslint_client(client, bufnr)
  -- eslint-lsp can handle formatting (e.g., --fix), so leave this enabled if you want it
  client.server_capabilities.documentFormattingProvider = true

  -- You can add eslint-lsp specific keymaps or logic here
  -- Example: auto-fix on save via LSP (though null-ls prettier handles primary formatting)
  -- vim.api.nvim_create_autocmd("BufWritePre", {
  --   group = vim.api.nvim_create_augroup("LspEslintFix", { clear = true }),
  --   buffer = bufnr,
  --   callback = function()
  --     vim.lsp.buf.code_action({ context = { only = { "source.fixAll.eslint" } }, apply = true, bufnr = bufnr })
  --   end,
  -- })
end

return M
