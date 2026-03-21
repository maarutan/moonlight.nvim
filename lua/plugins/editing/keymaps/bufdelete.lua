local icons = require("utils.constants.icons")

return {
	{
		"<leader>bD",
		function()
			vim.ui.input({ prompt = "Delete Buffer - Force [ y/N ]: " }, function(input)
				if input == "y" or input == "Y" then
					vim.cmd("Bdelete")
				end
			end)
		end,
		desc = "Delete Buffer - [ Force ]",
		icon = { icon = icons.ui.buffer },
	},
	{ "<leader>bd", "<cmd>Bdelete<cr>", icon = { icon = icons.ui.buffer }, desc = "Delete Buffer" },
}
