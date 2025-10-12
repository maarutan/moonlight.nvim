return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
		"famiu/bufdelete.nvim",
	},
	lazy = false,
	config = function()
		local r = require
		local ui = r("utils.ui")
		local nt = r("neo-tree")
		local d = "plugins.navigation.neo_tree."
		local m = d .. "modules."

		nt.setup({
			hide_root_node = true,
			retain_hidden_root_indent = true,
			popup_border_style = ui.border,

			filesystem = {
				filtered_items = {
					show_hidden_count = false,
					hide_by_name = r(d .. "hide_file"),
				},
			},

			commands = r(m .. "commands"),

			window = {
				position = "left",
				width = 30,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = r(m .. "mappings"),
			},

			source_selector = {
				winbar = false, -- toggle to show selector on winbar
			},

			event_handlers = r(m .. "events"),

			default_component_configs = {
				icon = r(m .. "icons_handler"),
				indent = r(m .. "indent"),
				git_status = {
					symbols = r(m .. "git_symbols"),
				},
			},
		})
	end,
}
