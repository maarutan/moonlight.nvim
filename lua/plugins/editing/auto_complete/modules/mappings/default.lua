local r = require
local which = r("utils.which")
if not which:is_module_has("cmp") then return end
local luasnip = require("luasnip")

local cmp = require("cmp")
local helper = r("plugins.editing.auto_complete.helper")

return {

	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			cmp.complete()
		elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		else
			fallback()
		end
	end, { "i", "s" }),

	["<S-Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
		elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end, { "i", "s" }),

	["<C-Space>"] = cmp.mapping(function()
		if cmp.visible() then
			cmp.close()
		else
			cmp.complete()
			cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
		end
	end, { "i", "c" }),
	["<C-e>"] = cmp.mapping.close(),

	["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
	["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

	["<C-d>"] = cmp.mapping(function() helper.scroll_down() end, { "i", "c" }),
	["<C-u>"] = cmp.mapping(function() helper.scroll_up() end, { "i", "c" }),

	["<C-A-u>"] = cmp.mapping.scroll_docs(-4),
	["<C-A-d>"] = cmp.mapping.scroll_docs(4),

	["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
	["<C-l>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
	["<C-Return>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
}
