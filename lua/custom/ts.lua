-- ~/.config/nvim/lua/custom/ts.lua
local lspconfig = require 'lspconfig'
local ts_utils = require 'typescript'
local M = {}

function M.setup()
  -- disable tsserver formatting in favor of prettier
  lspconfig.tsserver.setup {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      ts_utils.setup { server = { on_attach = ts_utils.on_attach } }
      ts_utils.setup_client(client)
    end,
  }

  -- optional: enable eslint LSP (it can auto‐fix on save)
  lspconfig.eslint.setup {
    on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = true
    end,
  }
end

return M
