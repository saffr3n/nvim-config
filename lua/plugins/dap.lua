---@module 'lazy'
---@type LazyPluginSpec
return {
  'mfussenegger/nvim-dap',
  config = function()
    local dap = require('dap')
    local tools = require('config.tools')

    for name, adapter in pairs(tools.dap_adapters) do
      dap.adapters[name] = adapter
    end
    for ft, configs in pairs(tools.dap_by_ft) do
      dap.configurations[ft] = configs
    end

    vim.fn.sign_define('DapBreakpoint', { text = '⦁', texthl = 'DiagnosticError' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '⦁', texthl = 'DiagnosticWarn' })
    vim.fn.sign_define('DapStopped', { text = '→', texthl = 'DiagnosticWarn' })
  end,
  keys = {
    { '<F5>', function() require('dap').continue() end },
    { '<F1>', function() require('dap').step_into() end },
    { '<F2>', function() require('dap').step_over() end },
    { '<F3>', function() require('dap').step_out() end },
    { '<Leader>b', function() require('dap').toggle_breakpoint() end },
    { '<Leader>B', function() require('dap').clear_breakpoints() end },
    { '<Leader>dk', function() require('dap.ui.widgets').hover() end },
    {
      '<Leader>df',
      function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.frames)
      end,
    },
    {
      '<Leader>ds',
      function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.scopes)
      end,
    },
    { 'q', function() vim.cmd.bwipeout() end, ft = 'dap-float' },
    { '<Esc>', function() vim.cmd.bwipeout() end, ft = 'dap-float' },
  },
}
