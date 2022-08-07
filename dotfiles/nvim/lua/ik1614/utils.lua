local M = {}

M.functions = {}

function M.plugin_installed(name)
  if not pcall(require, name) then
    M.warn("Plugin ["  .. name .. "] is not installed")
    return
  end
  return true
end

function M.execute(id)
  local func = M.functions[id]
  if not func then
    error("Function doest not exist: " .. id)
  end
  return func()
end

local map = function(mode, key, cmd, opts, defaults)
  opts = vim.tbl_deep_extend("force", { silent = true }, defaults or {}, opts or {})

  if type(cmd) == "function" then
    table.insert(M.functions, cmd)
    if opts.expr then
      cmd = ([[luaeval('require("ik1614.utils").execute(%d)')]]):format(#M.functions)
    else
      cmd = ("<cmd>lua require('ik1614.utils').execute(%d)<cr>"):format(#M.functions)
    end
  end
  if opts.buffer ~= nil then
    local buffer = opts.buffer
    opts.buffer = nil
    return vim.api.nvim_buf_set_keymap(buffer, mode, key, cmd, opts)
  else
    return vim.api.nvim_set_keymap(mode, key, cmd, opts)
  end
end

function M.map(mode, key, cmd, opt, defaults)
  return map(mode, key, cmd, opt, defaults)
end

function M.nmap(key, cmd, opts)
  return map("n", key, cmd, opts)
end
function M.vmap(key, cmd, opts)
  return map("v", key, cmd, opts)
end
function M.xmap(key, cmd, opts)
  return map("x", key, cmd, opts)
end
function M.imap(key, cmd, opts)
  return map("i", key, cmd, opts)
end
function M.omap(key, cmd, opts)
  return map("o", key, cmd, opts)
end
function M.smap(key, cmd, opts)
  return map("s", key, cmd, opts)
end

function M.nnoremap(key, cmd, opts)
  return map("n", key, cmd, opts, { noremap = true })
end
function M.vnoremap(key, cmd, opts)
  return map("v", key, cmd, opts, { noremap = true })
end
function M.xnoremap(key, cmd, opts)
  return map("x", key, cmd, opts, { noremap = true })
end
function M.inoremap(key, cmd, opts)
  return map("i", key, cmd, opts, { noremap = true })
end
function M.onoremap(key, cmd, opts)
  return map("o", key, cmd, opts, { noremap = true })
end
function M.snoremap(key, cmd, opts)
  return map("s", key, cmd, opts, { noremap = true })
end

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.log(level, msg, name)
  local name = name or "ik1614"
  local time = os.date("%X")
  local hl_map = {
    WARN  = "WarningMessage",
    ERROR = "ErrorMessage",
    INFO  = "InfoMessage",
    DEBUG = "HintMessage",
  }
  local hl = hl_map[level]
  vim.api.nvim_echo({ { name .. " " .. time .. " " .. level .. ": ", hl }, { msg } }, true, {})
end

function M.error(msg, name)
  M.log("ERROR", msg, name)
end

function M.warn(msg, name)
  M.log("WARN", msg, name)
end

function M.info(msg, name)
  M.log("INFO", msg, name)
end

function M.debug(msg, name)
  M.log("DEBUG", msg, name)
end

function M.find_cmd(cmd, prefixes, start_from, stop_at)
    local path = require("lspconfig/util").path

    if type(prefixes) == "string" then
        prefixes = { prefixes }
    end

    local found
    for _, prefix in ipairs(prefixes) do
        local full_cmd = prefix and path.join(prefix, cmd) or cmd
        local possibility

        -- if start_from is a dir, test it first since transverse will start from its parent
        if start_from and path.is_dir(start_from) then
            possibility = path.join(start_from, full_cmd)
            if vim.fn.executable(possibility) > 0 then
                found = possibility
                break
            end
        end

        path.traverse_parents(start_from, function(dir)
            possibility = path.join(dir, full_cmd)
            if vim.fn.executable(possibility) > 0 then
                found = possibility
                return true
            end
            -- use cwd as a stopping point to avoid scanning the entire file system
            if stop_at and dir == stop_at then
                return true
            end
        end)

        if found ~= nil then
            break
        end
    end

    return found or cmd
end

function M.toggle(option, silent)
  local info = vim.api.nvim_get_option_info(option)
  local scopes = { buf = "bo", win = "wo", global = "o" }
  local scope = scopes[info.scope]
  local options = vim[scope]
  options[option] = not options[option]
  if silent ~= true then
    if options[option] then
      M.info("enabled vim." .. scope .. "." .. option, "Toggle")
    else
      M.warn("disabled vim." .. scope .. "." .. option, "Toggle")
    end
  end
end

-- Merge two tables without mutation
function M.table_merge(t1, t2)
  local result = {}

  for _, v in ipairs(t1) do
    table.insert(result, v)
  end

  for _, v in ipairs(t2) do
    table.insert(result, v)
  end

  return result
end

function M.table_to_string(t, separator)
  local result = ""

  for _, v in pairs(t) do
      result = result .. separator .. v
  end

  -- Remove first hanging separtor
  result = result:sub(2)

  return result
end


-- NOTE: This isn't really needed. Instead of using ',' and ';' you can just
-- keep using 'f' or 'F' with the 'mini.jump' plugin. For example, instead of
-- 'fo,,,' the same can be done with 'fofff'
function M.repeat_jump_in_oposite_direction()
  local state = {}
  for k, v in pairs(MiniJump.state) do
    state[k] = v
  end
  MiniJump.smart_jump(not MiniJump.state.backward)
  MiniJump.state = state
end

return M
