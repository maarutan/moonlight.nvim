local icons = require("utils.constants.icons")

local Trash_cli = {}
Trash_cli.__index = Trash_cli

local uv = vim.loop
local fn = vim.fn
local json = vim.json

local trash_dir = fn.expand("~/.Trash")
local state_file = fn.stdpath("data") .. "/trash_cli_macos.json"

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
		return nil, "Failed to open state file for writing: " .. state_file
	end

	file:write(json.encode(data))
	file:close()

	return true
end

function Trash_cli:_basename(path)
	return path:match("([^/]+)$")
end

function Trash_cli:_dirname(path)
	return path:match("(.+)/[^/]+$")
end

function Trash_cli:_ensure_dir(path)
	if fn.isdirectory(path) == 1 then
		return true
	end

	fn.mkdir(path, "p")
	return fn.isdirectory(path) == 1
end

function Trash_cli:_unique_trash_path(path)
	local name = self:_basename(path)
	local target = trash_dir .. "/" .. name

	if uv.fs_stat(target) == nil then
		return target
	end

	local stem, ext = name:match("^(.*)%.([^%.]+)$")
	if not stem then
		stem = name
		ext = nil
	end

	local i = 1
	while true do
		local candidate
		if ext then
			candidate = string.format("%s/%s_%d.%s", trash_dir, stem, i, ext)
		else
			candidate = string.format("%s/%s_%d", trash_dir, stem, i)
		end

		if uv.fs_stat(candidate) == nil then
			return candidate
		end

		i = i + 1
	end
end

function Trash_cli:_move(src, dst)
	local ok, err = os.rename(src, dst)
	if ok then
		return true
	end
	return nil, err
end

function Trash_cli:put(path)
	path = fn.fnamemodify(path, ":p")

	if uv.fs_stat(path) == nil then
		return nil, "Path does not exist: " .. path
	end

	if fn.isdirectory(trash_dir) ~= 1 then
		return nil, "Trash directory not found: " .. trash_dir
	end

	local trash_path = self:_unique_trash_path(path)
	local ok, err = self:_move(path, trash_path)
	if not ok then
		return nil, err
	end

	local state = self:_read_state()
	table.insert(state, {
		original_path = path,
		trash_path = trash_path,
		filename = self:_basename(path),
		timestamp = os.time(),
	})

	local written, write_err = self:_write_state(state)
	if not written then
		return nil, write_err
	end

	return trash_path
end

function Trash_cli:_get_last_restorable()
	local state = self:_read_state()

	if #state == 0 then
		return nil, nil
	end

	local entry = state[#state]
	return #state, entry
end

function Trash_cli:last_restorable_name()
	local _, entry = self:_get_last_restorable()
	if not entry then
		return nil
	end

	return entry.filename or self:_basename(entry.original_path or "")
end

function Trash_cli:restore()
	local index, entry = self:_get_last_restorable()
	if not entry then
		vim.notify("Trash is empty", vim.log.levels.WARN, { title = "Restore" })
		return
	end

	local trash_path = entry.trash_path
	local original_path = entry.original_path
	local filename = entry.filename or self:_basename(original_path or "") or "Unknown"

	if not trash_path or uv.fs_stat(trash_path) == nil then
		vim.notify(
			"Trashed item no longer exists:\n" .. tostring(trash_path),
			vim.log.levels.ERROR,
			{ title = "Restore" }
		)
		return
	end

	local dir = self:_dirname(original_path or "")
	if not dir or not self:_ensure_dir(dir) then
		vim.notify(
			"Failed to create restore directory:\n" .. tostring(dir),
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
				candidate = string.format("%s/%s_restored_%d.%s", dir, stem, i, ext)
			else
				candidate = string.format("%s/%s_restored_%d", dir, stem, i)
			end

			if uv.fs_stat(candidate) == nil then
				restore_path = candidate
				break
			end

			i = i + 1
		end
	end

	local ok, err = self:_move(trash_path, restore_path)
	if not ok then
		vim.notify("Failed to restore:\n" .. tostring(err), vim.log.levels.ERROR, { title = "Restore" })
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
