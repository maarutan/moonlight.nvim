local options = require("core.options")

return {
	"uga-rosa/ccc.nvim",
	config = function()
		local ccc = require("ccc")

		ccc.setup({
			highlighter = {
				auto_enable = true,
			},
			pickers = {
				ccc.picker.ansi_escape(),
			},
			win_opts = {
				border = options.border,
			},
		})
	end,
}
