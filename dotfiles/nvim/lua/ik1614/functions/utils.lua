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

return M.new()
