local M = {}

local r = require
local json = r("utils.json")
local config = r("plugins.tools.kitty_term.config")

local kitty_conf = vim.fn.expand(config.setup.kitty_path)
local json_path = vim.fn.stdpath("config") .. "/" .. config.setup.config_path

local function read_kitty_font()
	local f = io.open(kitty_conf, "r")
	if not f then return { font = "", size = "" } end
	local content = f:read("*a")
	f:close()
	local font = content:match("font_family%s+([^\n]+)") or ""
	local size = content:match("font_size%s+([^\n]+)") or ""
	return { font = vim.trim(font), size = vim.trim(size) }
end

local function write_kitty_font(font)
	local f = io.open(kitty_conf, "r")
	local content = f and f:read("*a") or ""
	if f then f:close() end
	if content:match("font_family%s+") then
		content = content:gsub("font_family%s+.-\n", "font_family " .. font .. "\n")
	else
		content = content .. "\nfont_family " .. font .. "\n"
	end
	local out = io.open(kitty_conf, "w")
	if out then
		out:write(content)
		out:close()
	end
end

local function write_kitty_size(size)
	local f = io.open(kitty_conf, "r")
	local content = f and f:read("*a") or ""
	if f then f:close() end
	if content:match("font_size%s+") then
		content = content:gsub("font_size%s+.-\n", "font_size " .. size .. "\n")
	else
		content = content .. "\nfont_size " .. size .. "\n"
	end
	local out = io.open(kitty_conf, "w")
	if out then
		out:write(content)
		out:close()
	end
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
	write_kitty_font(font)
	M.reload_kitty()
end

function M.set_size(size, skip_json)
	if not skip_json then json.update(json_path, { size = size }, 2) end
	write_kitty_size(size)
	vim.fn.system("kitty @ set-font-size " .. size)
end

function M.get_size()
	local data = json.load(json_path) or {}
	return tonumber(data.size) or tonumber(data.default_size) or 14
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

function M.restore_original_font()
	local data = json.load(json_path) or {}
	if data.default_font and data.default_font ~= "" then
		write_kitty_font(data.default_font)
		M.reload_kitty()
	end
	if data.default_size and data.default_size ~= "" then M.set_size(data.default_size, true) end
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

function M.disable_hotkeys()
	local content = io.open(kitty_conf, "r"):read("*a")
	if not content:find("map ctrl%+shift%+equal no_op") then
		local f = io.open(kitty_conf, "a")
		f:write([[
# disabled by kitty_term
map ctrl+shift+equal no_op
map ctrl+shift+plus  no_op
map ctrl+shift+minus no_op
map ctrl+shift+kp_add no_op
map ctrl+shift+kp_subtract no_op
]])
		f:close()
	end
	M.reload_kitty()
end

function M.enable_hotkeys()
	local f = io.open(kitty_conf, "r")
	if not f then return end
	local content = f:read("*a")
	f:close()
	content = content
		:gsub("# disabled by kitty_term[^\n]*\n", "")
		:gsub("map ctrl%+shift%+equal no_op", "map ctrl+shift+equal increase_font_size")
		:gsub("map ctrl%+shift%+plus  no_op", "map ctrl+shift+plus  increase_font_size")
		:gsub("map ctrl%+shift%+minus no_op", "map ctrl+shift+minus decrease_font_size")
		:gsub("map ctrl%+shift%+kp_add no_op", "map ctrl+shift+kp_add increase_font_size")
		:gsub("map ctrl%+shift%+kp_subtract no_op", "map ctrl+shift+kp_subtract decrease_font_size")
	local out = io.open(kitty_conf, "w")
	out:write(content)
	out:close()
	M.reload_kitty()
end

function M.autostart()
	M.disable_hotkeys()
	local data = json.load(json_path) or {}
	if not data.default_font or data.default_font == "" then
		local current = read_kitty_font()
		data.default_font = current.font
		data.default_size = current.size
		json.save(json_path, data, 2)
	end
	if data.font and data.font ~= "" then write_kitty_font(data.font) end
	local size_ok = type(data.size) == "string" or type(data.size) == "number"
	if not size_ok or data.size == "" or tonumber(data.size) == nil then
		data.size = data.default_size or "14.0"
		json.update(json_path, { size = data.size }, 2)
	end
	M.set_size(data.size)
	M.reload_kitty()
	vim.fn.system("kitty @ set-spacing padding=0")
	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = function()
			M.restore_original_font()
			M.enable_hotkeys()
			vim.fn.system("kitty @ set-spacing padding=default")
		end,
	})
end

return M
