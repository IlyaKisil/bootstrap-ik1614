return {
  {
    "https://github.com/ibhagwan/fzf-lua",
    enabled = true,
    lazy = false,
    dependencies = {
      "https://github.com/vijaymarupudi/nvim-fzf",
      "https://github.com/nvim-tree/nvim-web-devicons",
    },
    config = function()
      local fzf = require("ik1614.functions.fzf-lua")
      local actions = require("fzf-lua.actions")

      require("fzf-lua").setup({
        global_resume = true,
        global_resume_query = true,
        winopts = {
          -- fullscreen       = true,
          -- Has the same effect, but makes it easier to override winopts for specific uscases
          height = 1,
          width = 1,
          hl = {
            cursorline = "PmenuSel", -- Only valid with the builtin previewer:
          },
          preview = {
            vertical = "down:50%",
            horizontal = "right:50%",
            layout = "flex", -- horizontal|vertical|flex
            flip_columns = 120, -- #cols to switch to horizontal on flex
            -- Only valid with the builtin previewer:
            title = true,
            scrollbar = false,
          },
          on_create = function()
            -- called once upon creation of the fzf main window
            -- can be used to add custom fzf-lua mappings, e.g:
            --   vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", "<Down>",
            --     { silent = true, noremap = true })
          end,
        },
        keymap = {
          -- These override the default tables completely
          -- no need to set to `false` to disable a bind
          -- delete or modify is sufficient
          builtin = {
            -- Only valid with the 'builtin' previewer
            -- ["<C-r>"]        = "toggle-preview-wrap",
            ["<C-p>"] = "toggle-preview",
            ["<C-space>"] = "toggle-preview-cw", -- Rotate preview clockwise/counter-clockwise
            ["<C-d>"] = "preview-page-down",
            ["<C-u>"] = "preview-page-up",
            ["<C-z>"] = "preview-page-reset",
          },
          fzf = {
            -- Most of the bindings are defined at the shell level, but it doesn't work
            -- for the following within 'fzf-lua' for some reason :shrug:
            ["ctrl-u"] = "preview-half-page-up",
            ["ctrl-d"] = "preview-half-page-down",
          },
        },
        ---------------------------------------------------------------------------------------
        -- PREVIEWERS SETUP
        ---------------------------------------------------------------------------------------
        previewers = {
          bat = {
            cmd = "bat",
            args = "--style=numbers,changes --color always",
            -- theme           = 'Coldark-Dark', -- bat preview theme (bat --list-themes)
            config = nil, -- nil uses $BAT_CONFIG_PATH
          },
          head = {
            cmd = "head",
            args = nil,
          },
          git_diff = {
            cmd_deleted = "git diff --color HEAD --",
            cmd_modified = "git diff --color HEAD",
            cmd_untracked = "git diff --color --no-index /dev/null",
            -- NOTE: if `pager` is set here, then you won't be able to override pager
            -- settings, e.g. in `git.status.preview_pager` or within opts for the API call
            -- pager           = "delta",
          },
          man = {
            cmd = "man -c %s | col -bx",
          },
          builtin = {
            syntax = true,
            syntax_limit_l = 0, -- syntax limit (lines), 0=nolimit
            syntax_limit_b = 1024 * 1024, -- syntax limit (bytes), 0=nolimit
            title_fnamemodify = function(s)
              -- NOTE: By default, this displays only base path of a file at the top of the
              -- preview windown. We overwrite it to display filepath. Potentioally, will
              -- need to do it dynamic and add some truncation if it doesn't fit, but
              -- this is relatively unlikely.
              return s
            end,
          },
        },

        ---------------------------------------------------------------------------------------
        -- PROVIDERS SETUP
        ---------------------------------------------------------------------------------------
        files = {
          -- NOTE: This should search through pretty much all files, i.e. don't
          -- use .gitignore. But some annoying files/directories might still be excluded
          multiprocess = true,
          git_icons = false,
          file_icons = false,
          -- cmd = "rg " .. get_rg_opts_files(),
          rg_opts = fzf:get_rg_opts_files(),
          fd_opts = fzf:get_fd_opts_files(),
          actions = {
            -- set bind to 'false' to disable an action
            -- ["default"]     = actions.file_edit_or_qf,
            -- ["ctrl-s"]      = actions.file_split,
            -- ["ctrl-v"]      = actions.file_vsplit,
            -- ["ctrl-t"]      = actions.file_tabedit,
            -- custom actions are available too
            ["ctrl-r"] = function(selected)
              fzf:grep_selected_files(selected)
            end,
          },
        },
        git = {
          files = {
            cmd = "git ls-files --exclude-standard",
            multiprocess = true,
            git_icons = false,
            file_icons = false,
            actions = {
              ["ctrl-r"] = function(selected)
                fzf:grep_selected_files(selected)
              end,
            },
          },
          status = {
            cmd = "git status -s",
            previewer = "git_diff",
            git_icons = true,
            preview_pager = "delta",
            file_icons = false,
            actions = {
              ["right"] = { actions.git_unstage, actions.resume },
              ["left"] = { actions.git_stage, actions.resume },
            },
          },
          commits = {
            cmd = "git log --abbrev-commit --color --pretty=format:'%C(red)%h%C(reset) %C(yellow)%ad%C(reset) %s %C(blue)<%an>%C(reset) %C(green)%d%C(reset)' --date=format:'%Y-%m-%d %H:%M'",
            preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1} | delta",
            winopts = {
              preview = {
                layout = "vertical",
                vertical = "down:75%",
              },
            },
            actions = {
              ["default"] = actions.git_checkout,
            },
          },
          bcommits = {
            cmd = "git log --abbrev-commit --color --pretty=format:'%C(red)%h%C(reset) %C(yellow)%ad%C(reset) %s %C(blue)<%an>%C(reset) %C(green)%d%C(reset)' --date=format:'%Y-%m-%d %H:%M'",
            preview = {
              type = "cmd",
              fn = function(items)
                local commit_hash = vim.split(items[1], " ")[1]
                local git_command = string.format("git show --color %s", commit_hash)
                local delta_command = string.format("delta --side-by-side --width %s", vim.api.nvim_win_get_width(0))
                return git_command .. " | " .. delta_command
              end,
            },
            winopts = {
              preview = {
                layout = "vertical",
                vertical = "down:75%",
              },
            },
            actions = {
              ["default"] = actions.git_buf_edit,
              ["ctrl-s"] = actions.git_buf_split,
              ["ctrl-v"] = actions.git_buf_vsplit,
              ["ctrl-t"] = actions.git_buf_tabedit,
            },
          },
          branches = {
            cmd = "git branch --all --color",
            preview = "git log --graph --abbrev-commit --color --pretty=format:'%C(red)%h%C(reset) %C(yellow)%ad%C(reset) %s %C(blue)<%an>%C(reset) %C(green)%d%C(reset)' --date=format:'%Y-%m-%d %H:%M' {1}",
            actions = {
              ["default"] = actions.git_switch,
            },
          },
          icons = {
            ["M"] = { icon = "M", color = "blue" },
            ["D"] = { icon = "D", color = "red" },
            ["A"] = { icon = "A", color = "green" },
            ["?"] = { icon = "?", color = "magenta" },
          },
        },
        grep = {
          multiprocess = true,
          git_icons = false,
          file_icons = false,
          -- cmd            = "rg --vimgrep",
          rg_opts = fzf:get_rg_opts_grep(),
          glob_flag = "--iglob", -- for case sensitive globs use '--glob'
          glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
          fzf_opts = fzf:get_fzf_for_grep_opts(),
          actions = {
            ["ctrl-r"] = function(selected)
              fzf:files_of_selected_lines(selected)
            end,
          },
        },
        args = { -- TODO: figure out what this does :shrug:
          files_only = true,
          actions = {
            -- added on top of regular file actions
            ["ctrl-x"] = actions.arg_del,
          },
        },
        oldfiles = {
          cwd_only = true,
          git_icons = false,
          file_icons = false,
        },
        buffers = {
          git_icons = false,
          file_icons = false,
          sort_lastused = true,
          actions = {
            -- ["default"]     = actions.buf_edit,
            -- ["ctrl-s"]      = actions.buf_split,
            -- ["ctrl-v"]      = actions.buf_vsplit,
            -- ["ctrl-t"]      = actions.buf_tabedit,
            -- by supplying a table of functions we're telling
            -- fzf-lua to not close the fzf window, this way we
            -- can resume the buffers picker on the same window
            -- eliminating an otherwise unaesthetic win "flash"
            ["ctrl-x"] = { actions.buf_del, actions.resume },
          },
        },
        lines = {
          previewer = "builtin",
          git_icons = false,
          file_icons = false,
          show_unlisted = false, -- exclude 'help' buffers
          no_term_buffers = true, -- exclude 'term' buffers
          fzf_opts = fzf:get_fzf_for_grep_opts(),
          actions = {
            ["default"] = actions.buf_edit,
            ["ctrl-s"] = actions.buf_split,
            ["ctrl-v"] = actions.buf_vsplit,
            ["ctrl-t"] = actions.buf_tabedit,
          },
        },
        blines = {
          previewer = "builtin",
          show_unlisted = true, -- include 'help' buffers
          no_term_buffers = false, -- include 'term' buffers
          fzf_opts = fzf:get_fzf_for_grep_opts(),
          actions = {
            ["default"] = actions.buf_edit,
            ["ctrl-s"] = actions.buf_split,
            ["ctrl-v"] = actions.buf_vsplit,
            ["ctrl-t"] = actions.buf_tabedit,
          },
        },
        quickfix = {
          file_icons = false,
          git_icons = false,
        },
        lsp = {
          cwd_only = false, -- LSP/diagnostics for cwd only?
          async_or_timeout = 5000, -- timeout(ms) or 'true' for async calls
          file_icons = false,
          git_icons = false,
          lsp_icons = true,
          severity = "hint",
          icons = {
            ["Error"] = { icon = "E", color = "red" },
            ["Warning"] = { icon = "W", color = "yellow" },
            ["Information"] = { icon = "I", color = "blue" },
            ["Hint"] = { icon = "H", color = "magenta" },
          },
        },
        -- uncomment to disable the previewer
        -- nvim = { marks    = { previewer = { _ctor = false } } },
        -- helptags = { previewer = { _ctor = false } },
        -- manpages = { previewer = { _ctor = false } },
        -- uncomment to set dummy win location (help|man bar)
        -- "topleft"  : up
        -- "botright" : down
        -- helptags = { previewer = { split = "topleft" } },
        -- uncomment to use `man` command as native fzf previewer
        -- manpages = { previewer = { _ctor = require'fzf-lua.previewer'.fzf.man_pages } },
        -- optional override of file extension icon colors
        -- available colors (terminal):
        --    clear, bold, black, red, green, yellow
        --    blue, magenta, cyan, grey, dark_grey, white
        -- padding can help kitty term users with
        -- double-width icon rendering
      })
    end,
  },
}
