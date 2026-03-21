local M = {}

function M.lua_pat_escape(s)
	return (s:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1"))
end

function M.ensure_parent_dir(path)
	local dir = vim.fn.fnamemodify(path, ":h")
	if dir ~= "" then
		vim.fn.mkdir(dir, "p")
	end
end

function M.read_file(path)
	local f = io.open(path, "r")
	if not f then
		return ""
	end
	local c = f:read("*a")
	f:close()
	return c or ""
end

function M.write_file(path, content)
	M.ensure_parent_dir(path)
	local f = io.open(path, "w")
	if not f then
		return false
	end
	f:write(content or "")
	f:close()
	return true
end

return M
