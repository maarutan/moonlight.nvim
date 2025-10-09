local r = require
local icons = r("utils.icons")
local d = "plugins.snacks.modules.dashboard."
local user = r("utils.whoami")

return {
	width = 50,
	pane_gap = 2,
	align = "start",
	preset = {
		header = icons.header,
		keys = {
			{
				icon = icons.find,
				key = "f",
				desc = " _  󱦰 Find File",
				action = function()
					Snacks.picker.files()
				end,
			},
			{
				icon = icons.new_file,
				key = "n",
				desc = " _  󱦰 New File",
				action = function()
					vim.ui.input({ prompt = icons.new_file .. " File Name: " }, function(filename)
						if filename and filename ~= "" then
							vim.cmd("edit " .. filename)
							vim.cmd("write")
						end
					end)
				end,
			},
			{
				icon = icons.recent_file,
				key = "r",
				desc = " _  󱦰 Recent Files",
				action = function()
					Snacks.picker.recent({ filter = { cwd = true }, confirm = { "edit", "tcd" } })
				end,
			},
			{
				icon = icons.word,
				key = "g",
				desc = " _  󱦰 Find Word",
				action = function()
					Snacks.picker.grep()
				end,
			},
			{
				icon = icons.config,
				key = "c",
				desc = " _  󱦰 Config",
				action = function()
					Snacks.picker.files({ cwd = vim.fn.stdpath("config"), confirm = { "edit", "tcd" } })
				end,
			},
			{
				icon = icons.exit,
				key = "q",
				desc = " _  󱦰         Quit",
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
	formats = r(d .. "formats"),
	sections = {
		{ section = "header", align = "start" },
		{ section = "keys", padding = 2 },
		{ text = "Welcome back, `" .. user .. "` " .. icons.emoji.dream, align = "start", padding = 1 },
		{ section = "startup" },
		{ r(d .. "ascii_art") },
		{ r(d .. "author") },
	},
}
