local icons = require("utils.icons")
-- Customize characters representing invisible characters in the text
local blacklist = {
	"snacks_dashboard",
	"snacks",
	"dashboard",
	"help",
	"neo-tree",
	"lazy",
	"terminal",
	"toggleterm",
	"term",
}

return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			indent = {
				char = icons.indent_line,
			},
			scope = {
				enabled = false,
			},
			exclude = {
				filetypes = blacklist,
			},
		},
	},
	{
		"nvim-mini/mini.indentscope",
		main = "mini.indentscope",
		opts = {
			draw = {
				delay = 300,
				animation = require("mini.indentscope").gen_animation.linear({
					easing = "in-out",
					duration = 25,
					unit = "step",
				}),

				priority = 2,
			},

			options = {
				border = "both",
				indent_at_cursor = true,
				try_as_border = false,
			},

			symbol = icons.vertical_space_bar,

			vim.api.nvim_create_autocmd("FileType", {
				pattern = blacklist,
				callback = function() vim.b.miniindentscope_disable = true end,
			}),
		},
	},
}
