return {
	{
		"kndndrj/nvim-dbee",
		dependencies = { "MunifTanjim/nui.nvim" },
		build = function() require("dbee").install() end,
		config = function()
			local dbee = require("dbee")

			dbee.setup({
				sources = {
					require("dbee.sources").FileSource:new(vim.fn.stdpath("data") .. "/dbee/connections.json"),
				},
			})
		end,
	},
}
