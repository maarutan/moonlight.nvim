local icons = require("utils.constants.icons")

return {
	{
		"<leader>gl",
		"<cmd>GitGraph<cr>",
		desc = "GitGraph - toggle",
		icon = { icon = icons.git.git },
	},
}
