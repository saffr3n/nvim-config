---@module 'lazy'
---@type LazyPluginSpec
return {
  'neovim/nvim-lspconfig',
  lazy = false,
  dependencies = { { 'j-hui/fidget.nvim', opts = {} } },
  config = function()
    local servers = require('config.tools').lsp_servers
    for name, config in pairs(servers) do
      if not vim.tbl_isempty(config) then
        config = vim.tbl_deep_extend('force', vim.lsp.config[name], config)
        vim.lsp.config(name, config)
      end
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      ---@param event vim.api.keyset.create_autocmd.callback_args|{ data: { client_id: integer } }
      callback = function(event)
        ---@param mode string|string[]
        ---@param lhs string
        ---@param rhs string|function
        local function map(mode, lhs, rhs) require('config.utils').map(mode, lhs, rhs, { buffer = event.buf }) end

        map('n', '<Leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)
        map('n', 'grd', Snacks.picker.lsp_definitions)
        map('n', 'grD', Snacks.picker.lsp_declarations)
        map('n', 'grr', Snacks.picker.lsp_references)
        map('n', 'gri', Snacks.picker.lsp_implementations)
        map('n', 'grt', Snacks.picker.lsp_type_definitions)
        map('n', 'gO', Snacks.picker.lsp_symbols)
        map('n', 'gW', Snacks.picker.lsp_workspace_symbols)

        vim.diagnostic.config({ severity_sort = true, virtual_text = true })
      end,
    })
  end,
}
