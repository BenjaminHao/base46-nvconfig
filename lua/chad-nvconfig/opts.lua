local M = {}

M.setup = function(opts)
  local default_config = require "chad-nvconfig.default_config"
  vim.g.nvconfig = vim.tbl_deep_extend("force", default_config, opts or {})
  vim.g.base46_cache = vim.fn.stdpath "data" .. "/chad-nvconfig/"
  require("base46").load_all_highlights()
end

return M
