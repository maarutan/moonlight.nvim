local r = require
local d = "plugins.dev."

return {
	r(d .. "mason"),
	r(d .. "snippets"),
	r(d .. "formatters"),
	r(d .. "lsp"),
	r(d .. "tree_sitter"),
	r(d .. "dadbod"),
}
