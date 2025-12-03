local r = require
local ui = r("utils.ui")

return {
	"ecthelionvi/NeoComposer.nvim",
	dependencies = { "kkharji/sqlite.lua" },
	opts = {
		notify = true,
		delay_timer = 150,
		queue_most_recent = false,
		window = {
			width = 60,
			height = 10,
			border = ui.border,
			winhl = {
				Normal = "ComposerNormal",
			},
		},
		colors = {
			bg = "#16161e",
			fg = "#ff9e64",
			red = "#ec5f67",
			blue = "#5fb3b3",
			green = "#99c794",
		},
		keymaps = {
			play_macro = "Q",
			yank_macro = "yq",
			stop_macro = "cq",
			toggle_record = "q",
			cycle_next = "mn",
			cycle_prev = "mp",
			toggle_macro_menu = "<A-q>",
		},
	},
}
