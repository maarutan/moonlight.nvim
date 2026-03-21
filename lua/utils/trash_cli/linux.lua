local which = require("utils.which")
local icons = require("utils.constants.icons")

local Trash_cli = {}
Trash_cli.__index = Trash_cli

function Trash_cli:new()
	return setmetatable({}, self)
end

function Trash_cli:is_directory(path)
	local stat = vim.loop.fs_stat(path)
	return stat and stat.type == "directory"
end

function Trash_cli:is_file(path)
	local stat = vim.loop.fs_stat(path)
	return stat and stat.type == "file"
end

function Trash_cli:_get_last_restorable()
	local handle = io.popen("trash-restore < /dev/null")
	if not handle then
		return nil, nil
	end

	local result = handle:read("*a")
	handle:close()

	local max_index, max_line = -1, nil
	for line in result:gmatch("[^\r\n]+") do
		local index = tonumber(line:match("^%s*(%d+)"))
		if index and index > max_index then
			max_index = index
			max_line = line
		end
	end

	if not max_line then
		return nil, nil
	end

	return max_index, max_line
end

function Trash_cli:put(path)
	local result = vim.fn.system("trash-put " .. vim.fn.shellescape(path))
	if vim.v.shell_error ~= 0 then
		return nil, result
	end
	return result
end

function Trash_cli:last_restorable_name()
	local _, max_line = self:_get_last_restorable()
	if not max_line then
		return nil
	end

	return max_line:match("([^/]+)$")
end

function Trash_cli:restore()
	local max_index, max_line = self:_get_last_restorable()
	if not max_line then
		vim.notify("Trash is empty", vim.log.levels.WARN, { title = "Restore" })
		return
	end

	local path = max_line:match("(%S+)$")
	local filename = path and path:match("([^/]+)$") or "Unknown"

	local result = vim.fn.system("echo " .. max_index .. " | trash-restore")
	if vim.v.shell_error ~= 0 then
		vim.notify("Failed to restore:\n" .. result, vim.log.levels.ERROR, { title = "Restore" })
		return
	end

	local filetype = "Unknown " .. icons.emoji.unknown
	if path and self:is_directory(path) then
		filetype = "Directory " .. icons.emoji.dir
	elseif path and self:is_file(path) then
		filetype = "File " .. icons.emoji.file
	end

	vim.notify(
		string.format(
			"%s Restored:\n• Name: %s\n• Type: %s\n• Path: %s",
			icons.emoji.restore,
			filename,
			filetype,
			path or "N/A"
		),
		vim.log.levels.INFO,
		{ title = "Restore", icon = icons.emoji.restore, timeout = 5000 }
	)
end

return Trash_cli
