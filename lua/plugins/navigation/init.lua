local d = "plugins.navigation."
local r = require
return {
	-- file explorer
	{ r(d .. "neo_tree") },
	{ r(d .. "hop") },
}
