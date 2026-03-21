local icons = require("utils.constants.icons")
return {
	{
		"<leader>e",
		require("plugins.navigation.keymaps.functions.neo_tree.smart_toggle"),
		desc = "Neotree toggle",
		icon = { icon = icons.ui.neotree },
	},
	{
		"<leader>E",
		"<cmd>Neotree focus reveal<cr>",
		desc = "Reveal current buffer in Neotree",
		icon = { icon = icons.ui.neotree },
	},
}
