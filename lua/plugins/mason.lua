---@module 'lazy'
---@type LazyPluginSpec
return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  lazy = false,
  dependencies = {
    { 'mason-org/mason.nvim', opts = { ui = { backdrop = 100 } } },
    'neovim/nvim-lspconfig',
    { 'mason-org/mason-lspconfig.nvim', opts = {} },
  },
  ---@type {
  ---  ensure_installed?: (string|{ [0]: string, version?: string, auto_update?: boolean, condition?: fun(): boolean })[],
  ---  auto_update?: boolean,
  ---  run_on_start?: boolean,
  ---  start_delay?: integer,
  ---  debounce_hours?: number,
  ---  integrations?: { ['mason-lspconfig']?: boolean, ['mason-null-ls']?: boolean, ['mason-nvim-dap']?: boolean },
  ---}
  opts = { ensure_installed = require('config.tools').ensure_installed.mason },
}
