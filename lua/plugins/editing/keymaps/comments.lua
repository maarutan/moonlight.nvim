local icons = require("utils.constants.icons")

return {
	{
		"<leader>cl",
		"<Plug>(comment_toggle_linewise_current)",
		desc = "Comment Line",
		mode = "n",
		icon = { icon = icons.ui.line },
	},
	{
		"<leader>cb",
		"<Plug>(comment_toggle_blockwise_current)",
		desc = "Comment Block",
		mode = "n",
		icon = { icon = icons.ui.block },
	},
	{
		"<leader>cl",
		"<Plug>(comment_toggle_linewise_visual)",
		desc = "Comment Line (Visual)",
		mode = "x",
		icon = { icon = icons.ui.line },
	},
	{
		"<leader>cb",
		"<Plug>(comment_toggle_blockwise_visual)",
		desc = "Comment Block (Visual)",
		mode = "x",
		icon = { icon = icons.ui.block },
	},
}
