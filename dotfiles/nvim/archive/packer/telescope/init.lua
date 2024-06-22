if not pcall(require, "telescope") then
  return
end

local reloader = function()
  RELOAD("plenary")
  RELOAD("popup")
  RELOAD("telescope")
end

reloader()

local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
      preview_height = 0.60,
      preview_cutoff = 20,
      -- I find this to be a bettre option to span the whole window
      height = { padding = 0 },
      width = { padding = 0 },
      -- height = 100000,
      -- width = 100000,
      prompt_position = "top",
      mirror = true,
    },
    -- path_display = { smart = true },  -- Would be cool to toogle it on the fly
    sorting_strategy = "ascending", -- keep the first result next to prompt
    mappings = {
      i = {
        ["<C-a>"] = actions.smart_add_to_qflist + actions.open_qflist,
        ["<C-s>"] = actions.smart_send_to_qflist,
        ["<C-?>"] = actions.which_key,
        -- Everything is backwards, since we cycle through history
        ["<C-e>"] = actions.cycle_history_next,
        ["<C-n>"] = actions.cycle_history_prev,
      },
      n = {
        ["<C-a>"] = actions.smart_add_to_qflist + actions.open_qflist,
        ["<C-s>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
  },
  pickers = {
    live_grep = {
      only_sort_text = true, -- don't include the filename in the search results
    },
  },
  -- history = {
  --   path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
  --   limit = 100,
  -- },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
  },
})
require("telescope").load_extension("fzf")
require("telescope").load_extension("neoclip")
-- require('telescope').load_extension('smart_history')

local M = {}
function M.search_dotfiles()
  require("telescope.builtin").find_files({
    prompt_title = "< dotfiles >",
    cwd = "$HOME/GitHub/IlyaKisil/bootstrap-ik1614/dotfiles/",
  })
end

return setmetatable({}, {
  __index = function(_, k)
    reloader()

    if M[k] then
      return M[k]
    else
      return require("telescope.builtin")[k]
    end
  end,
})
