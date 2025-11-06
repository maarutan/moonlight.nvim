local M = {}

local r = require
local json = r("utils.json")
local config = r("plugins.tools.kitty_term.config")

local kitty_conf_local = vim.fn.expand(config.setup.kitty_path_local)
local kitty_conf_orig = vim.fn.expand(config.setup.kitty_path)
local json_path = vim.fn.stdpath("config") .. "/" .. config.setup.config_path

local function ensure_parent_dir(path)
	local dir = vim.fn.fnamemodify(path, ":h")
	if dir ~= "" then vim.fn.mkdir(dir, "p") end
end

local function read_file(path)
	local f = io.open(path, "r")
	if not f then return "" end
	local c = f:read("*a")
	f:close()
	return c or ""
end

local function write_file(path, content)
	ensure_parent_dir(path)
	local f = io.open(path, "w")
	if not f then return false end
	f:write(content or "")
	f:close()
	return true
end

local function lua_pat_escape(s) return (s:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")) end

function M.add_include_to_original()
	ensure_parent_dir(kitty_conf_local)
	if read_file(kitty_conf_local) == "" then write_file(kitty_conf_local, "") end
	local inc = kitty_conf_local
	local include_line = "include " .. inc
	local content = read_file(kitty_conf_orig)
	local escaped = lua_pat_escape(include_line)
	if content:match(escaped) then return end
	if content ~= "" and not content:match("\n$") then content = content .. "\n" end
	content = content .. "# added by kitty_term (nvim)\n" .. include_line .. "\n"
	write_file(kitty_conf_orig, content)
end

function M.remove_include_from_original()
	local inc = kitty_conf_local
	local content = read_file(kitty_conf_orig)
	local pattern_header = "[^\n]*#%s*added by kitty_term %(nvim%)%s*\n?"
	local pattern_include = "[^\n]*include%s+" .. lua_pat_escape(inc) .. "%s*\n?"
	content = content:gsub(pattern_header, "")
	content = content:gsub(pattern_include, "")
	write_file(kitty_conf_orig, content)
end

local function write_kitty_font_local(font)
	local content = read_file(kitty_conf_local)
	if content:match("font_family%s+") then
		content = content:gsub("font_family%s+.-\n", "font_family " .. font .. "\n")
	else
		if content ~= "" and not content:match("\n$") then content = content .. "\n" end
		content = content .. "font_family " .. font .. "\n"
	end
	write_file(kitty_conf_local, content)
end

local function write_kitty_size_local(size)
	local content = read_file(kitty_conf_local)
	if content:match("font_size%s+") then
		content = content:gsub("font_size%s+.-\n", "font_size " .. size .. "\n")
	else
		if content ~= "" and not content:match("\n$") then content = content .. "\n" end
		content = content .. "font_size " .. size .. "\n"
	end
	write_file(kitty_conf_local, content)
end

function M.reload_kitty()
	local h = io.popen("pidof kitty")
	if not h then return end
	local pid = h:read("*l")
	h:close()
	if pid and pid ~= "" then os.execute("kill -USR1 " .. pid) end
end

function M.set_font(font)
	json.update(json_path, { font = font }, 2)
	write_kitty_font_local(font)
	M.reload_kitty()
end

function M.set_size(size, skip_json)
	if not skip_json then json.update(json_path, { size = size }, 2) end
	write_kitty_size_local(size)
	vim.fn.system("kitty @ set-font-size " .. size)
end

function M.get_size()
	local data = json.load(json_path) or {}
	return tonumber(data.size) or 14
end

function M.increase_font_size()
	local new_size = M.get_size() + 1
	if new_size > 60 then new_size = 60 end
	M.set_size(new_size)
	print("Kitty font size: " .. new_size)
end

function M.decrease_font_size()
	local new_size = M.get_size() - 1
	if new_size < 6 then new_size = 6 end
	M.set_size(new_size)
	print("Kitty font size: " .. new_size)
end

function M.disable_hotkeys()
	local content = read_file(kitty_conf_local)
	if not content:find("map ctrl%+shift%+equal no_op") then
		if content ~= "" and not content:match("\n$") then content = content .. "\n" end
		content = content
			.. [[
# disabled by kitty_term
map ctrl+shift+equal no_op
map ctrl+shift+plus  no_op
map ctrl+shift+minus no_op
map ctrl+shift+kp_add no_op
map ctrl+shift+kp_subtract no_op
]]
		write_file(kitty_conf_local, content)
	end
	M.reload_kitty()
end

function M.enable_hotkeys()
	local content = read_file(kitty_conf_local)
	if content == "" then return end
	content = content
		:gsub("# disabled by kitty_term[^\n]*\n", "")
		:gsub("map ctrl%+shift%+equal no_op", "map ctrl+shift+equal increase_font_size")
		:gsub("map ctrl%+shift%+plus  no_op", "map ctrl+shift+plus  increase_font_size")
		:gsub("map ctrl%+shift%+minus no_op", "map ctrl+shift+minus decrease_font_size")
		:gsub("map ctrl%+shift%+kp_add no_op", "map ctrl+shift%+kp_add increase_font_size")
		:gsub("map ctrl%+shift%+kp_subtract no_op", "map ctrl+shift%+kp_subtract decrease_font_size")
	write_file(kitty_conf_local, content)
	M.reload_kitty()
end

function M.restore_original_font()
	M.remove_include_from_original()
	M.reload_kitty()
end

function M.autostart()
	M.add_include_to_original()
	local data = json.load(json_path) or {}
	if data.font and data.font ~= "" then write_kitty_font_local(data.font) end
	if data.size and tostring(data.size) ~= "" and tonumber(data.size) ~= nil then M.set_size(data.size, true) end
	M.disable_hotkeys()
	M.reload_kitty()
	vim.fn.system("kitty @ set-spacing padding=0")
	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = function()
			vim.fn.system("kitty @ set-spacing padding=default")
			M.remove_include_from_original()
			M.reload_kitty()
		end,
	})
end

function M.list_fonts_unique()
	local seen, fonts = {}, {}
	local h = io.popen("fc-list : family")
	if not h then return fonts end
	for line in h:lines() do
		for font in line:gmatch("[^,]+") do
			font = font:gsub("^%s+", ""):gsub("%s+$", "")
			if font ~= "" and not seen[font] then
				seen[font] = true
				table.insert(fonts, font)
			end
		end
	end
	h:close()
	table.sort(fonts)
	return fonts
end

return M
