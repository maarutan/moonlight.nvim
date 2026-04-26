local icons = require("utils.constants.icons")
local merge = require("utils.table").merge
local os = require("utils.operating_system")

return merge({
	{
		"<leader>ff",
		function()
			Snacks.picker.files()
		end,
		icon = { icon = icons.ui.find },
		desc = "Find File",
	},
	{
		"<leader>fw",
		function()
			Snacks.picker.grep_word()
		end,
		icon = { icon = icons.ui.find },
		desc = "Find Word Under Cursor",
	},
	{
		"<leader>fu",
		function()
			Snacks.picker.undo()
		end,
		icon = { icon = icons.ui.find },
		desc = "Find Undo",
	},
	{
		"<leader>fW",
		function()
			Snacks.picker.grep()
		end,
		icon = { icon = icons.ui.find },
		desc = "Find Word",
	},
	{
		"<leader>fb",
		function()
			Snacks.picker.buffers()
		end,
		icon = { icon = icons.ui.find },
		desc = "Find Buffer",
	},
	{
		"<leader>fh",
		function()
			Snacks.picker.help()
		end,
		icon = { icon = icons.ui.find },
		desc = "Find Help",
	},
	{
		"<leader>fH",
		function()
			Snacks.picker.health()
		end,
		icon = { icon = icons.ui.find },
		desc = "Find Health",
	},
	{
		"<leader>fr",
		function()
			Snacks.picker.recent()
		end,
		icon = { icon = icons.ui.find },
		desc = "Find Recent",
	},
	{
		"<leader>fR",
		function()
			Snacks.picker.recent({
				filter = { cwd = true },
				confirm = { "edit", "tcd" },
			})
		end,
		icon = { icon = icons.ui.find },
		desc = "Recent in CWD & cd",
	},
	{
		"<leader>fm",
		function()
			Snacks.picker.keymaps()
		end,
		icon = { icon = icons.ui.find },
		desc = "Find Mappings",
	},
	{
		"<leader>fc",
		function()
			Snacks.picker.colorschemes()
		end,
		desc = "Find Colorscheme",
		icon = { icon = icons.ui.drawing_pen },
	},

	-- Notifications
	{
		"<leader>nH",
		function()
			Snacks.notifier.hide()
		end,
		desc = "Hide Notifications",
		icon = { icon = icons.ui.notification },
	},
	{
		"<leader>nh",
		function()
			Snacks.notifier.show_history()
		end,
		desc = "Show Notification History",
		icon = { icon = icons.ui.notification },
	},
	{
		"<leader>nt",
		function()
			vim.notify(
				"This is a test " .. os.user .. " !!!",
				vim.log.levels.WARN,
				{ title = "Demo", icon = icons.emoji.warn }
			)
		end,
		icon = { icon = icons.ui.notification },
		desc = "Test Notification",
	},

	-- Git

	{
		"<leader>gs",
		function()
			Snacks.picker.git_status()
		end,
		desc = "Git Status",
		icon = { icon = icons.git.git },
	},
	{
		"<leader>gd",
		function()
			Snacks.picker.git_diff()
		end,
		desc = "Git diff",
		icon = { icon = icons.git.git },
	},
	{
		"<leader>gb",
		function()
			Snacks.picker.git_branches()
		end,
		desc = "Git Commit",
		icon = { icon = icons.git.git },
	},

	-- Dashboard

	{
		"<leader>D",
		function()
			Snacks.dashboard.open()
		end,
		desc = "Dashboard",
		icon = { icon = icons.dashboard },
	},
})
