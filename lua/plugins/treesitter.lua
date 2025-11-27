---@module 'lazy'
---@type LazyPluginSpec
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'master',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  ---@module 'nvim-treesitter.configs'
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    ensure_installed = require('config.tools').ensure_installed.treesitter,
    auto_install = false,
    highlight = { enable = true, additional_vim_regex_highlighting = false },
  },
}
