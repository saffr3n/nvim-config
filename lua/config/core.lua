local map = require('config.utils').map

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
map('n', '<Esc>', vim.cmd.nohlsearch)
map('n', '<Leader>u', vim.cmd.Undotree)

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.statuscolumn = '%l%s%C'
vim.o.laststatus = 3
vim.o.showmode = false
vim.o.scrolloff = 8
vim.o.cursorline = true
vim.o.breakindent = true
vim.o.linebreak = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.winborder = 'rounded'
vim.o.pumborder = 'rounded'
vim.o.list = true
vim.o.listchars = 'trail:·,nbsp:·'
vim.o.fillchars = 'fold: ,foldopen:,foldclose:,foldsep: ,foldinner: '
vim.o.foldcolumn = '1'
vim.o.foldtext = ''
vim.o.foldlevel = 99
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.shiftwidth = 2
vim.o.softtabstop = -1
vim.o.expandtab = true
vim.o.confirm = true
vim.o.undofile = true
vim.o.backupcopy = 'yes'
vim.o.clipboard = 'unnamedplus'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'
-- vim.o.completeopt = 'menuone,noselect,fuzzy,popup'
-- vim.o.wildmode = 'noselect:lastused,full'

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function() vim.cmd.packadd('nvim.undotree') end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('yank-hl', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
