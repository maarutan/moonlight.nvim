return {
	"declancm/cinnamon.nvim",
	version = "*", -- use latest release
	opts = {
		keymaps = {
			basic = false,
			extra = true,
		},
		-- Only scroll the window
		options = { mode = "window" },
	},
}
