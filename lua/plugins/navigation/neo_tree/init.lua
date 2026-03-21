local options = require("core.options")

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	lazy = false,
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local neo_tree = require("neo-tree")

		local hidden_files = require("plugins.navigation.neo_tree.hidden_files")
		local commands = require("plugins.navigation.neo_tree.commands")
		local mappings = require("plugins.navigation.neo_tree.mappings")
		local events = require("plugins.navigation.neo_tree.events")
		local icons = require("plugins.navigation.neo_tree.icons_handler")
		local indents = require("plugins.navigation.neo_tree.indents")
		local git_symbols = require("plugins.navigation.neo_tree.git_symbols")

		neo_tree.setup({
			hide_root_node = true,
			retain_hidden_root_indent = true,
			popup_border_style = require("core.options").border,

			filesystem = {
				filtered_items = {
					show_hidden_count = false,
					hide_by_name = hidden_files,
				},
			},

			commands = commands,

			window = {
				position = "left",
				width = 30,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = mappings,
			},

			source_selector = {
				winbar = false,
			},

			event_handlers = events,

			default_component_configs = {
				icon = icons,
				indent = indents,
				git_status = {
					symbols = git_symbols,
				},
			},
		})
	end,
}
