local utils = require("ik1614.functions.utils")
local logging = require("ik1614.functions.logging")

local M = {}
M.__index = M

function M.new()
  local self = setmetatable({}, M)
  local plugin_name = "fzf-lua"

  if not utils:plugin_installed(plugin_name) then
    logging:error("Failed to define custom functions based on [" .. plugin_name .. "] plugin")
    return {}
  end

  self.plugin = require(plugin_name)
  return self
end

function M:get_fzf_for_grep_opts()
  -- * Don't include filename into live search
  -- * Make sure that `fzf` filtering doesn't skip entries
  -- * Tiebreak by line no.
  return {
    ["--delimiter"] = vim.fn.shellescape("[:]"),
    ["--nth"] = "2..",
    ["--tiebreak"] = "index",
    ["--multi"] = "",
  }
end

function M:get_ignore_glob(type)
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

  local glob = utils:table_to_string(ignore, ",")

  if type == "rg" then
    return "--glob '!{" .. glob .. "}'"
  end

  if type == "fd" then
    return "--exclude '{" .. glob .. "}'"
  end

  logging:warn("Unknown type of filter [" .. type .. " ]. Exclusion string is not generated")
  return ""
end

function M:get_rg_opts_grep(extra_opts)
  local extra_opts = extra_opts or {}

  local default_opts = {
    "--with-filename", -- To make result compatible with previewers, the result of `rg` must contain file name
    "--column",
    "--line-number",
    "--no-heading",
    "--color=always",
    "--smart-case",
    "--max-columns=512",
    "--hidden",
    self:get_ignore_glob("rg"),
  }

  local opts = utils:table_merge(default_opts, extra_opts)

  return utils:table_to_string(opts, " ")
end

function M:get_rg_opts_files(extra_opts)
  local extra_opts = extra_opts or {}

  local default_opts = {
    "--color=never",
    "--files",
    "--hidden",
    "--follow",
    "--no-ignore",
    self:get_ignore_glob("rg"),
  }

  local opts = utils:table_merge(default_opts, extra_opts)

  return utils:table_to_string(opts, " ")
end

function M:get_fd_opts_files(extra_opts)
  local extra_opts = extra_opts or {}

  local default_opts = {
    "--color=never",
    "--type=file",
    "--hidden",
    "--follow",
    "--no-ignore",
    self:get_ignore_glob("fd"),
  }

  local opts = utils:table_merge(default_opts, extra_opts)

  return utils:table_to_string(opts, " ")
end

function M:git_status()
  local pager_flip_threshold = 120

  -- Not sure where this offset comes from but looks like it is related to sign column etc
  local offset = 6

  -- Don't use `vim.api.nvim_win_get_width(0)` in case there are splits
  local window_width = vim.o.columns - offset

  local preview_pager = "delta"

  if window_width > pager_flip_threshold then
    preview_pager = ("%s --side-by-side --width %s"):format(preview_pager, window_width)
  end

  return self.plugin.git_status({
    winopts = {
      preview = {
        layout = "vertical",
        vertical = "down:80%",
      },
    },
    preview_pager = preview_pager,
  })
end

function M:grep_no_ignore()
  local opts = self:get_rg_opts_grep({ "--no-ignore" })
  return self.plugin.grep({
    rg_opts = opts,
    search = "",
  })
end

function M:grep()
  return self.plugin.grep({
    fzf_cli_args = "--nth 2..",
    search = "",
  })
end

function M:grep_selected_files(data)
  local rg_opts = self:get_rg_opts_grep()
  local command = ("rg %s '' %s"):format(rg_opts, utils:table_to_string(data, " "))

  return self.plugin.fzf_exec(command, {
    fn_transform = function(x)
      return self.plugin.make_entry.file(x, { file_icons = false, color_icons = false })
    end,
    fzf_opts = self:get_fzf_for_grep_opts(),
    previewer = "builtin",
    prompt = "Grep in selected> ",
    actions = {
      ["default"] = self.plugin.actions.file_edit_or_qf,
      ["ctrl-s"] = self.plugin.actions.file_split,
      ["ctrl-v"] = self.plugin.actions.file_vsplit,
      ["ctrl-t"] = self.plugin.actions.file_tabedit,
      ["ctrl-r"] = function(selected)
        self:files_of_selected_lines(selected)
      end,
    },
  })
end

function M:files_of_selected_lines(data)
  -- TODO: keep location of the selected lines.
  local selected_files = {}
  local unique_files = {}
  for _, v in pairs(data) do
    local file_name = string.match(v, "(.-):") -- Split by ':' and get first item
    if not unique_files[file_name] then
      unique_files[file_name] = true
      table.insert(selected_files, file_name)
    end
  end

  self.plugin.fzf_exec(selected_files, {
    fzf_opts = self:get_fzf_for_grep_opts(), -- NOTE: might need to have some options when location of selected lines will be preserved.
    previewer = "builtin",
    prompt = "Files from selected> ",
    actions = {
      ["default"] = self.plugin.actions.file_edit_or_qf,
      ["ctrl-s"] = self.plugin.actions.file_split,
      ["ctrl-v"] = self.plugin.actions.file_vsplit,
      ["ctrl-t"] = self.plugin.actions.file_tabedit,
      ["ctrl-r"] = function(selected)
        self:grep_selected_files(selected)
      end,
    },
  })
end

function M:reload_select_plugins()
  return self.plugin.fzf_exec("ls " .. utils:get_plugins_config_dir(), {
    prompt = "Plugins to reload> ",
    actions = {
      ["default"] = function(selected)
        utils:reload_plugins(selected)
      end,
    },
    winopts = {
      height = 0.33,
      width = 0.33,
    },
  })
end

function M:lsp_references()
  return self.plugin.lsp_references({
    jump_to_single_result = true,
    winopts = {
      preview = {
        layout = "vertical",
        vertical = "down:75%",
      },
    },
  })
end

function M:lsp_definitions()
  return self.plugin.lsp_definitions({
    jump_to_single_result = true,
    winopts = {
      preview = {
        layout = "vertical",
        vertical = "down:75%",
      },
    },
  })
end

function M:lsp_typedefs()
  return self.plugin.lsp_typedefs({
    jump_to_single_result = true,
    winopts = {
      preview = {
        layout = "vertical",
        vertical = "down:75%",
      },
    },
  })
end

function M:lsp_implementations()
  return self.plugin.lsp_implementations({
    jump_to_single_result = true,
    winopts = {
      preview = {
        layout = "vertical",
        vertical = "down:75%",
      },
    },
  })
end

function M:lsp_code_actions()
  return self.plugin.lsp_code_actions({
    sync = true,
    winopts = {
      height = 0.75,
      width = 0.75,
      preview = {
        layout = "vertical",
        vertical = "down:75%",
      },
    },
    previewer = "codeaction_native",
    pager = [[delta --width=$COLUMNS --hunk-header-style="omit" --file-style="omit"]],
  })
end

function M:lsp_document_symbols()
  return self.plugin.lsp_document_symbols({
    jump_to_single_result = true,
    fzf_cli_args = "--with-nth 2..",
    winopts = {
      preview = {
        layout = "vertical",
        vertical = "down:75%",
      },
    },
  })
end

function M:lsp_live_workspace_symbols()
  return self.plugin.lsp_live_workspace_symbols({
    jump_to_single_result = true,
    fzf_cli_args = "--nth 2..",
    winopts = {
      preview = {
        layout = "vertical",
        vertical = "down:75%",
      },
    },
  })
end

function M:show_document_diagnostics()
  return self.plugin.lsp_document_diagnostics({
    sync = true,
    winopts = {
      preview = {
        layout = "vertical",
        vertical = "down:75%",
      },
    },
    -- fzf_cli_args = "--with-nth 2.." -- FIXME: this also hides severity :cry:
  })
end

function M:show_workspace_diagnostics()
  return self.plugin.lsp_workspace_diagnostics({
    winopts = {
      preview = {
        layout = "vertical",
        vertical = "down:75%",
      },
    },
  })
end

function M:dap_configurations()
  return self.plugin.dap_configurations({
    winopts = {
      height = 0.33,
      width = 0.33,
    },
  })
end

function M:dap_breakpoints()
  return self.plugin.dap_breakpoints({
    winopts = {
      preview = {
        layout = "vertical",
        vertical = "down:75%",
      },
    },
  })
end

function M:dap_commands()
  return self.plugin.dap_commands({
    winopts = {
      height = 0.33,
      width = 0.33,
    },
  })
end

function M:dap_ui_float()
  return self.plugin.fzf_exec({
    "console",
    "repl",
    "scopes",
    "watches",
    "stacks",
    "breakpoints",
  }, {
    prompt = "DAP UI Float> ",
    actions = {
      ["default"] = function(selected)
        require("dapui").float_element(selected[1], {
          enter = true,
          -- width = math.floor(vim.api.nvim_win_get_width(0) * 0.85),
          -- height = math.floor(vim.api.nvim_win_get_height(0) * 0.85),
          position = "center",
        })
      end,
    },
    winopts = {
      height = 0.33,
      width = 0.33,
    },
  })
end

return M.new()
