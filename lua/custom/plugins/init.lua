-- ~/.config/nvim/lua/custom/plugins/init.lua
return {
  -- Mason: LSP installer
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    config = function()
      require('mason').setup()
    end,
  },

  -- Mason-LSPConfig: Bridge between Mason and nvim-lspconfig
  {
    'williamboman/mason-lspconfig.nvim',
    after = 'mason.nvim',
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = {
          -- Updated LSP server names:
          'typescript-language-server', -- Official TypeScript LSP via Mason
          'eslint-lsp', -- Official ESLint LSP via Mason
        },
        automatic_setup = true,
      }
    end,
  },

  -- nvim-lspconfig: Core LSP configuration (dependency for mason-lspconfig)
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
  },

  -- null-ls: For external formatters/linters like Prettier
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('custom.null-ls').setup()
    end,
  },

  -- typescript.nvim: Enhance TypeScript experience
  {
    'jose-elias-alvarez/typescript.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
  },
}
