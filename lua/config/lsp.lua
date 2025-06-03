-- ~/.config/nvim/lua/config/lsp.lua
local lspconfig = require 'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require 'cmp_nvim_lsp'

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Import your custom TS setup
local custom_ts_setup = require 'custom.ts'

local on_attach = function(client, bufnr)
  -- Standard keymaps that Kickstart usually sets up
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Go to Definition' })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Go to Declaration' })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'Go to References' })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'Go to Implementation' })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover Documentation' })
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Help' })
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename Symbol' })
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code Action' })
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = bufnr, desc = 'Format Document' })

  -- Custom setup for specific clients
  if client.name == 'typescript-language-server' then -- Updated client name
    custom_ts_setup.setup_tsserver_client(client, bufnr)
  elseif client.name == 'eslint-lsp' then -- Updated client name
    custom_ts_setup.setup_eslint_client(client, bufnr)
  end
end

require('mason-lspconfig').setup_handlers {
  function(server_name)
    -- This conditional logic ensures that if `typescript-language-server` or `eslint-lsp` are
    -- being set up by Mason-LSPConfig, they get *our* specific `on_attach` functions,
    -- otherwise they get the default Kickstart `on_attach`.
    if server_name == 'typescript-language-server' or server_name == 'eslint-lsp' then
      lspconfig[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        -- You can add common settings for these specific servers here if needed
      }
    else
      -- Default setup for all other LSP servers handled by Mason-LSPConfig
      lspconfig[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }
    end
  end,
}
