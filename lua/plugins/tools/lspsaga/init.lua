return {
	"nvimdev/lspsaga.nvim",

	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},

	config = function()
		require("lspsaga").setup({
			ui = require("plugins.tools.lspsaga.ui"),
			code_action = require("plugins.tools.lspsaga.code_action"),
			diagnostic = require("plugins.tools.lspsaga.diagnostic"),
			symbol_in_winbar = require("plugins.tools.lspsaga.symbol_in_winbar"),
		})

		vim.api.nvim_set_option("winhighlight", "WinBar:Normal,WinBarNC:NormalNC")
	end,
}
