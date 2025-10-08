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
		r("no-cut").setup(opts)

		vim.keymap.set({"n", "v"}, "x", "d", { noremap = true, silent = true })
		vim.keymap.set({"n", "v"}, "xx", "dd", { noremap = true, silent = true })
		vim.keymap.set({"n", "v"}, "X", "D", { noremap = true, silent = true })

	end,
}
