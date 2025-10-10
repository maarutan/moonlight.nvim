local r = require
local d = "plugins.tools."
local terminal = r("utils.terminal")
local kitty = r(d .. "kitty_term")

if terminal.is_kitty() then kitty.core.autostart() end

local plugins = {
	r(d .. "ts-autotag"),
	r(d .. "toggle_term"),
	r(d .. "lspsaga"),
	r(d .. "ccc"),
	r(d .. "trouble"),
	r(d .. "waka_time"),
	r(d .. "lazy_reload"),
}

if terminal.is_kitty() then table.insert(plugins, kitty.lazy) end
if not terminal.is_kitty() then table.insert(plugins, r(d .. "smear_cursor")) end

return plugins
