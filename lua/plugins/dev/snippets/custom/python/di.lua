local r = require
local which = r("utils.which")
if not which:is_module_exists("luasnip") then return end

local luasnip = r("luasnip")

luasnip.add_snippets("python", {
	luasnip.snippet("di", {
		luasnip.text_node("def __init__(self):"),
		luasnip.text_node({ "", "\t" }),
		luasnip.insert_node(1),
	}),
})
