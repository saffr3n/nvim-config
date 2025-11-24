---@module 'lazy'
---@type LazyPluginSpec
return {
  'saghen/blink.cmp',
  version = '1.*',
  event = { 'CmdlineEnter', 'InsertEnter' },
  ---@module 'blink-cmp'
  ---@type blink.cmp.Config
  opts = {
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      per_filetype = { lua = { 'lazydev', inherit_defaults = true } },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },
    completion = {
      accept = { auto_brackets = { enabled = false } },
      list = { selection = { preselect = false } },
      menu = { auto_show = false },
      documentation = { auto_show = true },
    },
    signature = {
      enabled = true,
      trigger = { enabled = false },
      window = { show_documentation = true },
    },
    keymap = {
      ['<C-b>'] = { 'scroll_documentation_up', 'scroll_signature_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'scroll_signature_down', 'fallback' },
    },
    cmdline = {
      completion = { list = { selection = { preselect = false } } },
      keymap = {
        ['<Tab>'] = { 'show', 'select_next' },
      },
    },
  },
}
