local const = require("utils.constants")

return {
	enable = true,
	separator = " " .. const.icons.ui.big_arrows.right .. " ",
	hide_keyword = false,
	ignore_patterns = nil,
	show_file = true,
	folder_level = 1,
	color_mode = true,
	delay = 300,
	disable = { "neo-tree", "TelescopePrompt", "snacks_picker", "prompt" },
}
