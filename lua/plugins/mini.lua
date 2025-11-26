return {
  'nvim-mini/mini.nvim',
  config = function()
    require('mini.icons').setup()
    require('mini.ai').setup()
    require('mini.surround').setup()
    require('mini.git').setup()
    require('mini.pairs').setup({
      mappings = {
        ['<'] = { action = 'open', pair = '<>', neigh_pattern = '[%w_]' },
        ['>'] = { action = 'close', pair = '<>' },
      },
    })

    local diff = require('mini.diff')
    require('config.utils').map('n', '<Leader>tg', diff.toggle_overlay)
    diff.setup()

    local statusline = require('mini.statusline')
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function() return '%l:%v' end
    statusline.setup()
  end,
}
