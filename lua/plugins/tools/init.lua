local r = require
local d = "plugins.tools."
local terminal = r("utils.terminal")


if terminal.is_kitty() then
    r(d .. "kitty_term.core").autostart() -- init kitty_term
end

return {
	r(d .. "ts-autotag"),
	r(d .. "toggle_term"),
	r(d .. "lspsaga"),
	r(d .. "ccc"),
	r(d .. "trouble"),
	r(d .. "waka_time"),

	-- { r(d .. "") },
}
