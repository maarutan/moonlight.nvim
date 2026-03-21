local fm = require("utils.file_manager")
local config = require("plugins.tools.kitty_conf.config")
local json = require("utils.json")

local M = {}

local augroup = vim.api.nvim_create_augroup("KittyTermRuntime", { clear = true })

local function _write_runtime_option(key, value)
	local content = fm.read_file(config.kitty_runtime_file) or ""
	local line = key .. " " .. tostring(value)

	if content:match(key .. "%s+") then
		content = content:gsub(key .. "%s+[^\n]*", line)
	else
		if content ~= "" and not content:match("\n$") then
			content = content .. "\n"
		end
		content = content .. line .. "\n"
	end

	fm.write_file(config.kitty_runtime_file, content)
end

local function _write_kitty_size_local(size)
	_write_runtime_option("font_size", size)
end

local function _write_kitty_font_local(font)
	_write_runtime_option("font_family", font)
end

local function _get_size()
	local default = config.default_font_size
	return tonumber(json.get(config.kitty_json_base, "size", default)) or default
end

local function _remove_include_from_original()
	local inc = config.kitty_runtime_file
	local content = fm.read_file(config.kitty_config) or ""

	local pattern_header = "[^\n]*#%s*added by kitty_term %(nvim%)%s*\n?"
	local pattern_include = "[^\n]*include%s+" .. fm.lua_pat_escape(inc) .. "%s*\n?"

	content = content:gsub(pattern_header, "")
	content = content:gsub(pattern_include, "")

	fm.write_file(config.kitty_config, content)
end

local function _add_include_to_original()
	fm.ensure_parent_dir(config.kitty_runtime_file)

	if (fm.read_file(config.kitty_runtime_file) or "") == "" then
		fm.write_file(config.kitty_runtime_file, "")
	end

	local inc = config.kitty_runtime_file
	local include_line = "include " .. inc
	local content = fm.read_file(config.kitty_config) or ""
	local escaped = fm.lua_pat_escape(include_line)

	if content:match(escaped) then
		return
	end

	if content ~= "" and not content:match("\n$") then
		content = content .. "\n"
	end

	content = content .. "# added by kitty_term (nvim)\n" .. include_line .. "\n"
	fm.write_file(config.kitty_config, content)
end

function M.set_size(size, skip_json)
	size = tonumber(size)
	if not size then
		return
	end

	size = math.max(config.min_font_size, math.min(config.max_font_size, size))

	if not skip_json then
		json.update(config.kitty_json_base, { size = size })
	end

	_write_kitty_size_local(size)

	local result = vim.fn.system({ "kitty", "@", "set-font-size", tostring(size) })
	if vim.v.shell_error ~= 0 then
		vim.notify("Failed to set kitty font size: " .. result, vim.log.levels.ERROR)
	end
end

function M.set_font(font)
	if not font or font == "" then
		return
	end

	json.update(config.kitty_json_base, { font = font })
	_write_kitty_font_local(font)
	M.reload_kitty()
end

function M.increase_font_size()
	local new_size = _get_size() + 1
	if new_size > config.max_font_size then
		new_size = config.max_font_size
	end

	M.set_size(new_size)
end

function M.decrease_font_size()
	local new_size = _get_size() - 1
	if new_size < config.min_font_size then
		new_size = config.min_font_size
	end

	M.set_size(new_size)
end

function M.restore_config()
	_remove_include_from_original()
	M.reload_kitty()
end

function M.kitty_config_startup()
	_add_include_to_original()

	local data = json.load_file(config.kitty_json_base) or {}

	if data.size ~= nil then
		M.set_size(data.size, true)
	end

	if data.font and data.font ~= "" then
		_write_kitty_font_local(data.font)
	end

	M.reload_kitty()

	local spacing_result = vim.fn.system({ "kitty", "@", "set-spacing", "padding=0" })
	if vim.v.shell_error ~= 0 then
		vim.notify("Failed to set kitty padding: " .. spacing_result, vim.log.levels.WARN)
	end

	vim.api.nvim_create_autocmd("VimLeavePre", {
		group = augroup,
		callback = function()
			vim.fn.system({ "kitty", "@", "set-spacing", "padding=default" })
			_remove_include_from_original()
			M.reload_kitty()
		end,
	})
end

function M.get_state()
	local data = json.load_file(config.kitty_json_base) or {}

	return {
		font = data.font or "---",
		size = tonumber(data.size) or config.default_font_size,
		current_font = data.font or "---",
	}
end

function M.reload_kitty()
	local result = vim.fn.systemlist({ "pidof", "kitty" })
	if vim.v.shell_error ~= 0 or not result[1] or result[1] == "" then
		return
	end

	for pid in result[1]:gmatch("%S+") do
		vim.fn.system({ "kill", "-USR1", pid })
	end
end

function M.preview_font(font)
	if not font or font == "" then
		return
	end

	_write_kitty_font_local(font)
	M.reload_kitty()
end

return M
