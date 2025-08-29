return {
	["L"] = "set_root",
	["H"] = "navigate_up",

	["."] = "abs_path",

	["D"] = "diff_files",
	["r"] = "rename",

	["<C-u>"] = "scrollup",
	["<C-d>"] = "scrolldown",

	["d"] = "trash",
	["u"] = "restore",

	["<C-h>"] = "toggle_hidden",

	["f"] = "fuzzy_finder",
	["P"] = {
		"toggle_preview",
		config = {
			use_float = true,
			use_image_nvim = true,
		},
	},

	["J"] = "cycle_next_buffer",
	["K"] = "cycle_prev_buffer",

	["l"] = "open",
}
