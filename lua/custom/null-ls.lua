-- ~/.config/nvim/lua/custom/null-ls.lua
local null_ls = require 'null-ls'
local M = {}

function M.setup()
  null_ls.setup {
    sources = {
      null_ls.builtins.formatting.prettier.with {
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'json',
        },
        extra_args = { '--tab-width', '2' },
      },
    },
    on_attach = function(client, bufnr)
      if client.supports_method 'textDocument/formatting' then
        vim.api.nvim_clear_autocmds {
          group = 'LspFormatting',
          buffer = bufnr,
        }
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('LspFormatting', {}),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format { bufnr = bufnr }
          end,
        })
      end
    end,
  }
end

return M
