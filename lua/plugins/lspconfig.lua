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
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    local tools = require('config.tools').nvim_lspconfig
    require('mason-tool-installer').setup({ ensure_installed = tools.ensure_installed })
    require('mason-lspconfig').setup({
      ensure_installed = {},
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = tools.servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', server.capabilities or {}, capabilities)
          require('lspconfig')[server_name].setup(server)
        end,
      },
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local clientSupportsMethod = function(method)
          return client ~= nil and client:supports_method(method, event.buf)
        end

        local picker = require('snacks').picker
        local map = function(keys, func)
          vim.keymap.set('n', keys, func, { buffer = event.buf })
        end

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
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end)
        end

        if clientSupportsMethod(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local hl_group = vim.api.nvim_create_augroup('lsp-hl', { clear = true })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = hl_group,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = hl_group,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = 'lsp-hl', buffer = event2.buf })
            end,
          })
        end

        vim.diagnostic.config({
          severity_sort = true,
          jump = { float = true },
          float = { border = 'rounded', source = 'if_many' },
          virtual_text = { source = 'if_many', spacing = 2 },
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = '󰅚 ',
              [vim.diagnostic.severity.WARN] = '󰀪 ',
              [vim.diagnostic.severity.INFO] = '󰋽 ',
              [vim.diagnostic.severity.HINT] = '󰌶 ',
            },
          },
        })
      end,
    })
  end,
}
