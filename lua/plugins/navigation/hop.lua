return {
	"phaazon/hop.nvim",
	branch = "v2",
	version = "*",
	opts = {
		keys = "qwertyuiopasdfghjklzxcvbnm",
	},
	config = function(_, opts)
		local hop = require("hop")
		hop.setup(opts)
	end,
}
