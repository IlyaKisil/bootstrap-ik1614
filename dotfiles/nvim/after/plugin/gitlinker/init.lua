local utils = require("ik1614.functions.utils")
local plugin_name = "gitlinker"

if not utils:plugin_installed(plugin_name) then
  return
end

local plugin = require(plugin_name)

--- copies the url to clipboard and opens the url in your default browser
--
-- @param url the url string
local function copy_and_open_in_browser(url)
  plugin.actions.copy_to_clipboard(url)
  plugin.actions.open_in_browser(url)
end

plugin.setup({
  opts = {
    remote = nil, -- force the use of a specific remote
    -- adds current line nr in the url for normal mode
    add_current_line_on_normal_mode = true,

    -- callback for what to do with the url
    action_callback = copy_and_open_in_browser,

    -- print the url after performing the action
    print_url = false,
  },
  callbacks = {
    ["github.com"] = function(url_data)
      -- NOTE: This is to cover different cases like 'IlyaKisil.github.com -> github.com'
      -- which I have for different SSH keys based on the repo owner (see 'ssh config').
      -- For some reason, simply adding 'IlyaKisil.github.com' to a table with callbacks
      -- doesn't work, potentially because keys are actually lua regex :shrug:
      url_data.host = "github.com"
      return plugin.hosts.get_github_type_url(url_data)
    end,
  },
  -- mapping to call url generation
  -- TODO: extract this from some global mapping variable.
  mappings = "<leader>go"
})
