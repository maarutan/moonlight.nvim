local const = require("utils.constants")

return {
	enabled = true,
	"maarutan/macro-notify.nvim",
	opts = {
		message_start = "macro: ",
		message_end = "ended: ",
		icon_start = const.icons.emoji.rocket,
		icon_end = const.icons.emoji.skull,
	},
}
