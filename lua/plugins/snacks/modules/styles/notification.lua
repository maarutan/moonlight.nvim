local options = require("core.options")

return {
	border = options.border,
	zindex = 100,
	ft = "markdown",
	wo = {
		winblend = 5,
		wrap = false,
		conceallevel = 2,
		colorcolumn = "",
	},
	bo = { filetype = "snacks_notif" },
}
