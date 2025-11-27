---@module 'lazy'
---@type LazyPluginSpec
return {
  'stevearc/conform.nvim',
  ---@module 'conform'
  ---@type conform.setupOpts
  opts = { formatters_by_ft = require('config.tools').formatters_by_ft },
  keys = {
    { '<Leader>f', function() require('conform').format({ async = true, lsp_format = 'fallback' }) end },
  },
}
