local options = require("core.options")
return {
	relative = "cursor",
	border = options.border,
	focusable = false,
	backdrop = false,
	row = 1,
	col = 1,
	-- width/height are automatically set by the image size unless specified below
}
