local options = require("core.options")
local merge = require("utils.table").merge


return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = { "echasnovski/mini.icons" },
	opts = {
		preset = "modern",
		win = { border = options.border },
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
    wk.add(merge(require("plugins.which_key.register")))
	end,
}
