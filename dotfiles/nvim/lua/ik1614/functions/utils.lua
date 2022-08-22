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


return M.new()
