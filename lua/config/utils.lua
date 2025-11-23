local M = {}

---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
function M.map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

---@generic T
---@param delay integer
---@param fn T
---@return T
function M.debounce(delay, fn)
  local timer = nil
  return function(...)
    if timer then
      timer:stop()
      timer:close()
    end
    timer = vim.uv.new_timer()
    if not timer then return end
    local args = { ... }
    timer:start(delay, 0, vim.schedule_wrap(function()
      timer:stop()
      timer:close()
      timer = nil
      fn(unpack(args))
    end))
  end
end

return M
