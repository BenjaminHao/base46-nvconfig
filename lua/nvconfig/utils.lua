local M = {}

function M.list_base46_themes()
  local base46_themes = vim.fn.readdir(vim.fn.stdpath "data" .. "/lazy/base46/lua/base46/themes")
  local custom_themes = vim.loop.fs_stat(vim.fn.stdpath "config" .. "/lua/themes")

  if custom_themes and custom_themes.type == "directory" then
    local themes_tb = vim.fn.readdir(vim.fn.stdpath "config" .. "/lua/themes")
    for _, value in ipairs(themes_tb) do
      table.insert(base46_themes, value)
    end
  end

  for index, theme in ipairs(base46_themes) do
    base46_themes[index] = theme:match "(.+)%..+"
  end

  return base46_themes
end

function M.save_base46_themes(old, new)
  local config_path = require("nvconfig.config").path
  local added_pattern = string.gsub(old, "-", "%%-") -- add % before - if exists

  local WARN_SAVE_THEME = "** This theme will NOT be saved. **"
  .. "\nTo change a theme, add theme option in your nvconfig opts:"
  .. "\n{"
  .. "\n  ui = {"
  .. "\n    theme = 'your_base46_theme',"
  .. "\n  },"
  .. "\n}"

  local file, err = io.open(config_path, "r")
  if not file then
    vim.notify(
      "Error opening config file for reading: " .. (err or "unknown error"),
      vim.log.levels.ERROR
    )
    return
  end

  local config_content = file:read("*all")
  file:close()

  if not config_content:find(added_pattern) then
    vim.notify(WARN_SAVE_THEME, vim.log.levels.WARN)
    return
  end

  file, err = io.open(config_path, "w")
  if not file then
    vim.notify(
      "Error opening file for writing: " .. (err or "unknown error"),
      vim.log.levels.ERROR
    )
    return
  end

  local new_content = config_content:gsub(added_pattern, new)
  file:write(new_content)
  file:close()

  vim.cmd("checktime")
end

function M.ft_filter(ft)
  local filter = require("nvconfig").ui.telescope_filter
  for _, entry in pairs(filter) do
   if string.find(entry:lower(), ft:lower()) then
      return true
    end
  end
  return false
end

return M
