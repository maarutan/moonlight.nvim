return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local filenames = {
			"html",
			"css",
			"typescript",
			"lua",
			"python",
			"bash",
			"c_cpp",
			"json",
			"markdown",
			"sql",
			"hyprls",
			"emmet_ls",
			"nix",
			"rust",
			"django",
			"sass",
		}

		local r = require
		local d = "plugins.dev.lsp.modules."

		for _, i in ipairs(filenames) do
			r(d .. i)
		end
	end,
}
