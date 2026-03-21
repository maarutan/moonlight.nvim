return {

	-- ======================
	-- Navigation
	-- ======================

	["L"] = "set_root",
	["H"] = "navigate_up",
	["l"] = "smart_enter",
	["n"] = "toggle_hide_root_node",
	["<C-h>"] = "toggle_hidden",

	-- ======================
	-- File operations
	-- ======================

	["r"] = "rename",

	-- ======================
	-- Copy
	-- ======================

	["yy"] = "copy_to_clipboard",
	["yf"] = "copy_file_name",
	["yp"] = "copy_item_path",
	["yn"] = "copy_dir_name",
	["yw"] = "copy_item_name_without_ext",

	-- ======================
	-- Trash_cli
	-- ======================

	["d"] = "put_trash",
	["u"] = "restore_from_trash",

	-- ======================
	-- Visual select
	-- ======================

	["v"] = "visual_line",
	["V"] = "visual_line",
	["<C-v>"] = "visual_line",

	-- ======================
	-- Disabled / None
	-- ======================

	["y"] = "none",
	["t"] = "none",
	["?"] = "show_help",
}
