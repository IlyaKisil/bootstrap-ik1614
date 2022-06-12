local utils = require("ik1614.utils")
local plugin_name = "fzf-lua"

if not utils.plugin_installed(plugin_name) then
  return
end

local plugin = require(plugin_name)
local actions = require "fzf-lua.actions"

local M = {}

local function get_ignore_glob(type)
  local ignore = {
    ".cache",
    ".coverage",
    ".env",
    ".git",
    ".idea",
    ".ipynb_checkpoints",
    ".pytest_cache",
    ".terraform",
    ".terraform.lock.hcl",
    ".venv",
    "__pycache__",
    "CODEOWNERS",
    "cache",
    "node_modules",
    "package-lock.json",
  }

  local glob = utils.table_to_string(ignore, ",")

  if type == "rg" then
    return "--glob '!{" .. glob .. "}'"
  end

  if type == "fd" then
    return "--exclude '{" .. glob .. "}'"
  end

  utils.warn("Unknown type of filter [" .. type .. " ]. Exclusion string is not generated")
  return ""
end

local function get_rg_opts_grep(extra_opts)
  local extra_opts = extra_opts or {}

  local default_opts = {
    "--column",
    "--line-number",
    "--no-heading",
    "--color=always",
    "--smart-case",
    "--max-columns=512",
    get_ignore_glob("rg"),
  }

  local opts = utils.table_merge(default_opts, extra_opts)

  return utils.table_to_string(opts, " ")
end

local function get_rg_opts_files(extra_opts)
  local extra_opts = extra_opts or {}

  local default_opts = {
    "--color=never",
    "--files",
    "--hidden",
    "--follow",
    "--no-ignore",
    get_ignore_glob("rg"),
  }

  local opts = utils.table_merge(default_opts, extra_opts)

  return utils.table_to_string(opts, " ")
end
local function get_fd_opts_files(extra_opts)
  local extra_opts = extra_opts or {}

  local default_opts = {
    "--color=never",
    "--type=file",
    "--hidden",
    "--follow",
    "--no-ignore",
    get_ignore_glob("fd"),
  }

  local opts = utils.table_merge(default_opts, extra_opts)

  return utils.table_to_string(opts, " ")
end


plugin.setup {
  global_resume      = true,
  global_resume_query = true,
  winopts = {
    fullscreen       = true,
    hl = {
      cursorline     = 'PmenuSel', -- Only valid with the builtin previewer:
    },
    preview = {
      vertical       = 'down:50%',
      horizontal     = 'right:50%',
      layout         = 'flex',      -- horizontal|vertical|flex
      flip_columns   = 120,         -- #cols to switch to horizontal on flex
      -- Only valid with the builtin previewer:
      title          = true,
      scrollbar      = false,
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
      ["<C-p>"]     = "toggle-preview",
      ["<C-space>"] = "toggle-preview-cw", -- Rotate preview clockwise/counter-clockwise
      ["<C-d>"]     = "preview-page-down",
      ["<C-u>"]     = "preview-page-up",
      ["<C-z>"]     = "preview-page-reset",
    },
    fzf = {
      -- Most of the bindings are defined at the shell level, but it doesn't work
      -- for the following within 'fzf-lua' for some reason :shrug:
      ["ctrl-u"]     = "preview-half-page-up",
      ["ctrl-d"]     = "preview-half-page-down",
    },
  },
  ---------------------------------------------------------------------------------------
  -- PREVIEWERS SETUP
  ---------------------------------------------------------------------------------------
  previewers = {
    bat = {
      cmd             = "bat",
      args            = "--style=numbers,changes --color always",
      -- theme           = 'Coldark-Dark', -- bat preview theme (bat --list-themes)
      config          = nil,            -- nil uses $BAT_CONFIG_PATH
    },
    head = {
      cmd             = "head",
      args            = nil,
    },
    git_diff = {
      cmd_deleted     = "git diff --color HEAD --",
      cmd_modified    = "git diff --color HEAD",
      cmd_untracked   = "git diff --color --no-index /dev/null",
      pager           = "delta",
    },
    man = {
      cmd             = "man -c %s | col -bx",
    },
    builtin = {
      syntax          = true,
      syntax_limit_l  = 0,            -- syntax limit (lines), 0=nolimit
      syntax_limit_b  = 1024*1024,    -- syntax limit (bytes), 0=nolimit
    },
  },

  ---------------------------------------------------------------------------------------
  -- PROVIDERS SETUP
  ---------------------------------------------------------------------------------------
  files = {
    -- NOTE: This should search through pretty much all files, i.e. don't
    -- use .gitignore. But some annoying files/directories might still be excluded
    multiprocess      = true,
    git_icons         = false,
    file_icons        = false,
    -- cmd = "rg " .. get_rg_opts_files(),
    rg_opts           = get_rg_opts_files(),
    fd_opts           = get_fd_opts_files(),
    actions = {
      -- set bind to 'false' to disable an action
      -- ["default"]     = actions.file_edit_or_qf,
      -- ["ctrl-s"]      = actions.file_split,
      -- ["ctrl-v"]      = actions.file_vsplit,
      -- ["ctrl-t"]      = actions.file_tabedit,
      -- custom actions are available too
      -- ["ctrl-y"]      = function(selected) print(selected[1]) end,
    }
  },
  git = {
    files = {
      cmd             = 'git ls-files --exclude-standard',
      multiprocess    = true,
      git_icons       = false,
      file_icons      = false,
    },
    status = {
      cmd             = "git status -s",
      previewer       = "git_diff",
      git_icons       = true,
      file_icons      = false,
      actions = {
        ["right"]     = { actions.git_unstage, actions.resume },
        ["left"]      = { actions.git_stage, actions.resume },
      },
    },
    commits = {
      cmd             = "git log --pretty=oneline --abbrev-commit --color",
      preview         = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1} | delta",
      actions = {
        ["default"] = actions.git_checkout,
      },
    },
    bcommits = {
      cmd             = "git log --pretty=oneline --abbrev-commit --color",
      preview         = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1} | delta",
      actions = {
        ["default"] = actions.git_buf_edit,
        ["ctrl-s"]  = actions.git_buf_split,
        ["ctrl-v"]  = actions.git_buf_vsplit,
        ["ctrl-t"]  = actions.git_buf_tabedit,
      },
    },
    branches = {
      cmd             = "git branch --all --color",
      preview         = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
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
    multiprocess      = true,
    git_icons         = false,
    file_icons        = false,
    -- cmd            = "rg --vimgrep",
    rg_opts           = get_rg_opts_grep(),
    glob_flag         = "--iglob",  -- for case sensitive globs use '--glob'
    glob_separator    = "%s%-%-",    -- query separator pattern (lua): ' --'
    fzf_opts = {
      -- don't include filename into live search, tiebreak by line no.
      ['--delimiter'] = vim.fn.shellescape('[:]'),
      ["--nth"]  = '2..',
      ["--tiebreak"]  = 'index',
    },
  },
  args = { -- TODO: figure out what this does :shrug:
    files_only        = true,
    actions = {
      -- added on top of regular file actions
      ["ctrl-x"]      = actions.arg_del,
    }
  },
  oldfiles = {
    cwd_only          = true,
    git_icons         = false,
    file_icons        = false,
  },
  buffers = {
    git_icons         = false,
    file_icons        = false,
    sort_lastused     = true,
    actions = {
      -- ["default"]     = actions.buf_edit,
      -- ["ctrl-s"]      = actions.buf_split,
      -- ["ctrl-v"]      = actions.buf_vsplit,
      -- ["ctrl-t"]      = actions.buf_tabedit,
      -- by supplying a table of functions we're telling
      -- fzf-lua to not close the fzf window, this way we
      -- can resume the buffers picker on the same window
      -- eliminating an otherwise unaesthetic win "flash"
      ["ctrl-x"]      = { actions.buf_del, actions.resume },
    }
  },
  lines = {
    previewer         = "builtin",
    git_icons         = false,
    file_icons        = false,
    show_unlisted     = false,        -- exclude 'help' buffers
    no_term_buffers   = true,         -- exclude 'term' buffers
    fzf_opts = {
      -- do not include bufnr in fuzzy matching. tiebreak by line no.
      ['--delimiter'] = vim.fn.shellescape(']'),
      ["--nth"]       = '2..',
      ["--tiebreak"]  = 'index',
    },
    actions = {
      ["default"]     = actions.buf_edit,
      ["ctrl-s"]      = actions.buf_split,
      ["ctrl-v"]      = actions.buf_vsplit,
      ["ctrl-t"]      = actions.buf_tabedit,
    }
  },
  blines = {
    previewer         = "builtin",
    show_unlisted     = true,         -- include 'help' buffers
    no_term_buffers   = false,        -- include 'term' buffers
    fzf_opts = {
      -- hide filename, tiebreak by line no.
      ['--delimiter'] = vim.fn.shellescape('[:]'),
      ["--with-nth"]  = '2..',
      ["--tiebreak"]  = 'index',
    },
    actions = {
      ["default"]     = actions.buf_edit,
      ["ctrl-s"]      = actions.buf_split,
      ["ctrl-v"]      = actions.buf_vsplit,
      ["ctrl-t"]      = actions.buf_tabedit,
    }
  },
  quickfix = {
    file_icons        = false,
    git_icons         = false,
  },
  lsp = {
    cwd_only          = false,      -- LSP/diagnostics for cwd only?
    async_or_timeout  = 5000,       -- timeout(ms) or 'true' for async calls
    file_icons        = false,
    git_icons         = false,
    lsp_icons         = true,
    severity          = "hint",
    icons = {
      ["Error"]       = { icon = "E", color = "red" },
      ["Warning"]     = { icon = "W", color = "yellow" },
      ["Information"] = { icon = "I", color = "blue" },
      ["Hint"]        = { icon = "H", color = "magenta" },
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
}

-----------------------------------------------------------------------------------------
-- Convenience functions, since I don't want to pass parameters to the
-- underlying functions where I define mappings for them :shrug:
function M.lsp_references()
  return plugin.lsp_references({
    jump_to_single_result = true,
  })
end

function M.lsp_definitions()
  return plugin.lsp_definitions({
    jump_to_single_result = true,
  })
end

function M.lsp_typedefs()
  return plugin.lsp_typedefs({
    jump_to_single_result = true,
  })
end

function M.lsp_implementations()
  return plugin.lsp_implementations({
    jump_to_single_result = true,
  })
end

function M.lsp_code_actions()
  return plugin.lsp_code_actions({
    sync = true
  })
end

function M.lsp_document_symbols()
  return plugin.lsp_document_symbols({
    jump_to_single_result = true,
    fzf_cli_args = "--with-nth 2.."
  })
end

function M.lsp_live_workspace_symbols()
  return plugin.lsp_live_workspace_symbols({
    jump_to_single_result = true,
    fzf_cli_args = "--nth 2..",
  })
end

function M.lsp_document_diagnostics()
  return plugin.lsp_document_diagnostics({
    sync = true,
    -- fzf_cli_args = "--with-nth 2.." -- FIXME: this also hides severity :cry:
  })
end

function M.lsp_workspace_diagnostics()
  return plugin.lsp_workspace_diagnostics({})
end

function M.grep()
  return plugin.grep({
    fzf_cli_args = "--nth 2..",
    search = "",
  })
end

function M.git_status()
  return plugin.git_status({
    winopts = {
      preview = {
        layout='vertical',
      },
    },
  })
end

function M.grep_no_ignore()
  local opts = get_rg_opts_grep({"--no-ignore"})
  return plugin.grep({
    rg_opts = opts,
    search = "",
  })
end

return M
