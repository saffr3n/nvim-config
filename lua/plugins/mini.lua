return {
  'nvim-mini/mini.nvim',
  config = function()
    require('mini.ai').setup()
    require('mini.surround').setup()
    require('mini.pairs').setup({
      mappings = {
        ['<'] = { action = 'open', pair = '<>', neigh_pattern = '[%w_]' },
        ['>'] = { action = 'close', pair = '<>' },
      },
    })

    local statusline = require('mini.statusline')
    statusline.setup()
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function() return '%2l:%-2v' end

    local diff = require('mini.diff')
    require('config.utils').map('n', '<Leader>tg', diff.toggle_overlay)
    diff.setup({ view = { style = 'sign' } })
  end,
}
