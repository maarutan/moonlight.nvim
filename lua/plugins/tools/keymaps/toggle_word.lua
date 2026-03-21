local icons = require("utils.constants.icons")

return {
	{
		"<leader>wt",
		require("plugins.tools.toggle_word").toggle_word,
		desc = "Toggle Word",
		icon = { icon = icons.ui.files.word },
	},
}
