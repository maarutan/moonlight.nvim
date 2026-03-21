local icons = require("utils.constants.icons")

return {
	{
		"<leader>w{",
		"<cmd>normal ysiw{<cr>",
		mode = "n",
		desc = "Surround with {",
		icon = { icon = icons.ui.files.word },
	},
	{
		"<leader>w[",
		"<cmd>normal ysiw[<cr>",
		mode = "n",
		desc = "Surround with [",
		icon = { icon = icons.ui.files.word },
	},
	{
		"<leader>w(",
		"<cmd>normal ysiw(<cr>",
		mode = "n",
		desc = "Surround with (",
		icon = { icon = icons.ui.files.word },
	},
	{
		'<leader>w"',
		'<cmd>normal ysiw"<cr>',
		mode = "n",
		desc = 'Surround with "',
		icon = { icon = icons.ui.files.word },
	},
	{
		"<leader>w'",
		"<cmd>normal ysiw'<cr>",
		mode = "n",
		desc = "Surround with '",
		icon = { icon = icons.ui.files.word },
	},
	{
		"<leader>wi",
		function()
			local keys = vim.keycode("ysiw")
			vim.api.nvim_feedkeys(keys, "m", false)
		end,
		mode = "n",
		desc = "Surround word (choose char)",
	},
}
