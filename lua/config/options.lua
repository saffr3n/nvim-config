vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = 'yes'

vim.o.foldcolumn = '1'
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevel = 99
vim.o.foldtext = ''

vim.o.statuscolumn = '%l%s%C'
vim.o.laststatus = 3
vim.o.showmode = false

vim.o.winborder = 'rounded'
vim.o.pumborder = 'rounded'

vim.o.inccommand = 'split'

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.confirm = true
vim.o.backupcopy = 'yes'

vim.o.shiftwidth = 2
vim.o.softtabstop = -1
vim.o.expandtab = true

vim.o.breakindent = true
vim.o.linebreak = true

vim.o.list = true
vim.o.listchars = 'trail:·,nbsp:·'
vim.o.fillchars = 'fold: ,foldopen:,foldclose:,foldsep: ,foldinner: '

vim.o.cursorline = true

vim.o.scrolloff = 8

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.undofile = true

vim.o.clipboard = 'unnamedplus'

-- vim.o.completeopt = 'menuone,noselect,fuzzy,popup'
-- vim.o.wildmode = 'noselect:lastused,full'

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('yank-hl', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
