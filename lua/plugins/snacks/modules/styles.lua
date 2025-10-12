local ui = require("utils.ui")

return {
	notification = {
		border = ui.border,
		zindex = 100,
		ft = "markdown",
		wo = {
			winblend = 5,
			wrap = false,
			conceallevel = 2,
			colorcolumn = "",
		},
		bo = { filetype = "snacks_notif" },
	},

	notification_history = {
		border = ui.border,
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
	},

	image = {
		relative = "cursor",
		border = ui.border,
		focusable = false,
		backdrop = false,
		row = 1,
		col = 1,
		-- width/height are automatically set by the image size unless specified below
	},
	input = {
		backdrop = true,
		position = "float",
		border = ui.border,
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
	},
}
