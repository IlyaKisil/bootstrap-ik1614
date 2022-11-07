local utils = require("ik1614.utils")
local plugin_name = "nvim-tree"

if not utils.plugin_installed(plugin_name) then
  return
end

-- NOTE: These should be set before calling require'nvim-tree' or calling setup. They
-- are being migrated to the setup function bit by bit
--
vim.g.nvim_tree_refresh_wait = 1000


local plugin = require(plugin_name)
plugin.setup({
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  create_in_closed_folder = true, -- When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
  actions = {
    open_file = {
      quit_on_open = true,
      window_picker = {
        enable = true, -- When enabled and if there are at least two windows then you are prompted to select in which window to open a file
        exclude = {
          -- NOTE: not sure if this works or not :shrug:
          -- Dictionary of buffer option names mapped to a list of option values that
          -- indicates to the window picker that the buffer's window should not be
          -- selectable.
          filetype = {
            'notify',
            'packer',
            'qf'
          },
          buftype = {
            'terminal'
          },
        },
      },
    },
  },
  renderer = {
    add_trailing = false, -- append a trailing slash to folder names
    highlight_git = true, -- enable file highlight for git attributes (can be used without the icons).
    highlight_opened_files = "0", -- Should be string 1 -> icon; 2 -> name; 3 -> all
    icons = {
      padding = ' ', -- used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
      symlink_arrow = " -> ", -- used as a separator between symlinks' source and target.
      show = {
        git = true,
        folder = true,
        file = false,
        folder_arrow = false,
      },
      glyphs = {
        folder = {
          default = "",
          open = "",
        },
        git = {
          unstaged = "",
          staged = "",
          unmerged = "",
          renamed = "",
          untracked = "",
          deleted = "",
          ignored = "",
        },
      },
    },
    indent_markers = {
      enable = true
    },
    group_empty = true, --  compact folders that only contain a single folder into one node in the file tree
    root_folder_modifier = ':t', -- Value translates to a folder name from where nvim was opened from. See :help filename-modifiers for more options
    special_files = {}, -- List of filenames that gets highlighted with NvimTreeSpecialFile. Override defaults (e.g. README, Makefile etc) with an empty list.
  },

  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {
      "^.DS_Store$",
      "^.git$",
    }
  },
  git = {
    enable = true, -- Although I don't like icons but without it file name highlight doesn't work
    ignore = false,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    mappings = {
      custom_only = false,
      list = {}
    },
    number = false,
    relativenumber = false,
    signcolumn = "no"
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  }
})
