local const = require("utils.constants")
local options = {

	icons_enabled = true,
	theme = "auto",

	component_separators = {
		left = const.icons.ui.big_arrows.left,
		right = const.icons.ui.big_arrows.right,
	},
	section_separators = {
		left = const.icons.ui.solid_arrows.right,
		right = const.icons.ui.solid_arrows.left,
	},

	disabled_filetypes = {
		"snacks_dashboard",
		winbar = { "dashboard" },
		statusline = { "dashboard" },
	},

	ignore_focus = {
		"neo-tree",
		"dashboard",
		"snacks_dashboard",
	},

	always_divide_middle = true,
	always_show_tabline = true,
	globalstatus = true,

	refresh = {
		statusline = 200,
		tabline = 200,
		winbar = 200,
		refresh_time = 16,
		events = {
			"WinEnter",
			"BufEnter",
			"BufWritePost",
			"SessionLoadPost",
			"FileChangedShellPost",
			"VimResized",
			"Filetype",
			"CursorMoved",
			"CursorMovedI",
			"ModeChanged",
		},
	},
}

return options
