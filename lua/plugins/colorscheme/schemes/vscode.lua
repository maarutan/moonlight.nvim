return {
	"Mofiqul/vscode.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		-- Alternatively set style in setup
		-- style = 'light'

		-- Enable transparent background
		transparent = false,

		-- Enable italic comment
		italic_comments = true,

		-- Enable italic inlay type hints
		italic_inlayhints = true,

		-- Underline `@markup.link.*` variants
		underline_links = true,

		-- Disable nvim-tree background color
		disable_nvimtree_bg = true,

		-- Apply theme colors to terminal
		terminal_colors = true,

		-- Override colors (see ./lua/vscode/colors.lua)
		color_overrides = {
			vscLineNumber = "#FFFFFF",
		},
	},
}
