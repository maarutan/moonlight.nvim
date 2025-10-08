local r = require
local which = r("utils.which")
if not which:is_module_has("cmp") then return end

local cmp = require("cmp")
local mode = { "i", "c" }

return {
	mapping = {
		["<C-j>"] = cmp.mapping(function() cmp.select_next_item() end, mode),
		["<C-k>"] = cmp.mapping(function() cmp.select_prev_item() end, mode),

		["<Tab>"] = cmp.mapping(function() cmp.select_next_item() end, mode),
		["<S-Tab>"] = cmp.mapping(function() cmp.select_prev_item() end, mode),

		["<CR>"] = cmp.mapping.confirm({ select = true }, mode),
	},
	sources = {
		{ name = "path" },
		{ name = "buffer" },
	},
}
