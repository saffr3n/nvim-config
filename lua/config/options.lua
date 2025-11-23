vim.o.mouse = 'a'

vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = 'yes'

vim.o.foldcolumn = '1'
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevel = 99
vim.o.foldtext = ''

vim.o.showmode = false

vim.o.inccommand = 'split'

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.confirm = true
vim.o.backupcopy = 'yes'

vim.o.breakindent = true
vim.o.linebreak = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.cursorline = true

vim.o.scrolloff = 8

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.undofile = true

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('hl-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
