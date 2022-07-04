local utils = require("ik1614.utils")
local plugin_name = "mini.jump"

if not utils.plugin_installed(plugin_name) then
  return
end

local plugin = require(plugin_name)
plugin.setup({
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    forward = 'f',
    backward = 'F',
    forward_till = 't',
    backward_till = 'T',
    repeat_jump = ';',
  },

  -- Delay values (in ms) for different functionalities. Set any of them to
  -- a very big number (like 10^7) to virtually disable.
  delay = {
    -- Delay between jump and highlighting all possible jumps
    highlight = 250,

    -- Delay between jump and automatic stop if idle (no jump is done)
    idle_stop = 2000
  },
})

-- Custom function based on the plugin
local M = {}

-- NOTE: This isn't really needed. Instead of using ',' and ';' you can just keep using
-- 'f' or 'F'. For example, instead of 'fo,,,' the same can be done with 'fofff'
function M.repeat_in_oposite_direction()
  local state = {}
  for k, v in pairs(MiniJump.state) do
    state[k] = v
  end
  MiniJump.smart_jump(not MiniJump.state.backward)
  MiniJump.state = state
end

vim.api.nvim_set_keymap('n', ',', [[:<C-u>lua require("ik1614.mini.jump").repeat_in_oposite_direction()<CR>]], { noremap = true })

return M
