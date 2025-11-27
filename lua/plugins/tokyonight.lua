---@module 'lazy'
---@type LazyPluginSpec
return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    local bg ---@type (string|integer)?
    local function toggle_bg()
      local hl = vim.api.nvim_get_hl(0, { name = 'Normal' }) --[[@as vim.api.keyset.highlight]]
      hl.bg = not hl.bg and bg or nil
      vim.api.nvim_set_hl(0, 'Normal', hl)
      vim.api.nvim_set_hl(0, 'NormalNC', hl)
    end

    require('tokyonight').setup({
      style = 'night',
      styles = { comments = { italic = false } },
      on_highlights = function(hl)
        bg = hl.Normal.bg
        hl.PmenuBorder = 'FloatBorder'
        hl.WinSeparator = 'FloatBorder'
        hl.CursorLineFold = 'Constant'
      end,
    })

    vim.cmd.colorscheme('tokyonight')
    require('config.utils').map('n', '<Leader>tb', toggle_bg)
    toggle_bg()
  end,
}
