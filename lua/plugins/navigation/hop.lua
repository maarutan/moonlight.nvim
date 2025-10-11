return {
	"smoka7/hop.nvim",
	version = "*",
	opts = {
		keys = "qwertyuiopasdfghjklzxcvbnm",
	},
	config = function(_, opts)
		local r = require
		local hop = r("hop")
		hop.setup(opts)
	end,
}
