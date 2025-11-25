local lsp_servers = {
  cssls = {},
  emmet_language_server = { filetypes = { 'html', 'css', 'ejs', 'javascriptreact' } },
  html = { filetypes = { 'html', 'ejs' } },
  lua_ls = {},
  prismals = {},
  ts_ls = {},
}

local dap = {
  ['js-debug-adapter'] = function()
    local dap = require('dap')

    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = { command = 'js-debug-adapter', args = { '${port}' } },
    }

    for _, lang in ipairs({ 'javascript', 'typescript' }) do
      dap.configurations[lang] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
      }
    end
  end,
}

local all_tools = vim.tbl_keys(lsp_servers)
vim.list_extend(all_tools, vim.tbl_keys(dap))

return {
  nvim_lspconfig = {
    servers = lsp_servers,
    ensure_installed = all_tools,
  },
  dap = {
    setup_debuggers = function()
      for _, setup in pairs(dap) do
        setup()
      end
    end,
  },
}
