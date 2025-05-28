local lsp_servers = {
  lua_ls = {},
  ts_ls = {},
}

local lsp_tools = {
  cspell = function()
    local cspell = require('cspell')
    return {
      cspell.diagnostics.with({
        diagnostics_postprocess = function(diagnostic)
          diagnostic.severity = vim.diagnostic.severity.HINT
        end,
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

  prettierd = function()
    return { require('null-ls').builtins.formatting.prettierd }
  end,

  stylua = function()
    return { require('null-ls').builtins.formatting.stylua }
  end,
}

local all_tools = vim.tbl_keys(lsp_servers)
vim.list_extend(all_tools, vim.tbl_keys(lsp_tools))

return {
  nvim_lspconfig = {
    servers = lsp_servers,
    ensure_installed = all_tools,
  },
  null_ls = {
    dependencies = { 'davidmh/cspell.nvim' },
    get_sources = function()
      local sources = {}
      for _, get in pairs(lsp_tools) do
        vim.list_extend(sources, get())
      end
      return sources
    end,
  },
}
