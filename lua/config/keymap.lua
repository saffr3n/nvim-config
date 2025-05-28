vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<Esc>', vim.cmd.nohlsearch)

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

-- Terminal toggle
local term_win = nil
local term_buf = nil

local function termToggle(height)
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.cmd.hide()
  else
    vim.cmd('horizontal new')
    vim.cmd('resize ' .. height)
    local new_buf = vim.api.nvim_get_current_buf()
    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
      vim.cmd('buffer ' .. term_buf)
      vim.cmd('bd ' .. new_buf)
    else
      vim.cmd.term()
      term_buf = vim.api.nvim_get_current_buf()
    end
    term_win = vim.api.nvim_get_current_win()
    vim.cmd('startinsert!')
  end
end

vim.keymap.set('n', '<leader>t', function()
  termToggle(16)
end)
