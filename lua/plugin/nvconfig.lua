local success, _ = pcall(require, "base46")
  if success then
    vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"
  else vim.notify_once(
    "Error Loading base46, please make sure NvChad/base46 is installed.",
    vim.log.levels.ERROR
  )
end
