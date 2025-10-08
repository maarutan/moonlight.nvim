local r = require
local d = "plugins.editing."

return {
	r(d .. "bufdelete"),
	r(d .. "auto_complete"),
	r(d .. "nocut"),
	r(d .. "autopairs"),
	r(d .. "surround"),
	r(d .. "todo"),
	r(d .. "ufo"),
	r(d .. "suda"),
	r(d .. "comments"),
	r(d .. "gomove"),
	r(d .. "multicursor"),

	-- { r(d .. "") },
}
