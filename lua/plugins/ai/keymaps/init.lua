local merge = require("utils.table").merge

return merge({
	{
		"<leader>co", -- Change this to your preferred keybinding
		function()
			require("codex").toggle()
		end,
		desc = "Toggle Codex popup or side-panel",
		mode = { "n", "t" },
	},
})
