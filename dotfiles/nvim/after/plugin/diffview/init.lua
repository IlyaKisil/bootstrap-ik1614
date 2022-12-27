local f = require("ik1614.functions")
local plugin = f.utils:load_plugin("diffview")

if not plugin then
  return
end

local cb = require('diffview.config').diffview_callback

plugin.setup({
  use_icons = true,         -- Requires nvim-web-devicons
  file_panel = {
    win_config = {
      position = "bottom",                  -- One of 'left', 'right', 'top', 'bottom'
      height = 10,                        -- Only applies when position is 'top' or 'bottom'
      listing_style = "list",             -- One of 'list' or 'tree'
    },
  },
  file_history_panel = {
    win_config = {
      position = "bottom",
      height = 10,
      log_options = {
        max_count = 256,      -- Limit the number of commits
        follow = false,       -- Follow renames (only for single file)
        all = false,          -- Include all refs under 'refs/' including HEAD
        merges = false,       -- List only merge commits
        no_merges = false,    -- List no merge commits
        reverse = false,      -- List commits in reverse order
      },
    },
  },
  default_args = {    -- Default args prepended to the arg-list for the listed commands
    DiffviewOpen = {},
    DiffviewFileHistory = {},
  },
  key_bindings = {
    disable_defaults = true,
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ["<tab>"]      = cb("select_next_entry"),  -- Open the diff for the next file
      ["<C-n>"]      = cb("select_next_entry"),  -- Open the diff for the next file
      ["<s-tab>"]    = cb("select_prev_entry"),  -- Open the diff for the previous file
      ["<C-e>"]      = cb("select_prev_entry"),  -- Open the diff for the previous file
      ["gf"]         = cb("goto_file"),          -- Open the file in a new split in previous tabpage
      ["<C-w><C-f>"] = cb("goto_file_split"),    -- Open the file in a new split
      ["<C-w>gf"]    = cb("goto_file_tab"),      -- Open the file in a new tabpage
      ["<leader>e"]  = cb("focus_files"),        -- Bring focus to the files panel
      ["<leader>t"]  = cb("toggle_files"),       -- Toggle the files panel.
    },
    file_panel = {
      ["<cr>"]          = cb("select_entry"),         -- Open the diff for the selected entry.
      ["o"]             = cb("select_entry"),
      ["s"]             = cb("toggle_stage_entry"),   -- Stage / unstage the selected entry.
      ["S"]             = cb("stage_all"),            -- Stage all entries.
      ["U"]             = cb("unstage_all"),          -- Unstage all entries.
      -- ["X"]             = cb("restore_entry"),        -- Restore entry to the state on the left side.
      ["r"]             = cb("refresh_files"),        -- Update stats and entries in the file list.
      ["<tab>"]         = cb("select_next_entry"),
      ["<C-n>"]         = cb("select_next_entry"),
      ["<s-tab>"]       = cb("select_prev_entry"),
      ["<C-e>"]         = cb("select_prev_entry"),
      ["gf"]            = cb("goto_file"),
      ["<C-w><C-f>"]    = cb("goto_file_split"),
      ["<C-w>gf"]       = cb("goto_file_tab"),
      ["<leader>e"]     = cb("focus_files"),
      ["<leader>t"]     = cb("toggle_files"),
    },
    file_history_panel = {
      ["O"]             = cb("open_in_diffview"),   -- Open the entry under the cursor in a diffview
      ["y"]             = cb("copy_hash"),          -- Copy the commit hash of the entry under the cursor
      ["<tab>"]         = cb("select_next_entry"),
      ["<s-tab>"]       = cb("select_prev_entry"),
      ["zR"]            = cb("open_all_folds"),
      ["zM"]            = cb("close_all_folds"),
      ["<cr>"]          = cb("select_entry"),
      ["o"]             = cb("select_entry"),
      ["gf"]            = cb("goto_file"),
      ["<C-w><C-f>"]    = cb("goto_file_split"),
      ["<C-w>gf"]       = cb("goto_file_tab"),
      ["<leader>e"]     = cb("focus_files"),
      ["<leader>t"]     = cb("toggle_files"),
      ["<leader>o"]     = cb("options"),            -- Open the option panel
    },
    option_panel = {
      ["<cr>"]  = cb("select"),
      ["q"]     = cb("close"),
    },
  },
})
