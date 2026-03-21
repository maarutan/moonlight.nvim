local const = require("utils.constants")
local options = require("core.options")

return {
	winbar_prefix = "    ",
	border = options.border,
	devicon = true,
	foldericon = true,
	title = true,
	expand = const.icons.ui.expand,
	collapse = const.icons.ui.collapse,
	code_action = const.icons.emoji.light_bulb,
	kind = nil,
	use_nerd = true,
}
