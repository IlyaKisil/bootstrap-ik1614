local f = require("ik1614.functions")
local plugin_name = "todo-comments"

if not f.utils:plugin_installed(plugin_name) then
  return
end

local plugin = require(plugin_name)
plugin.setup({
  signs = false,
  -- sign_priority = 8,
  keywords = {
    FIX = {
      color = "default",
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
    },
    TODO = {
      color = "default",
      alt = {"Todo", "todo"}
    },
    NOTE = {
      color = "default",
      alt = { "INFO", "TIP" }
    },
    HACK = {
      color = "default",
    },
    WARN = {
      color = "default",
      alt = { "WARNING", "XXX" }
    },
    PERF = {
      color = "default",
      alt = { "OPTIM", "PERFORMANCE", "OPTIMISE" , "OPTIMIZE" }
    },
  },
  merge_keywords = true, -- when true, custom keywords will be merged with the defaults
  -- highlighting of the line containing the todo comment
  -- * before: highlights before the keyword (typically comment characters)
  -- * keyword: highlights of the keyword
  -- * after: highlights after the keyword (todo text)
  highlight = {
    before = "", -- "fg" or "bg" or empty
    keyword = "fg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
    after = "", -- "fg" or "bg" or empty
    pattern = { -- vim regex
        [[.*<(KEYWORDS)\s*\([a-zA-Z]*\):]],
        [[.*<(KEYWORDS)\s*:]],
    },
    comments_only = true, -- uses treesitter to match keywords in comments only
    max_line_len = 400, -- ignore lines longer than this
    exclude = {}, -- list of file types to exclude highlighting
  },
  colors = {
    default = {
      "Todo"
    },
  },
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    -- NOTE: 1) don't replace the (KEYWORDS) placeholder. 2) '\w' doesn't work for some reason :shrug:
    pattern = [[\b(KEYWORDS)[a-zA-Z\(\)\s]*:]], -- ripgrep regex
  },
})
