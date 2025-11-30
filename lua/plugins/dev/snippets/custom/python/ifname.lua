local r = require
local which = r("utils.which")
if not which:is_module_exists("luasnip") then return end

local luasnip = r("luasnip")

luasnip.add_snippets("python", {
	luasnip.snippet("ifname", {
		luasnip.text_node('if __name__ == "__main__":'),
		luasnip.text_node({ "", "\t" }),
		luasnip.insert_node(1),
	}),
})
