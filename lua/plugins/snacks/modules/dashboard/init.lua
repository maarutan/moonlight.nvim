local const = require("utils.constants")
local os = require("utils.operating_system")
local space = "                                                     "

return {
	width = 50,
	pane_gap = 2,
	align = "start",
	preset = {
		header = space .. "\n\n\n\n\n\n\n\n" .. const.nvim.header,
		keys = {
			{
				icon = const.icons.ui.find,
				key = "f",
				desc = " _  " .. const.icons.ui.arrows.right .. " Find File",
				action = function()
					Snacks.picker.files()
				end,
			},
			{
				icon = const.icons.ui.files.new,
				key = "n",
				desc = " _  " .. const.icons.ui.arrows.right .. " New File",
				action = function()
					vim.ui.input(
						{ prompt = const.icons.ui.files.new .. " File Name: " },
						function(filename)
							if filename and filename ~= "" then
								vim.cmd("edit " .. filename)
								vim.cmd("write")
							end
						end
					)
				end,
			},
			{
				icon = const.icons.ui.files.recent,
				key = "r",
				desc = " _  " .. const.icons.ui.arrows.right .. " Recent Files - cwd",
				action = function()
					Snacks.picker.recent({ filter = { cwd = true }, confirm = { "edit", "tcd" } })
				end,
			},
			{
				icon = const.icons.ui.files.word,
				key = "w",
				desc = " _  " .. const.icons.ui.arrows.right .. " Find Word",
				action = function()
					Snacks.picker.grep()
				end,
			},
			{
				icon = const.icons.web_icons.directories["config"],
				key = "c",
				desc = " _  " .. const.icons.ui.arrows.right .. " Config",
				action = function()
					Snacks.picker.files({
						cwd = vim.fn.stdpath("config"),
						confirm = { "edit", "tcd" },
					})
				end,
			},
			{
				icon = const.icons.ui.exit,
				key = "q",
				desc = " _  " .. const.icons.ui.arrows.right .. " Quit",
				action = function()
					vim.ui.input({ prompt = "Do you want to quit? [y/N] " }, function(input)
						if not input then
							return
						end
						input = input:lower()
						if input == "y" or input == "yes" then
							vim.cmd("qall!")
						end
					end)
				end,
			},
		},
	},
	formats = require("plugins.snacks.modules.dashboard.formats"),
	sections = {
		{ section = "header", align = "start" },
		{ section = "keys", padding = 2 },
		{
			text = "Welcome back, `" .. os.user .. "` " .. const.icons.emoji.dream,
			align = "start",
			padding = 1,
		},
		{ section = "startup" },
		{ require("plugins.snacks.modules.dashboard.ascii_art") },
		{ require("plugins.snacks.modules.dashboard.author") },
	},
}
