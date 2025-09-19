return {
  'nvim-mini/mini.nvim',
  config = function()
    require('mini.ai').setup()
    require('mini.surround').setup()

    local statusline = require('mini.statusline')
    statusline.setup()
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function() return '%2l:%-2v' end
  end,
}
