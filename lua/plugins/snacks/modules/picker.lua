local border = require("core.options").border

local function smoothScroll(fn, delay, stop_int)
	local timer = vim.loop.new_timer()
	local counter = 0
	timer:start(
		0,
		delay,
		vim.schedule_wrap(function()
			counter = counter + 1
			fn(counter)
			if counter >= stop_int then
				timer:stop()
				timer:close()
			end
		end)
	)
end

return {
	focus = "input",
	ui_select = false,
	layout = {
		preset = "telescope",
		reverse = true,
		layout = {
			box = "horizontal",
			backdrop = true,
			width = 0.8,
			height = 0.9,
			border = border,
			{
				box = "vertical",
				{ win = "list", title = " Results ", title_pos = "center", border = border },
				{
					win = "input",
					height = 1,
					border = border,
					title = "{title} {live} {flags}",
					title_pos = "center",
				},
			},
			{
				win = "preview",
				title = "{preview:Preview}",
				width = 0.60,
				border = border,
				title_pos = "center",
			},
		},
	},

	win = {
		input = {
			keys = {
				["<C-d>"] = { "smooth_scroll_down", mode = { "n", "i" } },
				["<C-u>"] = { "smooth_scroll_up", mode = { "n", "i" } },
			},
		},
		list = {
			keys = {
				["<C-d>"] = { "smooth_scroll_down", mode = { "n", "i" } },
				["<C-u>"] = { "smooth_scroll_up", mode = { "n", "i" } },
			},
		},
	},
	actions = {
		smooth_scroll_down = function(picker)
			smoothScroll(function()
				Snacks.picker.actions.list_down(picker)
			end, 30, 4)
		end,

		smooth_scroll_up = function(picker)
			smoothScroll(function()
				Snacks.picker.actions.list_up(picker)
			end, 30, 4)
		end,
	},
}
