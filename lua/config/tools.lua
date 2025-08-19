local lsp_servers = {
  cssls = {},
  html = {},
  lua_ls = {},
  ts_ls = {},
  emmet_language_server = {},
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

local null_tools = {
  cspell = function()
    local cspell = require('cspell')
    return {
      cspell.diagnostics.with({
        diagnostics_postprocess = function(diagnostic) diagnostic.severity = vim.diagnostic.severity.HINT end,
      }),
      cspell.code_actions,
    }
  end,

  eslint_d = function()
    return {
      require('none-ls.diagnostics.eslint_d'),
      require('none-ls.code_actions.eslint_d'),
    }
  end,

  prettierd = function() return { require('null-ls').builtins.formatting.prettierd } end,

  stylua = function() return { require('null-ls').builtins.formatting.stylua } end,
}

local all_tools = vim.tbl_keys(lsp_servers)
vim.list_extend(all_tools, vim.tbl_keys(dap))
vim.list_extend(all_tools, vim.tbl_keys(null_tools))

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
  null_ls = {
    dependencies = { 'davidmh/cspell.nvim' },
    get_sources = function()
      local sources = {}
      for _, get in pairs(null_tools) do
        vim.list_extend(sources, get())
      end
      return sources
    end,
  },
}
