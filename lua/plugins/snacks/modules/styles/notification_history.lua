local options = require("core.options")

return {
	border = options.border,
	zindex = 100,
	width = 0.9,
	height = 0.9,
	minimal = false,
	title = " Notification History ",
	title_pos = "center",
	ft = "markdown",
	bo = { filetype = "snacks_notif_history", modifiable = false },
	wo = { winhighlight = "Normal:SnacksNotifierHistory" },
	keys = { q = "close" },
}
