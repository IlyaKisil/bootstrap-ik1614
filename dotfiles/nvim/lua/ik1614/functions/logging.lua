local M = {}
M.__index = M

function M:new()
  local self = setmetatable({}, M)
  return self
end

function M:log(level, msg, name)
  local name = name or "ik1614"
  local time = os.date("%X")
  local hl_map = {
    ERROR = "ErrorMessage",
    WARN = "WarnMessage",
    INFO = "InfoMessage",
    DEBUG = "DebugMessage",
    TRACE = "TraceMessage",
  }
  local hl = hl_map[level]
  vim.api.nvim_echo({ { name .. " " .. time .. " " .. level .. ": ", hl }, { msg } }, true, {})
end

function M:error(msg, name)
  self:log("ERROR", msg, name)
end

function M:warn(msg, name)
  self:log("WARN", msg, name)
end

function M:info(msg, name)
  self:log("INFO", msg, name)
end

function M:debug(msg, name)
  self:log("DEBUG", msg, name)
end

return M.new()
