local icons = require("utils.constants.icons")
local merge = require("utils.table").merge

return merge({
	{
		"<leader>lR",
		"<cmd>LspRestart<CR>",
		desc = "Restart LSP",
		mode = { "n" },
		icon = { icon = icons.ui.lsp },
	},
	{
		"<leader>lI",
		"<cmd>LspInfo<CR>",
		desc = "LSP Info",
		mode = { "n" },
		icon = { icon = icons.ui.lsp },
	},
	{
		"<leader>lS",
		"<cmd>LspStop<CR>",
		desc = "Stop LSP",
		mode = { "n" },
		icon = { icon = icons.ui.lsp },
	},
	{
		"<leader>ls",
		"<cmd>LspStart<CR>",
		desc = "Start LSP",
		mode = { "n" },
		icon = { icon = icons.ui.lsp },
	},

	{
		"<leader>lm",
		"<cmd>Mason<CR>",
		desc = "Mason Open",
		mode = { "n" },
		icon = { icon = icons.ui.mason },
	},
})
