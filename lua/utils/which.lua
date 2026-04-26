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
		vim.notify(
			string.format("Missing method '%s' in table", method),
			vim.log.levels.WARN,
			{ title = "Which" }
		)
		return false
	end

	return true
end

---@param method function
--- @return boolean
function Which:is_method_exists(method)
	return type(method) == "function"
end

--- @param cmd string
--- @return boolean
function Which:is_exists(cmd)
	return vim.fn.executable(cmd) == 1
end

--- @param module_name string
--- @param setup_table table
--- @return boolean ok, string|nil err
function Which:safe_setup(module_name, setup_table)
	local ok, mod = self:is_module_exists(module_name)
	if not ok then
		return false, "Module '" .. module_name .. "' not found"
	end

	if type(mod.setup) ~= "function" then
		return false, "Module '" .. module_name .. "' has no setup()"
	end

	local ok_setup, err = pcall(mod.setup, setup_table)
	if not ok_setup then
		return false, err
	end

	return true
end

return setmetatable({}, Which)
