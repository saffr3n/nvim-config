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
    picker = { sources = { explorer = { auto_close = true } } },
    scope = {},
    terminal = {},
    words = {},
  },
  keys = {
    { '<Leader><Space>', function() Snacks.picker.pickers() end },
    { '<Leader>e', function() Snacks.explorer() end },
    { '<Leader>g', function() Snacks.lazygit.open() end },
    { '<Leader>t', function() Snacks.terminal.toggle() end },
    { '<Leader>sb', function() Snacks.picker.buffers() end },
    { '<Leader>sc', function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end },
    { '<Leader>sd', function() Snacks.picker.diagnostics_buffer() end },
    { '<Leader>sD', function() Snacks.picker.diagnostics() end },
    { '<Leader>sf', function() Snacks.picker.files() end },
    { '<Leader>sg', function() Snacks.picker.grep() end },
    { '<Leader>sh', function() Snacks.picker.help() end },
    { '<Leader>sn', function() Snacks.picker.notifications() end },
    { '<Leader>sr', function() Snacks.picker.resume() end },
    { '<Leader>sw', function() Snacks.picker.grep_word() end },
    { '<Leader>s/', function() Snacks.picker.lines() end },
    { '<Leader>s?', function() Snacks.picker.grep_buffers() end },
    { '[w', function() Snacks.words.jump(-1, true) end },
    { ']w', function() Snacks.words.jump(1, true) end },
  },
}
