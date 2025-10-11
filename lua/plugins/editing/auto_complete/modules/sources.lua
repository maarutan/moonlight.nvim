local r = require

local which = r("utils.which")
if not which:is_module_exists("cmp") then return end

local cmp = r("cmp")
return cmp.config.sources({
	{
		function()
			local filetype = vim.fn.expand("%:e")
			if filetype == "html" then
				local name = "luasnip"
				return name
			end
			local name = ""
			return name
		end,
	},
	{ name = "nvim_lua" },
	{ name = "path" },
	{ name = "luasnip" },
	{ name = "calc" },
	{ name = "copilot" },
	{ name = "codeium" },
	{ name = "nvim_lsp" },
	{ name = "vim-dadbod-completion" },
	{ name = "buffer" },
})
