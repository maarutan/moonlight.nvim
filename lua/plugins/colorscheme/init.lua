return {
	{
		"raddari/last-color.nvim",
		version = "*",
		config = function()
			local theme = require("last-color").recall() or "default"
			vim.cmd.colorscheme(theme)
		end,
	},

	require("plugins.colorscheme.schemes.vscode"),
	require("plugins.colorscheme.schemes.rose_pine"),
	require("plugins.colorscheme.schemes.catppuccin"),
	require("plugins.colorscheme.schemes.gruvbox"),
	require("plugins.colorscheme.schemes.kanagawa"),
	require("plugins.colorscheme.schemes.tokyonight"),
	require("plugins.colorscheme.schemes.everforest"),
	require("plugins.colorscheme.schemes.dracula"),
	require("plugins.colorscheme.schemes.solarized_osaka"),
	require("plugins.colorscheme.schemes.cyberdream"),
}
