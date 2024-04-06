local M = require("nvconfig.config"):get()

vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"

local success, base46 = pcall(require, "base46")
  if success then base46.load_all_highlights()
  else vim.notify_once(
    "Error Loading base46, this plugin needs NvChad/base46 to run.",
    vim.log.levels.ERROR
  )
end

return M
