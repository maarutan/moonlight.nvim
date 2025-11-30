local r = require
local U = r("plugins.dev.formatters.helper")

return {
	format = function()
		return U.make("xmlformat", nil, true, true, function()
			vim.cmd("silent noautocmd edit")
			vim.cmd("normal! zz")
		end)
	end,
}
