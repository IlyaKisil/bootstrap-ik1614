local logging = require("ik1614.functions.logging")

local M = {}
M.__index = M

function M.new()
  local self = setmetatable({}, M)
  return self
end

function M:get_buf_extension(buffer)
  local parts = vim.split(vim.api.nvim_buf_get_name(buffer), ".", {plain=true})
  return parts[#parts]
end

function M:get_buf_filename(buffer)
  local parts = vim.split(vim.api.nvim_buf_get_name(buffer), "/", {plain=true})
  return parts[#parts]
end

function M:is_environment_template()
  local filename = self:get_buf_filename(0)
  if filename == "environment.template" then
    return true
  end
  return false
end

function M:get_color_pallet(theme)
  local pallets = {
    onedark = function ()
      local style = self:get_color_pallet_style(theme)
      local colors = require('onedark.palette')[style]
      return colors
    end
  }
  return pallets[theme]()
end

function M:get_color_pallet_style(theme)
  local styles = {
    -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    onedark = "warm"
  }
  return styles[theme]
end

function M:load_plugin(name)
  local ok, plugin = pcall(require, name)
  if not ok then
    logging:warn("Plugin ["  .. name .. "] is not installed")
    return
  end
  return plugin
end

function M:reload_plugins(plugins)
  for _, name in pairs(plugins) do
    local plugin_config_path = self:table_to_string(
      {
        self:get_plugins_config_dir(),
        name,
        "init.lua",
      },
      "/"
    )
    if not self:is_file(plugin_config_path) then
      local message = "Plugin config ["  .. plugin_config_path .. "] does not exists"
      logging:warn(message)
      vim.notify(message, "warn")
      return
    end
    local command = "source " .. plugin_config_path
    vim.cmd(command)
    vim.notify("Reloaded configuration of [" .. name .. "] plugin")
  end
end

function M:plugin_installed(name)
  if not pcall(require, name) then
    logging:warn("Plugin ["  .. name .. "] is not installed")
    return
  end
  return true
end

-- Merge two tables without mutation
function M:table_merge(t1, t2)
  local result = {}

  for _, v in ipairs(t1) do
    table.insert(result, v)
  end

  for _, v in ipairs(t2) do
    table.insert(result, v)
  end

  return result
end

function M:table_to_string(t, separator)
  local result = ""

  for _, v in pairs(t) do
      result = result .. separator .. v
  end

  -- Remove first hanging separtor
  result = result:sub(2)

  return result
end

function M:find_cmd(cmd, prefixes, start_from, stop_at)
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

function M:toggle(option, silent)
  local info = vim.api.nvim_get_option_info(option)
  local scopes = { buf = "bo", win = "wo", global = "o" }
  local scope = scopes[info.scope]
  local options = vim[scope]
  options[option] = not options[option]
  if silent ~= true then
    if options[option] then
      logging:info("enabled vim." .. scope .. "." .. option, "Toggle")
    else
      logging:warn("disabled vim." .. scope .. "." .. option, "Toggle")
    end
  end
end

---Get the full path to directory with plugin configurations
---@return string
function M:get_plugins_config_dir()
  local home = os.getenv "HOME"
  return home .. "/.config/nvim/after/plugin"
end

--- Checks whether a given path exists and is a file.
--@param path (string) path to check
--@returns (bool)
function M:is_file(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file" or false
end

--- Checks whether a given path exists and is a directory
--@param path (string) path to check
--@returns (bool)
function M:is_directory(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "directory" or false
end

return M.new()
