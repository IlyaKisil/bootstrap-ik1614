return {
  {
    "https://github.com/nvim-tree/nvim-tree.lua",
    enabled = true,
    event = {},
    lazy = false,
    dependencies = {
      "https://github.com/nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
        view = {
          signcolumn = "no",
        },
        renderer = {
          group_empty = true, --  compact folders that only contain a single folder into one node in the file tree
          highlight_git = true, -- enable file highlight for git attributes (can be used without the icons).
          icons = {
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
                -- NOTE: Set icons to nothing, because I only need highlighting
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
            enable = true,
          },
        },
        diagnostics = {
          enable = true,
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          },
        },
        filters = {
          enable = true,
          dotfiles = false,
          custom = {
            "^.DS_Store$",
            "^.idea$",
            "^.git$",
            "^tfplan$",
            "^.terraform$",
            "^__pycache__$",
            "^.coverage$",
            "^.pytest_cache$",
            "^.venv$",
            ".egg-info$",
          },
        },
        git = {
          ignore = false,
        },
        notify = {
          threshold = vim.log.levels.WARN,
        },
        trash = {
          cmd = "trash",
          require_confirm = true,
        },
      })
    end,
  },
}
