local tools = require('config.tools').null_ls

local dependencies = {
  'nvim-lua/plenary.nvim',
  'nvimtools/none-ls-extras.nvim',
}
vim.list_extend(dependencies, tools.dependencies)

return {
  'nvimtools/none-ls.nvim',
  dependencies = dependencies,
  config = function()
    local null_ls = require('null-ls')
    null_ls.setup({ sources = tools.get_sources() })
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format({ filter = function(c) return c.name == 'null-ls' end })
    end)
  end,
}
