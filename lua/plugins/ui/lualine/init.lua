local r = require

local d = "plugins.ui.lualine.core."
local m = "plugins.ui.lualine.modules."

return {
	"nvim-lualine/lualine.nvim",
	version = "*",
	priority = 1,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = r(d .. "options"),
		sections = {
			lualine_a = { r(m .. "mode") },
			lualine_b = {
				"branch",
				"diff",
				r(m .. "repositories"),
			},
			lualine_c = {
				{ "lsp_status", color = { gui = "bold", fg = "#ffffff" } },
				-- r("NeoComposer").status_recording,
				"filename",
				r(m .. "dodbod_preivew"),
				"diagnostics",
			},
			lualine_x = { "encoding", "fileformat", r(m .. "last_color"), "filetype", r(m .. "windsurf") },
			lualine_y = { r(m .. "command"), "progress" },
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
