local options = require("core.options")
local icons = require("utils.constants.icons")

return {
	{
		"mason-org/mason.nvim",
		event = "VeryLazy",
		version = "*",
		opts = {
			ui = {
				width = 120,
				height = 28,
				border = options.border,
				icons = {
					package_installed = icons.ui.complete.installed .. " ",
					package_pending = icons.ui.complete.pending .. " ",
					package_uninstalled = icons.ui.complete.uninstalled .. " ",
				},
			},
			registries = {
				"github:mason-org/mason-registry",
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		version = "*",
		opts = function()
			return {
				ensure_installed = require("plugins.dev.mason.tools_register"),
				auto_update = true,
				run_on_start = true,
			}
		end,
		config = function(_, opts)
			require("mason-tool-installer").setup(opts)
			require("plugins.dev.mason.tools_handler").setup()
		end,
	},
}
