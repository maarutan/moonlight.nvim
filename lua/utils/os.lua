local M = {}

-- ================================
-- 🧭 OS DETECTION
-- ================================
M.linux = "linux"
M.macos = "macos"
M.windows = "windows"
M.bsd = "bsd"
M.wsl = "wsl"

local cached_os, cached_id

function M.get()
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
	elseif sysname:match("Windows") or sysname:match("NT") then
		cached_os = M.windows
	elseif sysname:match("BSD") then
		cached_os = M.bsd
	else
		cached_os = sysname
	end

	return cached_os
end

-- ================================
-- 🐧 LINUX DISTRO DETECTION
-- ================================
function M.get_os_id()
	if cached_id then return cached_id end

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

-- ================================
-- 🪟 WINDOWS TRASH HANDLER
-- ================================
M.windows = {}

--- Escape single quotes for PowerShell safely
---@param path string
---@return string
local function ps_escape(path) return path:gsub("'", "''") end

--- Move file or directory to Windows Recycle Bin
---@param path string
---@return boolean success, string|nil error
function M.windows.put_to_trash(path)
	if not path or path == "" then return false, "Empty path" end

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

	local cmd = string.format('powershell -NoProfile -Command "%s"', ps)

	local ok = os.execute(cmd)
	if ok == 0 or ok == true then
		return true
	else
		return false, "Failed to send to Recycle Bin"
	end
end

return M
