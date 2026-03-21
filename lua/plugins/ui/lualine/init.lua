return {
	"nvim-lualine/lualine.nvim",
	version = "*",
	priority = 1,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = require("plugins.ui.lualine.options"),
		sections = {
			lualine_a = { require("plugins.ui.lualine.modules.mode") },
			lualine_b = {
				"branch",
				"diff",
				require("plugins.ui.lualine.modules.repositories"),
				{
					function()
						return require("NeoComposer.ui").status_recording()
					end,
				},
			},
			lualine_c = {
				{ "lsp_status", color = { gui = "bold", fg = "#ffffff" } },
				-- require("NeoComposer").status_recording,
				"filename",
				require("plugins.ui.lualine.modules.dodbod_preivew"),
				"diagnostics",
			},
			lualine_x = {
				"encoding",
				"fileformat",
				require("plugins.ui.lualine.modules.last_color"),
				"filetype",
				require("plugins.ui.lualine.modules.windsurf"),
			},
			lualine_y = { require("plugins.ui.lualine.modules.command"), "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	},
}
