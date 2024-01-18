local M = {}
M.__index = M

function M.new()
  local self = setmetatable({}, M)
  return self
end

-- Main functions.for mappings
-- By default it does NOT do recursive remap
function M:_map(mode, tbl)
  vim.keymap.set(mode, tbl[1], tbl[2], tbl[3])
end

-- Mapping local to a buffer
function M:_buf_map(mode, tbl)
  if tbl[3] == nil then
    tbl[3] = {}
  end
  tbl[3].buffer = 0
  self:_map(mode, tbl)
end

function M:c(tbl)
  self:_map("c", tbl)
end

function M:n(tbl)
  self:_map("n", tbl)
end

function M:i(tbl)
  self:_map("i", tbl)
end

function M:v(tbl)
  self:_map("v", tbl)
end

function M:x(tbl)
  self:_map("x", tbl)
end

function M:buf_i(tbl)
  self:_buf_map("i", tbl)
end

function M:buf_n(tbl)
  self:_buf_map("n", tbl)
end

return M.new()
