-- ~/.config/nvim/lua/custom/null-ls.lua
local null_ls = require 'null-ls'
local M = {}

function M.setup()
  null_ls.setup {
    sources = {
      -- Prettier for formatting
      null_ls.builtins.formatting.prettier.with {
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'json',
          'css',
          'html',
          'yaml',
          'markdown',
        },
        extra_args = { '--tab-width', '2', '--single-quote', '--jsx-single-quote', '--print-width', '80' },
      },
      -- ESLint for diagnostics and auto-fixing (if configured)
      null_ls.builtins.diagnostics.eslint.with {
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        prefer_local = 'node_modules/.bin',
        args = { '--fix-dry-run', '--format=json', '--stdin', '--stdin-filename', '$FILENAME' },
        on_output = null_ls.builtins.diagnostics.eslint.diagnostics_on_output,
      },
    },
    on_attach = function(client, bufnr)
      if client.supports_method 'textDocument/formatting' then
        vim.api.nvim_clear_autocmds {
          group = 'LspFormatting',
          buffer = bufnr,
        }
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('LspFormatting', { clear = true }),
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
