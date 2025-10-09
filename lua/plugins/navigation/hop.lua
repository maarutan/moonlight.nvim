return {
	"smoka7/hop.nvim",
	version = "*",
	opts = {
		keys = "qwertyuiopasdfghjklzxcvbnm",
	},
	config = function(_, opts)
		local hop = require("hop")
		hop.setup(opts)
	end,
}
