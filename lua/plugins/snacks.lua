---@module 'lazy'
---@type LazyPluginSpec
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    dashboard = {},
    explorer = {},
    indent = {},
    input = {},
    notifier = {},
    picker = {},
    scope = {},
    statuscolumn = { folds = { open = true, git_hl = true } },
    words = {},
  },
  keys = {
    { '<leader>e', function() Snacks.explorer({ auto_close = false, hidden = true, ignored = true }) end },
    { '<leader>gg', function() Snacks.lazygit() end },
    { '<leader>t', function() Snacks.terminal() end },
    { '<leader>sh', function() Snacks.picker.help() end },
    { '<leader>sk', function() Snacks.picker.keymaps() end },
    { '<leader>sf', function() Snacks.picker.smart() end },
    { '<leader>ss', function() Snacks.picker.pickers() end },
    { '<leader>sw', function() Snacks.picker.grep_word() end, mode = { 'n', 'v' } },
    { '<leader>sg', function() Snacks.picker.grep() end },
    { '<leader>sd', function() Snacks.picker.diagnostics() end },
    { '<leader>sr', function() Snacks.picker.resume() end },
    { '<leader>s.', function() Snacks.picker.recent() end },
    { '<leader>/', function() Snacks.picker.lines() end },
    { '<leader>s/', function() Snacks.picker.grep_buffers() end },
    { '<leader><leader>', function() Snacks.picker.buffers() end },
    { '<leader>sn', function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end },
  },
}
