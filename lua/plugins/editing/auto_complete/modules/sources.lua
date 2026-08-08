local which = require("utils.which")

if not which:is_module_exists("cmp") then
	return
end

local cmp = require("cmp")
return cmp.config.sources({
	{ name = "nvim_lsp" },
	{ name = "nvim_lua" },
	{ name = "luasnip" },
	{ name = "path" },
	{ name = "calc" },
	{ name = "copilot" },
	{ name = "codeium" },
	{ name = "vim-dadbod-completion" },
	{ name = "buffer" },
})
