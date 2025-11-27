local linters_by_ft = require('config.tools').linters_by_ft

---@module 'lazy'
---@type LazyPluginSpec
return {
  'mfussenegger/nvim-lint',
  ft = vim.tbl_keys(linters_by_ft),
  config = function()
    local lint = require('lint')
    lint.linters_by_ft = linters_by_ft
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
      group = vim.api.nvim_create_augroup('lint', { clear = false }),
      callback = function(event)
        -- Hack! This sets cwd to the current file's dir, in order to force linters to search for the closest config.
        -- Useful for monorepos, but obviously may not work for some linters that don't do that.
        local cwd = vim.fn.fnamemodify(event.file, ':h')
        lint.try_lint(nil, { cwd = cwd })
      end,
    })
  end,
}
