local icons = require("utils.constants.icons")
local which = require("utils.which")
local lsp = require("utils.lsp")

return {

	--- Diagnostics
	{
		"<leader>dw",
		"<cmd>Lspsaga show_workspace_diagnostics<CR>",
		desc = "Workspace Diagnostics",
		mode = { "n" },
		icon = { icon = icons.diagnostic.debug },
	},
	{
		"<leader>dc",
		"<cmd>Lspsaga show_line_diagnostics<CR>",
		desc = "Current Line Diagnostics",
		mode = { "n" },
		icon = { icon = icons.diagnostic.debug },
	},
	{
		"<leader>dl",
		"<cmd>Lspsaga diagnostic_jump_next<CR>",
		desc = "Next Diagnostic",
		mode = { "n" },
		icon = { icon = icons.diagnostic.debug },
	},
	{
		"<leader>dh",
		"<cmd>Lspsaga diagnostic_jump_prev<CR>",
		desc = "Prev Diagnostic",
		mode = { "n" },
		icon = { icon = icons.diagnostic.debug },
	},

	--- Lsp

	{
		"<leader>ld",
		"<cmd>Lspsaga goto_definition<CR>",
		desc = "Goto Definition",
		mode = { "n" },
		icon = { icon = icons.ui.lsp },
	},
	{
		"<leader>lD",
		"<cmd>Lspsaga goto_type_definition<CR>",
		desc = "Goto Type Definition",
		mode = { "n" },
		icon = { icon = icons.ui.lsp },
	},
	{
		"<leader>li",
		"<cmd>Lspsaga show_line_diagnostics<CR>",
		desc = "Line Diagnostics",
		mode = { "n" },
		icon = { icon = icons.ui.lsp },
	},
	{
		"<leader>lr",
		"<cmd>Lspsaga rename<CR>",
		desc = "Rename Symbol",
		mode = { "n" },
		icon = { icon = icons.ui.lsp },
	},
	{
		"<leader>lh",
		"<cmd>Lspsaga hover_doc<CR>",
		desc = "Hover Doc",
		mode = { "n" },
		icon = { icon = icons.ui.lsp },
	},
	{
		"<leader>lo",
		"<cmd>Lspsaga outline<CR>",
		desc = "Symbols Outline",
		mode = { "n" },
		icon = { icon = icons.ui.lsp },
	},
	{
		"<leader>la",
		"<cmd>Lspsaga code_action<CR>",
		desc = "Code Action",
		mode = { "n" },
		icon = { icon = icons.ui.lsp },
	},
}
