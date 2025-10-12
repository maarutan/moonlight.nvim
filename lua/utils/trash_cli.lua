local r = require
local which = r("utils.which")
local os = r("utils.os")
local icons = r("utils.icons")

local Trash_cli = {}
Trash_cli.__index = Trash_cli

function Trash_cli:new() return setmetatable({}, self) end

local requirements

if os.get() == os.linux then
	requirements = { "trash-put", "trash-restore" }
elseif os.get() == os.macos then
	requirements = { "trash" }
elseif os.get() == os.windows then
	requirements = { "" }
end

for _, cmd in ipairs(requirements) do
	if cmd ~= "" then
		if not which:is_exists(cmd) then vim.notify(icons.emoji.warn .. " " .. cmd .. " is not installed", vim.log.levels.ERROR, { title = "Utils" }) end
	end
end

function Trash_cli:is_directory(path)
	local stat = vim.loop.fs_stat(path)
	return stat and stat.type == "directory"
end

function Trash_cli:is_file(path)
	local stat = vim.loop.fs_stat(path)
	return stat and stat.type == "file"
end

function Trash_cli:put(path)
	if os.get() == os.linux then
		local result = vim.fn.system("trash-put " .. vim.fn.shellescape(path))
	elseif os.get() == os.macos then
		local result = vim.fn.system("trash " .. vim.fn.shellescape(path))
	elseif os.get() == os.windows then
		local result = os.windows.put_to_trash(vim.fn.shellescape(path))
	end
	return result
end

function Trash_cli:last_restorable_name()
	if os.get() == os.linux then
		local handle = io.popen("trash-restore < /dev/null")
		if not handle then return nil end
		local result = handle:read("*a")
		handle:close()

		local max_index, max_line = -1, nil
		for line in result:gmatch("[^\r\n]+") do
			local index = tonumber(line:match("^%s*(%d+)"))
			if index and index > max_index then
				max_index, max_line = index, line
			end
		end

		if not max_line then return nil end

		return max_line:match("([^/]+)$")
	elseif os.get() == os.macos then
		return nil
	elseif os.get() == os.windows then
		return nil
	end
end

function Trash_cli:restore()
	if os.get() == os.linux then
		local handle = io.popen("trash-restore < /dev/null")
		if not handle then return end
		local result = handle:read("*a")
		handle:close()

		local max_index, max_line = -1, nil
		for line in result:gmatch("[^\r\n]+") do
			local index = tonumber(line:match("^%s*(%d+)"))
			if index and index > max_index then
				max_index, max_line = index, line
			end
		end

		if not max_line then
			vim.notify("Trash is empty", vim.log.levels.WARN, { title = "Restore" })
			return
		end

		local path = max_line:match("(%S+)$")
		local filename = path:match("([^/]+)$")

		vim.fn.system("echo " .. max_index .. " | trash-restore")

		local filetype
		if self:is_directory(path) then
			filetype = "Directory " .. icons.emoji.dir
		elseif self:is_file(path) then
			filetype = "File " .. icons.emoji.file
		else
			filetype = "Unknown " .. icons.emoji.unknown
		end
	elseif os.get() == os.macos then
		return nil
	elseif os.get() == os.windows then
		return nil
	end

	vim.notify(
		string.format(icons.trash_cli.restore .. " Restored:\n• Name: %s\n• Type: %s\n• Path: %s", filename or "Unknown", filetype or "Unknown", path or "N/A"),
		vim.log.levels.WARN,
		{ title = "Restore", icon = icons.trash_cli.restore, timeout = 5000 }
	)
end

return Trash_cli
