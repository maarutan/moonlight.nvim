local json = vim.json

local M = {}

M.encode = json.encode
M.decode = json.decode

local function ensure_parent_dir(path)
	local dir = vim.fn.fnamemodify(path, ":h")
	if dir ~= "" then
		vim.fn.mkdir(dir, "p")
	end
end

---@param path string
---@param data table
---@return boolean success
function M.save_file(path, data)
	ensure_parent_dir(path)

	local file, err = io.open(path, "w")
	if not file then
		vim.notify("JSON save error: " .. tostring(err), vim.log.levels.ERROR)
		return false
	end

	local ok, encoded = pcall(json.encode, data)
	if not ok then
		vim.notify("JSON encode error: " .. tostring(encoded), vim.log.levels.ERROR)
		file:close()
		return false
	end

	file:write(encoded)
	file:close()
	return true
end

---@param path string
---@return table|nil
function M.load_file(path)
	local file = io.open(path, "r")
	if not file then
		return nil
	end

	local content = file:read("*all")
	file:close()

	if not content or content == "" then
		return nil
	end

	local ok, decoded = pcall(json.decode, content)
	if not ok then
		vim.notify("JSON decode error: " .. tostring(decoded), vim.log.levels.ERROR)
		return nil
	end

	if type(decoded) ~= "table" then
		return nil
	end

	return decoded
end

---@param path string
---@param new_data table
---@return boolean success
function M.update(path, new_data)
	local data = M.load_file(path) or {}

	if type(new_data) ~= "table" then
		vim.notify("JSON update error: new_data must be a table", vim.log.levels.ERROR)
		return false
	end

	for key, value in pairs(new_data) do
		data[key] = value
	end

	return M.save_file(path, data)
end

---@param path string
---@param key string
---@param default any
---@return any
function M.get(path, key, default)
	local data = M.load_file(path)
	if not data then
		return default
	end

	local value = data[key]
	if value == nil then
		return default
	end

	return value
end

---@param path string
---@param key string
---@return boolean success
function M.remove_key(path, key)
	local data = M.load_file(path)
	if not data then
		return false
	end

	data[key] = nil
	return M.save_file(path, data)
end

---@param path string
---@return boolean success
function M.clear(path)
	return M.save_file(path, {})
end

return M
