local M = {}

M.setup = function(opts)
  local default_config = require "nvconfig.default_config"
  vim.g.nvconfig = vim.tbl_deep_extend("force", default_config, opts or {})
  vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"
  require("base46").load_all_highlights()
end

return M
