local M = {}
local fn = vim.fn

M.list_base46_themes = function()
  local base46_themes = vim.fn.readdir(vim.fn.stdpath "data" .. "/lazy/base46/lua/base46/themes")

  for index, theme in ipairs(base46_themes) do
    base46_themes[index] = theme:match "(.+)%..+"
  end

  return base46_themes
end

M.replace_theme_name = function(old, new)
  local path = require("nvconfig").path
  local configPath = vim.fn.stdpath "config" .. "/lua/" .. path
  local added_pattern = string.gsub(old, "-", "%%-") -- add % before - if exists

  local ERROR_MSG_FILE = "\nConfiguration file was not found or read/write permissions are missing."
    .. "\nPlease check your configuration parameter: { path: '"
    .. configPath
    .. "' }"

  local file = io.open(configPath, "r")
  if not file then
    error(ERROR_MSG_FILE)
    return
  end

  local new_content = file:read("*all"):gsub(added_pattern, new)

  file = io.open(configPath, "w")
  if not file then
    error(ERROR_MSG_FILE)
    return
  end

  file:write(new_content)
  file:close()
end

return M
