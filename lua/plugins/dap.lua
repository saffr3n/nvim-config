---@module 'lazy'
---@type LazyPluginSpec
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'theHamsta/nvim-dap-virtual-text',
  },
  keys = {
    {
      '<F5>',
      function() require('dap').continue() end,
    },
    {
      '<F1>',
      function() require('dap').step_into() end,
    },
    {
      '<F2>',
      function() require('dap').step_over() end,
    },
    {
      '<F3>',
      function() require('dap').step_out() end,
    },
    {
      '<leader>b',
      function() require('dap').toggle_breakpoint() end,
    },
    {
      '<leader>B',
      function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
    },
    {
      '<F7>',
      function() require('dapui').toggle() end,
    },
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    require('nvim-dap-virtual-text').setup({})

    require('mason-nvim-dap').setup({
      automatic_installation = true,
      handlers = {},
      ensure_installed = {},
    })

    ---@diagnostic disable-next-line: missing-fields
    dapui.setup({
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      ---@diagnostic disable-next-line: missing-fields
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    })

    dap.listeners.after.event_initialized.dapui_config = dapui.open
    dap.listeners.before.event_terminated.dapui_config = dapui.close
    dap.listeners.before.event_exited.dapui_config = dapui.close

    local tools = require('config.tools')

    for name, adapter in pairs(tools.dap_adapters) do
      dap.adapters[name] = adapter
    end
    for ft, configs in pairs(tools.dap_by_ft) do
      dap.configurations[ft] = configs
    end
  end,
}
