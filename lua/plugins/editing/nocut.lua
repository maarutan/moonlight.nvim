return {
	"maarutan/nvim-nocut",
	version = "*",
	opts = {
		d = true,
		x = false,
		s = false,
		c = true,
		dd = true,
		D = true,
		C = true,
		S = false,
		visual_commands = {
			d = true,
			c = true,
		},
		exceptions = { "Y" },
		paste_without_copy = true,
	},
	config = function(_, opts)
		local r = require
		local map = vim.keymap.set
		r("no-cut").setup(opts)

		map({ "n", "v" }, "x", "d", { noremap = true, silent = true })
		map({ "n", "v" }, "xx", "dd", { noremap = true, silent = true })
		map({ "n", "v" }, "X", "D", { noremap = true, silent = true })
	end,
}
