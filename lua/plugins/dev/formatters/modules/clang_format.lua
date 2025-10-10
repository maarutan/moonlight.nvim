local r = require
local U = r("plugins.dev.formatters.helper")

local style = "'{BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 0}'"

return {
	format = function()
		return U.make("clang-format", {
			"--assume-filename",
			vim.api.nvim_buf_get_name(0),
			"-style=" .. style,
		}, false, true)
	end,
}
