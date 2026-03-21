local kitty_conf = require("plugins.tools.kitty_conf")
local icons = require("utils.constants.icons")

return {

	{
		"<leader>kf",
		kitty_conf.pick_font,
		desc = "Kitty Pick Font",
		icon = { icon = icons.ui.kitty },
	},
	{
		"<leader>kr",
		kitty_conf.reload,
		desc = "Kitty Reload Config",
		icon = { icon = icons.ui.kitty },
	},
	{
		"<leader>ks",
		kitty_conf.input_font_size,
		desc = "Kitty Set Font-Size",
		icon = { icon = icons.ui.kitty },
	},
	{
		"<leader>ki",
		kitty_conf.notify_status,
		desc = "Kitty Notify Status",
		icon = { icon = icons.ui.kitty },
	},
	{
		"<leader>ku",
		kitty_conf.increase_font_size,
		desc = "Kitty Increase Font-Size",
		icon = { icon = icons.ui.kitty },
	},
	{
		"<leader>kd",
		kitty_conf.decrease_font_size,
		desc = "Kitty Decrease Font-Size",
		icon = { icon = icons.ui.kitty },
	},
}
