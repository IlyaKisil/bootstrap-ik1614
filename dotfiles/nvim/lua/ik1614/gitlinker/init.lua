local gitlinker = require 'gitlinker'

--- copies the url to clipboard and opens the url in your default browser
--
-- @param url the url string
local function copy_and_open_in_browser(url)
  gitlinker.actions.copy_to_clipboard(url)
  gitlinker.actions.open_in_browser(url)
end

require"gitlinker".setup({
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
    ["IlyaKisil.github.com"] = function(url_data)
      -- FIXME: For some reason this doesn't work all the time :shrug:
      url_data.host = "github.com"
      return gitlinker.hosts.get_github_type_url(url_data)
    end,
  },
  -- mapping to call url generation
  -- TODO: extract this from some global mapping variable.
  mappings = "<leader>go"
})
