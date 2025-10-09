return {
	{
		"mikesmithgh/kitty-scrollback.nvim",
		lazy = true,
		cmd = {
			"KittyScrollbackGenerateKittens",
			"KittyScrollbackCheckHealth",
			"KittyScrollbackGenerateCommandLineEditing",
		},
		event = { "User KittyScrollbackLaunch" },
		config = function() require("kitty-scrollback").setup() end,
	},

	-- bufferline
	{
		"akinsho/bufferline.nvim",
		enabled = function() return vim.env.KITTY_SCROLLBACK_NVIM ~= "true" end,
	},

	-- lualine
	{
		"nvim-lualine/lualine.nvim",
		enabled = function() return vim.env.KITTY_SCROLLBACK_NVIM ~= "true" end,
	},
}
