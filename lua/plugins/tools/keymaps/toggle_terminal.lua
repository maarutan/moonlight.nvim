local icons = require("utils.constants.icons")

return {
	{ "<C-t>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal", icon = { icon = icons.ui.mode.terminal } },
	{
		"<leader>tt",
		"<cmd>ToggleTerm direction=tab<cr>",
		desc = "Terminal New Tab",
		icon = { icon = icons.ui.mode.terminal },
	},
	{
		"<leader>tf",
		"<cmd>ToggleTerm direction=float<cr>",
		desc = "Terminal Float",
		icon = { icon = icons.ui.mode.terminal },
	},
	{
		"<leader>tv",
		"<cmd>ToggleTerm direction=vertical<cr>",
		desc = "Terminal Vertical",
		icon = { icon = icons.ui.mode.terminal },
	},
	{
		"<leader>th",
		"<cmd>ToggleTerm direction=horizontal<cr>",
		desc = "Terminal Horizontal",
		icon = { icon = icons.ui.mode.terminal },
	},
}
