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
function Which:is_module_exists(module)
	local ok, mod = pcall(require, module)
	if ok then
		return true, mod
	else
		return false, nil
	end
end

--- @param tbl table
--- @param method string
--- @return boolean
function Which:ensure_method(tbl, method)
	if type(tbl) ~= "table" then
		vim.notify("Expected table, got " .. type(tbl), vim.log.levels.ERROR, { title = "Which" })
		return false
	end

	local fn = tbl[method]
	if type(fn) ~= "function" then
		vim.notify(string.format("Missing method '%s' in table", method), vim.log.levels.WARN, { title = "Which" })
		return false
	end

	return true
end

---@param method function
--- @return boolean
function Which:is_method_exists(method) return type(method) == "function" end

--- @param cmd string
--- @return boolean
function Which:is_exists(cmd) return vim.fn.executable(cmd) == 1 end

return setmetatable({}, Which)
