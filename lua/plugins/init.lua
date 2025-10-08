local d = "plugins."
local r = require

return {
	{ r(d .. "editing") },
	{ r(d .. "navigation") },
	{ r(d .. "ui") },
	{ r(d .. "tools") },
	{ r(d .. "snacks") },
	{ r(d .. "ai") },
	{ r(d .. "dev") },

	-- always end load  |  only for plugins
	{ r(d .. "which_key") },
}
