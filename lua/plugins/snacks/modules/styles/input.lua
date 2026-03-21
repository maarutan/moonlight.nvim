local options = require("core.options")

return {
	backdrop = true,
	position = "float",
	border = options.border,
	title_pos = "center",
	height = 1,
	width = 50,
	relative = "editor",
	noautocmd = true,
	row = 2,
	-- relative = "cursor",
	row = 0.2,
	-- col = 2,
	wo = {
		winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
		cursorline = false,
	},
	bo = {
		filetype = "snacks_input",
		buftype = "prompt",
	},
	--- buffer local variables
	b = {
		completion = false, -- disable blink completions in input
	},
	keys = {
		n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n", expr = true },
		i_esc = { "<esc>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
		i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = { "i", "n" }, expr = true },
		i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i", expr = true },
		i_ctrl_w = { "<c-w>", "<c-s-w>", mode = "i", expr = true },
		i_up = { "<up>", { "hist_up" }, mode = { "i", "n" } },
		i_down = { "<down>", { "hist_down" }, mode = { "i", "n" } },
		q = "cancel",
	},
}
