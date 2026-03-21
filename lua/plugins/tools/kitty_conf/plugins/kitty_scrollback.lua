return {
	{
		"mikesmithgh/kitty-scrollback.nvim",
		lazy = false,
		cmd = {
			"KittyScrollbackGenerateKittens",
			"KittyScrollbackCheckHealth",
			"KittyScrollbackGenerateCommandLineEditing",
		},
		event = { "User KittyScrollbackLaunch" },
		config = function()
			require("kitty-scrollback").setup({ footer = true })
		end,
	},

	-- bufferline
	{
		"akinsho/bufferline.nvim",
		lazy = false,
		enabled = function()
			return vim.env.KITTY_SCROLLBACK_NVIM ~= "true"
		end,
	},

	-- lualine
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		enabled = function()
			return vim.env.KITTY_SCROLLBACK_NVIM ~= "true"
		end,
	},
}
