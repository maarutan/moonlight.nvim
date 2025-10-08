local M = {}

M.linux = "linux"
M.macos = "macos"
M.windows = "windows"

function M.get_os()
	local sysname = vim.loop.os_uname().sysname
	if sysname == "Linux" then
		return M.linux
	elseif sysname == "Darwin" then
		return M.macos
	elseif sysname:match("Windows") then
		return M.windows
	else
		return sysname
	end
end

function M.get_os_id()
	if M.get_os() == M.linux then
		local fd = io.open("/etc/os-release", "r")
		if fd then
			for line in fd:lines() do
				local id = line:match("^ID=(.+)")
				if id then
					id = id:gsub('"', ""):gsub("'", "")
					fd:close()
					return id
				end
			end
			fd:close()
		else
			vim.notify("Can't open /etc/os-release", vim.log.levels.WARN, { title = "OS" })
		end
	end
end

return M
