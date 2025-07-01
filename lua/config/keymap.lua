vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<Esc>', vim.cmd.nohlsearch)

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
