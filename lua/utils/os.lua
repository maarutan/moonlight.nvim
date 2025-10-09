local M = {}

M.linux = "linux"
M.macos = "macos"
M.windows = "windows"
M.bsd = "bsd"
M.wsl = "wsl"

local cached_os, cached_id

function M.get_os()
	if cached_os then return cached_os end
	local sysname = vim.loop.os_uname().sysname

	if sysname == "Linux" then
		local uname = vim.fn.system("uname -r")
		if uname:match("microsoft") or uname:match("WSL") then
			cached_os = M.wsl
		else
			cached_os = M.linux
		end
	elseif sysname == "Darwin" then
		cached_os = M.macos
	elseif sysname:match("Windows") then
		cached_os = M.windows
	elseif sysname:match("BSD") then
		cached_os = M.bsd
	else
		cached_os = sysname
	end

	return cached_os
end

function M.get_os_id()
	if cached_id then return cached_id end
	if M.get_os() == M.linux or M.get_os() == M.wsl then
		local fd = io.open("/etc/os-release", "r")
		if fd then
			for line in fd:lines() do
				local id = line:match("^ID=(.+)")
				if id then
					id = id:gsub('"', ""):gsub("'", "")
					fd:close()
					cached_id = id
					return id
				end
			end
			fd:close()
		else
			vim.notify("Can't open /etc/os-release", vim.log.levels.WARN, { title = "OS" })
		end
	end
	cached_id = "unknown"
	return cached_id
end

return M
