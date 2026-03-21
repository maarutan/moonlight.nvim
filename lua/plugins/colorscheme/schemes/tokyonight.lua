return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "auto",
		light_style = "moon",
		transparent = false,
		terminal_colors = true,
		styles = {
			comments = { italic = true },
			keywords = { italic = true },
			functions = { bold = true },
			variables = {},
		},
		sidebars = { "qf", "help", "terminal", "packer" },
		dim_inactive = false,
		lualine_bold = true,
	},
}
