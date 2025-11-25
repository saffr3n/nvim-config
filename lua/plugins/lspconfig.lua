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
    local tools = require('config.tools').nvim_lspconfig
    require('mason-tool-installer').setup({ ensure_installed = tools.ensure_installed })
    for name, config in pairs(tools.servers) do
      if not vim.tbl_isempty(config) then
        vim.lsp.config(name, config)
      end
    end
    require('mason-lspconfig').setup({ ensure_installed = {}, automatic_enable = true })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local clientSupportsMethod = function(method) return client ~= nil and client:supports_method(method, event.buf) end

        local picker = require('snacks').picker
        local map = function(keys, func) vim.keymap.set('n', keys, func, { buffer = event.buf }) end

        map('grn', vim.lsp.buf.rename)
        map('gra', vim.lsp.buf.code_action)
        map('grD', vim.lsp.buf.declaration)
        map('grd', picker.lsp_definitions)
        map('grr', picker.lsp_references)
        map('gri', picker.lsp_implementations)
        map('grt', picker.lsp_type_definitions)
        map('gO', picker.lsp_symbols)
        map('gW', picker.lsp_workspace_symbols)

        if clientSupportsMethod(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map(
            '<leader>th',
            function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })) end
          )
        end

        map('<leader>td', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end)

        local function set_virtual_text(enable)
          local icons = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          }

          vim.diagnostic.config({
            update_in_insert = true,
            severity_sort = true,
            signs = { text = icons },
            float = { border = 'rounded', source = 'if_many' },
            virtual_text = enable
                and {
                  source = 'if_many',
                  spacing = 2,
                  format = function(diagnostic) return (icons[diagnostic.severity] or '') .. diagnostic.message end,
                }
              or false,
            virtual_lines = not enable
                and {
                  format = function(diagnostic) return (icons[diagnostic.severity] or '') .. diagnostic.message end,
                }
              or false,
          })
        end

        vim.api.nvim_create_autocmd('InsertEnter', {
          callback = function() set_virtual_text(true) end,
        })

        vim.api.nvim_create_autocmd('InsertLeave', {
          callback = function() set_virtual_text(false) end,
        })
      end,
    })
  end,
}
