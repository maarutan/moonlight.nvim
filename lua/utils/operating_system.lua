local M = {}

-- OS types
M.linux = "linux"
M.macos = "macos"
M.windows = "windows"

local cached_os

function M.get()
	if cached_os then
		return cached_os
	end

	local sysname = vim.loop.os_uname().sysname

	if sysname == "Darwin" then
		cached_os = M.macos
	elseif sysname == "Linux" then
		cached_os = M.linux
	elseif sysname:match("Windows") or sysname:match("NT") then
		cached_os = M.windows
	else
		cached_os = M.linux
	end

	return cached_os
end

M.windows = {}

local function ps_escape(path)
	return path:gsub("'", "''")
end

function M.windows.put_to_trash(path)
	if not path or path == "" then
		return false, "Empty path"
	end

	local ps = string.format(
		[[Add-Type -AssemblyName Microsoft.VisualBasic;
$p = '%s';
if (Test-Path $p -PathType Container) {
  [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory($p, 'OnlyErrorDialogs', 'SendToRecycleBin');
} elseif (Test-Path $p) {
  [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile($p, 'OnlyErrorDialogs', 'SendToRecycleBin');
} else {
  Write-Error 'Path not found';
  exit 1;
}]],
		ps_escape(path)
	)

	local ok = os.execute(string.format('powershell -NoProfile -Command "%s"', ps))
	return ok == 0 or ok == true
end

M.user = os.getenv("USER") or os.getenv("USERNAME")

function M.get_os_id()
	if cached_id then
		return cached_id
	end

	if M.get() == M.linux or M.get() == M.wsl then
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
