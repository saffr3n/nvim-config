return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      changedelete = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
    },
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(mode, keys, func)
        vim.keymap.set(mode, keys, func, { buffer = bufnr })
      end

      map('n', ']g', function()
        gitsigns.nav_hunk('next')
      end)
      map('n', '[g', function()
        gitsigns.nav_hunk('prev')
      end)

      map('v', '<leader>gs', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end)
      map('v', '<leader>gr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end)

      map('n', '<leader>gs', gitsigns.stage_hunk)
      map('n', '<leader>gr', gitsigns.reset_hunk)
      map('n', '<leader>gS', gitsigns.stage_buffer)
      map('n', '<leader>gR', gitsigns.reset_buffer)
      map('n', '<leader>gp', gitsigns.preview_hunk)
    end,
  },
}
