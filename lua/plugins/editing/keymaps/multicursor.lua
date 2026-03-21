local which = require("utils.which")
local icons = require("utils.constants.icons")

local mc = nil
if which:is_module_exists("multicursor-nvim") then
	mc = require("multicursor-nvim")
end

if not mc then
	return {}
end

return {
	{
		"<Esc>",
		function()
      vim.cmd("nohlsearch")

			if not mc.hasCursors() then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
				return
			end

			if not mc.cursorsEnabled() then
				mc.enableCursors()
			else
				mc.clearCursors()
			end
		end,
		desc = "Multicursor escape",
		mode = { "n", "x" },
		icon = { icon = icons.ui.multicursor },
	},

	{
		"<C-k>",
		function()
			mc.lineAddCursor(-1)
		end,
		desc = "Add cursor above",
		mode = { "n", "x" },
		icon = { icon = icons.ui.multicursor },
	},

	{
		"<C-j>",
		function()
			mc.lineAddCursor(1)
		end,
		desc = "Add cursor below",
		mode = { "n", "x" },
		icon = { icon = icons.ui.multicursor },
	},

	{
		"<C-n>",
		function()
			mc.matchAddCursor(1)
		end,
		desc = "Add cursor by match",
		mode = { "n", "x" },
		icon = { icon = icons.ui.multicursor },
	},

	{
		"<C-S-n>",
		function()
			mc.matchAddCursor(-1)
		end,
		desc = "Add cursor by match reverse",
		mode = { "n", "x" },
		icon = { icon = icons.ui.multicursor },
	},

	{
		"<A-n>",
		function()
			mc.matchSkipCursor(1)
		end,
		desc = "Skip cursor by match",
		mode = { "n", "x" },
		icon = { icon = icons.ui.multicursor },
	},

	{
		"<A-S-n>",
		function()
			mc.matchSkipCursor(-1)
		end,
		desc = "Skip cursor by match reverse",
		mode = { "n" },
		icon = { icon = icons.ui.multicursor },
	},

	{
		"<C-h>",
		function()
			mc.toggleCursor()
		end,
		desc = "Toggle cursor",
		mode = { "n" },
		icon = { icon = icons.ui.multicursor },
	},

	{
		"<leader>mS",
		function()
			mc.searchAllAddCursors()
		end,
		desc = "Add all matches from search",
		mode = "n",
		icon = { icon = icons.ui.multicursor },
	},
	{
		"<leader>ma",
		function()
			mc.matchAllAddCursors()
		end,
		desc = "Add all matches",
		mode = "n",
		icon = { icon = icons.ui.multicursor },
	},
	{
		"I",
		function()
			mc.insertVisual()
		end,
		mode = "x",
		icon = { icon = icons.ui.multicursor },
		desc = "Insert on multiple lines",
	},
	{
		"A",
		function()
			mc.appendVisual()
		end,
		mode = "x",
		icon = { icon = icons.ui.multicursor },
		desc = "Append on multiple lines",
	},
	{
		"<leader>mA",
		function()
			mc.alignCursors()
		end,
		desc = "Align cursors",
		mode = "n",
		icon = { icon = icons.ui.multicursor },
	},
	{
		"<leader>mh",
		function()
			mc.prevCursor()
		end,
		mode = { "n", "x" },
		desc = "Prev cursor",

		icon = { icon = icons.ui.multicursor },
	},
	{
		"<leader>ml",
		function()
			mc.nextCursor()
		end,
		mode = { "n", "x" },
		desc = "Next cursor",

		icon = { icon = icons.ui.multicursor },
	},
	{
		"<leader>mx",
		function()
			mc.deleteCursor()
		end,
		mode = { "n", "x" },
		desc = "Delete cursor",
		icon = { icon = icons.ui.multicursor },
	},
}
