-- return vim.g.nvconfig
local M = require("nvconfig.config"):get()

M.setup = function(opts)
  return require("nvconfig.config"):set(opts):get()
end

return M
