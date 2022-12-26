local f = require("ik1614.functions")
local plugin_name = "mini.jump"

if not f.utils:plugin_installed(plugin_name) then
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

-- TODO: Somehow move keybindings to a central place.
-- And refactor to use utility functions
vim.api.nvim_set_keymap('n', ',', [[:<C-u>lua require("ik1614.utils").repeat_jump_in_oposite_direction()<CR>]], { noremap = true })
