local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local previewers = require "telescope.previewers"

local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_set = require "telescope.actions.set"
local action_state = require "telescope.actions.state"

-- get current theme saved on nvconfig
local old_theme = require("nvconfig").ui.theme

local function reload_theme(name)
  require("nvconfig").ui.theme = name
  require("base46").load_all_highlights()
  vim.api.nvim_exec_autocmds("User", { pattern = "Base46ThemeReload" })
end

local function switcher()
  local bufnr = vim.api.nvim_get_current_buf()

  -- show current buffer content in previewer
  local previewer = previewers.new_buffer_previewer {
    define_preview = function(self, _)
      -- add content
      local preview_content = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local ft = (vim.filetype.match { buf = bufnr } or "diff"):match "%w+"
      local ft_filter = require("nvconfig.utils").ft_filter

      -- if alpha or dashboard show preview content
      if ft_filter(vim.api.nvim_buf_get_option(bufnr, 'filetype')) then
        local path = vim.fn.stdpath("data") .. "/lazy/base46-nvconfig/lua/nvconfig/lua_symbols_preview.lua"
        local file = io.open(path, "r")
        if file then
          preview_content = {}
          ft = "lua"
          for line in file:lines() do
            table.insert(preview_content, line)
          end
          file:close()
        end
      end

      -- get content in previewer
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, preview_content)
      -- add syntax highlighting in previewer
      require("telescope.previewers.utils").highlighter(self.state.bufnr, ft)
    end,
  }

  -- our picker function: colors
  local picker = pickers.new {
    prompt_title = "󱥚 Set Base46 Theme",
    previewer = previewer,
    finder = finders.new_table {
      results = require("nvconfig.utils").list_base46_themes(),
    },
    sorter = conf.generic_sorter(),

    attach_mappings = function(prompt_bufnr, _)
      -- reload theme while typing
      vim.schedule(function()
        vim.api.nvim_create_autocmd("TextChangedI", {
          buffer = prompt_bufnr,
          callback = function()
            if action_state.get_selected_entry() then
              reload_theme(action_state.get_selected_entry()[1])
            end
          end,
        })
      end)
      -- reload theme on cycling
      actions.move_selection_previous:replace(function()
        action_set.shift_selection(prompt_bufnr, -1)
        reload_theme(action_state.get_selected_entry()[1])
      end)
      actions.move_selection_next:replace(function()
        action_set.shift_selection(prompt_bufnr, 1)
        reload_theme(action_state.get_selected_entry()[1])
      end)
      -- restore theme when quit
      actions.close:replace(function()
        local selected_theme = action_state.get_selected_entry()[1]
        if old_theme ~= selected_theme then
          reload_theme(old_theme)
        end
        local picker = action_state.get_current_picker(prompt_bufnr)
        local original_win_id = picker.original_win_id
        local cursor_valid, original_cursor = pcall(vim.api.nvim_win_get_cursor, original_win_id)
        actions.close_pum(prompt_bufnr)
        require("telescope.pickers").on_close_prompt(prompt_bufnr)
        pcall(vim.api.nvim_set_current_win, original_win_id)
        if cursor_valid and vim.api.nvim_get_mode().mode == "i" and picker._original_mode ~= "i" then
          pcall(vim.api.nvim_win_set_cursor, original_win_id, { original_cursor[1], original_cursor[2] + 1 })
        end
      end)
      ------------ save theme to config file on enter ----------------
      actions.select_default:replace(function()
        if action_state.get_selected_entry() then
          local selected_theme = action_state.get_selected_entry()[1]
          require("nvconfig.utils").save_base46_themes(old_theme, selected_theme)
          old_theme = selected_theme
          actions.close(prompt_bufnr)
        end
      end)
      return true
    end,
  }

  picker:find()
end

return require("telescope").register_extension {
  exports = { themes = switcher },
}
