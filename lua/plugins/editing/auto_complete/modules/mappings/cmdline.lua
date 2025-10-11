local r = require
local which = r("utils.which")
if not which:is_module_exists("cmp") then return end

local cmp = require("cmp")
local mode = { "c" }

return {
	mapping = vim.tbl_extend("force", cmp.mapping.preset.cmdline(), {

		["<C-j>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ select = true })
			else
				fallback()
			end
		end, mode),

		["<C-k>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ select = true })
			else
				fallback()
			end
		end, mode),

		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-l>"] = cmp.mapping.confirm({ select = true }),
	}),

	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "cmdline" },
	}),
}
