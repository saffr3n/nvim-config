---@module 'lazy'
---@type LazyPluginSpec
return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    dashboard = {
      preset = {
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ':lua Snacks.dashboard.pick("files")' },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = 'g', desc = 'Find Text', action = ':lua Snacks.dashboard.pick("live_grep")' },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ':lua Snacks.dashboard.pick("oldfiles")' },
          { icon = ' ', key = 'c', desc = 'Config', action = ':lua Snacks.dashboard.pick("files", { cwd = vim.fn.stdpath("config") })' },
          { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          { icon = ' ', key = 'l', desc = 'Lazygit', action = ':lua Snacks.lazygit.open()' },
          { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = '󰰎 ', key = 'M', desc = 'Mason', action = ':Mason' },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
    },
    explorer = {},
    indent = {
      indent = { char = '▏' },
      scope = { char = '▏' },
      animate = { enabled = false },
    },
    input = {},
    lazygit = {},
    notifier = {},
    picker = {},
    scope = {},
    terminal = {},
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
