--- @class Which
local Which = {}
Which.__index = Which

--- @param name string|nil
--- @return Which
function Which:new(name)
  local obj = setmetatable({}, self)
  obj.name = name or ""
  return obj
end

--- @param module string
--- @return boolean, any
function Which:is_module_has(module)
  local ok, mod = pcall(require, module)
  if ok then
    return true, mod
  else
    return false, nil
  end
end

--- @param cmd string
--- @return boolean
function Which:is_exists(cmd)
  return vim.fn.executable(cmd) == 1
end

return setmetatable({}, Which)
