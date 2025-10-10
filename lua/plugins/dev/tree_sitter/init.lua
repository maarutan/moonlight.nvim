local r = require
local d = "plugins.dev.tree_sitter."

return {
	r(d .. "syntax_highlight"),
	r(d .. "context"),
}
