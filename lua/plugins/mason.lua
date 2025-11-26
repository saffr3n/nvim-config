return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'neovim/nvim-lspconfig',
    { 'mason-org/mason-lspconfig.nvim', opts = {} },
  },
  opts = { ensure_installed = require('config.tools').ensure_installed.mason },
}
