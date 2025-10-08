return {
	"uga-rosa/ccc.nvim",
	config = function()
		local r = require
		local ccc = r("ccc")
		local ui = r("utils.ui")

		ccc.setup({
			highlighter = {
				auto_enable = true,
			},
			pickers = {
				ccc.picker.ansi_escape(),
			},
			win_opts = {
				border = ui.border,
			},
		})
	end,
}
