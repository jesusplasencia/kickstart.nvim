-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
-- ~/.config/nvim/lua/custom/plugins/init.lua
return {
  -- mason installer for LSP servers
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },

  -- bridge mason + lspconfig
  {
    'williamboman/mason-lspconfig.nvim',
    after = 'mason.nvim',
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = { 'tsserver', 'eslint' },
      }
    end,
  },

  -- prettier via null-ls
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('custom.null-ls').setup()
    end,
  },

  -- extra TS goodies
  {
    'jose-elias-alvarez/typescript.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      require('custom.ts').setup()
    end,
  },
}
