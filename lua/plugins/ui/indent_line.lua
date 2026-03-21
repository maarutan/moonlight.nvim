local const = require("utils.constants")

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
		opts = {
			indent = {
				char = const.icons.ui.listchars.indent_line,
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
		opts = function()
			local ok, indentscope = pcall(require, "mini.indentscope")
			if not ok then
				vim.notify("mini.indentscope not found!", vim.log.levels.WARN)
				return {}
			end

			return {
				draw = {
					delay = 300,
					animation = indentscope.gen_animation.linear({
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

				symbol = const.icons.ui.listchars.vertical_space_bar,

				vim.api.nvim_create_autocmd("FileType", {
					pattern = blacklist,
					callback = function()
						vim.b.miniindentscope_disable = true
					end,
				}),
			}
		end,
	},
}
