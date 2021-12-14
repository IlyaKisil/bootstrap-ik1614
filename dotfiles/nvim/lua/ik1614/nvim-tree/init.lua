-- NOTE: These should be set before calling require'nvim-tree' or calling setup. They
-- are being migrated to the setup function bit by bit
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1 -- enable file highlight for git attributes (can be used without the icons).
-- vim.g.nvim_tree_highlight_opened_files = 1 -- 0 by default, will enable folder and file icon highlight for opened files/directories.
vim.g.nvim_tree_root_folder_modifier = ':t' -- Value translates to a folder name from where nvim was opened from. See :help filename-modifiers for more options
vim.g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
vim.g.nvim_tree_group_empty = 1 --  compact folders that only contain a single folder into one node in the file tree
vim.g.nvim_tree_disable_window_picker = 1 -- When enabled and if there are at least two windows then you are prompted to select in which window to open a file
vim.g.nvim_tree_icon_padding = ' ' -- used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
vim.g.nvim_tree_symlink_arrow = ' -> ' -- used as a separator between symlinks' source and target.
vim.g.nvim_tree_create_in_closed_folder = 1 -- When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
vim.g.nvim_tree_refresh_wait = 1000


-- " Dictionary of buffer option names mapped to a list of option values that
-- " indicates to the window picker that the buffer's window should not be
-- " selectable.
-- let g:nvim_tree_window_picker_exclude = {
  --   \   'filetype': [
  --   \     'notify',
  --   \     'packer',
  --   \     'qf'
  --   \   ],
  --   \   'buftype': [
  --   \     'terminal'
  --   \   ]
  --   \ }

-- List of filenames that gets highlighted with NvimTreeSpecialFile
-- Override defaults (e.g. README, Makefile etc) with an empty list.
vim.g.nvim_tree_special_files = {}

vim.g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 0,
  folder_arrows = 0,
}

vim.g.nvim_tree_icons = {
  folder = {
    -- default = "",
    -- open = "",
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
}



-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
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
      ".DS_Store",
      ".git",
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
    auto_resize = false,
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
}
