local M = {}

M.ts_languages = {
  'bash',
  'c',
  'css',
  'diff',
  'html',
  'javascript',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'prisma',
  'query',
  'regex',
  'typescript',
  'vim',
  'vimdoc',
}

---@type table<string, vim.lsp.Config>
M.lsp_servers = {
  cssls = {},
  emmet_language_server = {},
  html = {},
  lua_ls = {},
  prismals = {},
  ts_ls = {},
}

---@module 'dap'
---@type table<string, dap.ExecutableAdapter|dap.PipeAdapter|dap.ServerAdapter>
M.dap_adapters = {
  ['pwa-node'] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
      command = 'js-debug-adapter',
      args = { '${port}' },
    },
  },
}

---@module 'dap'
---@type table<string, dap.Configuration[]>
M.dap_by_ft = {
  javascript = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file in node',
      program = '${file}',
      cwd = '${workspaceFolder}',
    },
  },
  typescript = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file in node',
      program = '${file}',
      cwd = '${workspaceFolder}',
    },
  },
}

M.linters_by_ft = {
  javascript = { 'eslint_d' },
  javascriptreact = { 'eslint_d' },
  ['javascript.jsx'] = { 'eslint_d' },
  typescript = { 'eslint_d' },
  typescriptreact = { 'eslint_d' },
  ['typescript.jsx'] = { 'eslint_d' },
  vue = { 'eslint_d' },
}

M.formatters_by_ft = {
  lua = { 'stylua' },

  javascript = { 'prettierd' },
  javascriptreact = { 'prettierd' },
  ['javascript.jsx'] = { 'prettierd' },
  typescript = { 'prettierd' },
  typescriptreact = { 'prettierd' },
  ['typescript.jsx'] = { 'prettierd' },
  vue = { 'prettierd' },
  css = { 'prettierd' },
  scss = { 'prettierd' },
  less = { 'prettierd' },
  html = { 'prettierd' },
  json = { 'prettierd' },
  jsonc = { 'prettierd' },
  yaml = { 'prettierd' },
  markdown = { 'prettierd' },
  ['markdown.mdx'] = { 'prettierd' },
  graphql = { 'prettierd' },
  handlebars = { 'prettierd' },
}

M.ensure_installed = {
  treesitter = M.ts_languages,
  mason = (function()
    local ensure_installed = {}

    local dap = {}
    for _, adapter in pairs(M.dap_adapters) do
      table.insert(dap, { adapter.executable and adapter.executable.command or adapter.command })
    end
    vim.list_extend(ensure_installed, dap)

    local lsp = vim.tbl_keys(M.lsp_servers)
    vim.list_extend(ensure_installed, lsp)

    local linters = {}
    for _, list in pairs(M.linters_by_ft) do
      for _, name in ipairs(list) do
        linters[name] = true
      end
    end
    linters = vim.tbl_keys(linters)
    vim.list_extend(ensure_installed, linters)

    local formatters = {}
    for _, list in pairs(M.formatters_by_ft) do
      for _, name in ipairs(list) do
        formatters[name] = true
      end
    end
    formatters = vim.tbl_keys(formatters)
    vim.list_extend(ensure_installed, formatters)

    return ensure_installed
  end)(),
}

return M
