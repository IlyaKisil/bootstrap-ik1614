local utils = require("ik1614.utils")

local M = {}
M.__index = M

function M.new()
  local self = setmetatable({}, M)
  local plugin_name = "fzf-lua"

  if not utils.plugin_installed(plugin_name) then
    utils.error("Failed to define custom functions based on [" .. plugin_name .. "] plugin")
    return {}
  end

  self.plugin = require(plugin_name)
  return self
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

function M:get_rg_opts_grep(extra_opts)
  local extra_opts = extra_opts or {}

  local default_opts = {
    "--column",
    "--line-number",
    "--no-heading",
    "--color=always",
    "--smart-case",
    "--max-columns=512",
    self:get_ignore_glob("rg"),
  }

  local opts = utils.table_merge(default_opts, extra_opts)

  return utils.table_to_string(opts, " ")
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

  local opts = utils.table_merge(default_opts, extra_opts)

  return utils.table_to_string(opts, " ")
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

  local opts = utils.table_merge(default_opts, extra_opts)

  return utils.table_to_string(opts, " ")
end

function M:git_status()
  return self.plugin.git_status({
    winopts = {
      preview = {
        layout='vertical',
        vertical = 'down:75%',
      },
    },
    -- FIXME: this doesn't seem to be having any affect :shrug:
    previewers = {
      git_diff = {
        pager = "delta --side-by-side -w 120",
      },
    }
  })
end

function M:grep_no_ignore()
  local opts = self:get_rg_opts_grep({"--no-ignore"})
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

function M:lsp_references()
  return self.plugin.lsp_references({
    jump_to_single_result = true,
    winopts = {
      preview = {
        layout   = 'vertical',
        vertical = 'down:75%',
      },
    },
  })
end

function M:lsp_definitions()
  return self.plugin.lsp_definitions({
    jump_to_single_result = true,
    winopts = {
      preview = {
        layout   = 'vertical',
        vertical = 'down:75%',
      },
    },
  })
end

function M:lsp_typedefs()
  return self.plugin.lsp_typedefs({
    jump_to_single_result = true,
    winopts = {
      preview = {
        layout   = 'vertical',
        vertical = 'down:75%',
      },
    },
  })
end

function M:lsp_implementations()
  return self.plugin.lsp_implementations({
    jump_to_single_result = true,
    winopts = {
      preview = {
        layout   = 'vertical',
        vertical = 'down:75%',
      },
    },
  })
end

function M:lsp_code_actions()
  return self.plugin.lsp_code_actions({
    sync = true,
    winopts = {
      height=0.33,
      width=0.33,
    }
  })
end

function M:lsp_document_symbols()
  return self.plugin.lsp_document_symbols({
    jump_to_single_result = true,
    fzf_cli_args = "--with-nth 2..",
    winopts = {
      preview = {
        layout   = 'vertical',
        vertical = 'down:75%',
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
        layout   = 'vertical',
        vertical = 'down:75%',
      },
    },
  })
end

function M:lsp_document_diagnostics()
  return self.plugin.lsp_document_diagnostics({
    sync = true,
    winopts = {
      preview = {
        layout   = 'vertical',
        vertical = 'down:75%',
      },
    },
    -- fzf_cli_args = "--with-nth 2.." -- FIXME: this also hides severity :cry:
  })
end

function M:lsp_workspace_diagnostics()
  return self.plugin.lsp_workspace_diagnostics({
    winopts = {
      preview = {
        layout   = 'vertical',
        vertical = 'down:75%',
      },
    },
  })
end

return M.new()
