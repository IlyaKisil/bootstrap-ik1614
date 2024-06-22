local logging = require("ik1614.functions.logging")

local utils = require("ik1614.functions.utils")

local M = {}
M.__index = M

function M.new()
  -- Define all prerequisites here
  local self = setmetatable({}, M)
  local required_plugins = {
    "refactoring",
    "telescope",
  }

  for _, plugin_name in pairs(required_plugins) do
    if not utils:plugin_installed(plugin_name) then
      logging:error("Failed to define custom functions based on [" .. plugin_name .. "] plugin")
      return {}
    end
  end

  self.refactoring = require("refactoring")
  self.telescope_config = require("telescope.config")
  self.telescope_pickers = require("telescope.pickers")
  self.telescope_finders = require("telescope.finders")
  self.telescope_actions = require("telescope.actions")
  self.telescope_actions_state = require("telescope.actions.state")
  return self
end

function M:telescope_refactor(prompt_bufnr)
  -- FIXME: This doesn't full work after I've refactored plugins into `after/plugin`
  -- with the use of custom functions
  local content = self.telescope_actions_state.get_selected_entry(prompt_bufnr)
  self.telescope_actions.close(prompt_bufnr)
  self.refactoring.refactor(content.value)
end

function M:refactors()
  -- local opts = require("telescope.themes").get_cursor() -- set personal telescope options
  local opts = {}

  self.telescope_pickers
    .new(opts, {
      prompt_title = "Refactors",
      finder = self.telescope_finders.new_table({
        results = self.refactoring.get_refactors(),
      }),
      sorter = self.telescope_config.values.generic_sorter(opts),
      attach_mappings = function(_, map)
        map("i", "<CR>", self.telescope_refactor)
        map("n", "<CR>", self.telescope_refactor)
        return true
      end,
    })
    :find()
end

return M.new()
