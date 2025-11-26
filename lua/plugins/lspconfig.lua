return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    'saghen/blink.cmp',
  },
  config = function()
    local tools = require('config.tools')
    require('mason-tool-installer').setup({ enuree_installed = tools.ensure_installed.mason })
    for name, config in pairs(tools.lsp_servers) do
      if not vim.tbl_isempty(config) then
        config = vim.tbl_deep_extend('force', vim.lsp.config[name], config)
        vim.lsp.config(name, config)
      end
    end
    require('mason-lspconfig').setup({ ensure_installed = {}, automatic_enable = true })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
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
