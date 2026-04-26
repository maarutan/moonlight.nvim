local icons = require("utils.constants.icons")

local Trash_cli = {}
Trash_cli.__index = Trash_cli

local uv = vim.loop
local fn = vim.fn
local json = vim.json

local state_file = fn.stdpath("data") .. "/trash_cli_windows.json"

function Trash_cli:new()
	return setmetatable({}, self)
end

function Trash_cli:is_directory(path)
	local stat = uv.fs_stat(path)
	return stat and stat.type == "directory"
end

function Trash_cli:is_file(path)
	local stat = uv.fs_stat(path)
	return stat and stat.type == "file"
end

function Trash_cli:_read_state()
	local file = io.open(state_file, "r")
	if not file then
		return {}
	end

	local content = file:read("*a")
	file:close()

	if not content or content == "" then
		return {}
	end

	local ok, decoded = pcall(json.decode, content)
	if not ok or type(decoded) ~= "table" then
		return {}
	end

	return decoded
end

function Trash_cli:_write_state(data)
	local file = io.open(state_file, "w")
	if not file then
		return nil, "Failed to open state file: " .. state_file
	end

	file:write(json.encode(data))
	file:close()

	return true
end

function Trash_cli:_basename(path)
	return path:match("([^\\/]+)$")
end

function Trash_cli:_dirname(path)
	return path:match("^(.*)[/\\][^/\\]+$")
end

function Trash_cli:_ensure_dir(path)
	if not path or path == "" then
		return false
	end

	if fn.isdirectory(path) == 1 then
		return true
	end

	fn.mkdir(path, "p")
	return fn.isdirectory(path) == 1
end

function Trash_cli:_powershell(script)
	local cmd = "powershell -NoProfile -ExecutionPolicy Bypass -Command " .. fn.shellescape(script)
	local result = fn.system(cmd)

	if vim.v.shell_error ~= 0 then
		return nil, result
	end

	return result
end

function Trash_cli:_escape_ps_string(str)
	return tostring(str):gsub("'", "''")
end

function Trash_cli:_normalize_path(path)
	return fn.fnamemodify(path, ":p"):gsub("/", "\\")
end

function Trash_cli:_get_last_restorable()
	local state = self:_read_state()
	if #state == 0 then
		return nil, nil
	end

	return #state, state[#state]
end

function Trash_cli:put(path)
	path = self:_normalize_path(path)

	if uv.fs_stat(path) == nil then
		return nil, "Path does not exist: " .. path
	end

	local escaped = self:_escape_ps_string(path)

	local script = ([[
Add-Type -AssemblyName Microsoft.VisualBasic
[Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile(
	'%s',
	'OnlyErrorDialogs',
	'SendToRecycleBin'
)
]]):format(escaped)

	if self:is_directory(path) then
		script = ([[
Add-Type -AssemblyName Microsoft.VisualBasic
[Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory(
	'%s',
	'OnlyErrorDialogs',
	'SendToRecycleBin'
)
]]):format(escaped)
	end

	local result, err = self:_powershell(script)
	if not result then
		return nil, err
	end

	local state = self:_read_state()
	table.insert(state, {
		original_path = path,
		filename = self:_basename(path),
		timestamp = os.time(),
	})

	local ok, write_err = self:_write_state(state)
	if not ok then
		return nil, write_err
	end

	return result
end

function Trash_cli:last_restorable_name()
	local _, entry = self:_get_last_restorable()
	if not entry then
		return nil
	end

	return entry.filename or (entry.original_path and self:_basename(entry.original_path)) or nil
end

function Trash_cli:restore()
	local index, entry = self:_get_last_restorable()
	if not entry then
		vim.notify("Trash is empty", vim.log.levels.WARN, { title = "Restore" })
		return
	end

	local original_path = entry.original_path
	local filename = entry.filename
		or (original_path and self:_basename(original_path))
		or "Unknown"

	if not original_path or original_path == "" then
		vim.notify("Invalid restore entry", vim.log.levels.ERROR, { title = "Restore" })
		return
	end

	local restore_dir = self:_dirname(original_path)
	if not self:_ensure_dir(restore_dir) then
		vim.notify(
			"Failed to create restore directory:\n" .. tostring(restore_dir),
			vim.log.levels.ERROR,
			{ title = "Restore" }
		)
		return
	end

	local restore_path = original_path

	if uv.fs_stat(restore_path) ~= nil then
		local stem, ext = filename:match("^(.*)%.([^%.]+)$")
		if not stem then
			stem = filename
			ext = nil
		end

		local i = 1
		while true do
			local candidate
			if ext then
				candidate = string.format("%s\\%s_restored_%d.%s", restore_dir, stem, i, ext)
			else
				candidate = string.format("%s\\%s_restored_%d", restore_dir, stem, i)
			end

			if uv.fs_stat(candidate) == nil then
				restore_path = candidate
				break
			end

			i = i + 1
		end
	end

	-- restore only from items sent to recycle bin by this module
	-- picks the newest matching item by original filename from Recycle Bin
	local escaped_filename = self:_escape_ps_string(filename)
	local escaped_restore_path = self:_escape_ps_string(restore_path)

	local script = ([[
$shell = New-Object -ComObject Shell.Application
$bin = $shell.Namespace(10)

if (-not $bin) {
	Write-Error "Recycle Bin is unavailable"
	exit 1
}

$item = $bin.Items() |
	Where-Object { $_.Name -eq '%s' } |
	Select-Object -First 1

if (-not $item) {
	Write-Error "Matching item not found in Recycle Bin"
	exit 1
}

Move-Item -LiteralPath $item.Path -Destination '%s'
]]):format(escaped_filename, escaped_restore_path)

	local result, err = self:_powershell(script)
	if not result then
		vim.notify(
			"Failed to restore:\n" .. tostring(err),
			vim.log.levels.ERROR,
			{ title = "Restore" }
		)
		return
	end

	local state = self:_read_state()
	table.remove(state, index)
	self:_write_state(state)

	local filetype = "Unknown " .. icons.emoji.unknown
	if self:is_directory(restore_path) then
		filetype = "Directory " .. icons.emoji.dir
	elseif self:is_file(restore_path) then
		filetype = "File " .. icons.emoji.file
	end

	vim.notify(
		string.format(
			"%s Restored:\n• Name: %s\n• Type: %s\n• Path: %s",
			icons.emoji.restore,
			filename,
			filetype,
			restore_path
		),
		vim.log.levels.INFO,
		{ title = "Restore", icon = icons.emoji.restore, timeout = 5000 }
	)
end

return Trash_cli
