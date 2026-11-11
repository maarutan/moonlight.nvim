return {
	"ajbucci/ipynb.nvim",

	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"neovim/nvim-lspconfig",
		"nvim-tree/nvim-web-devicons",
		"folke/snacks.nvim",

		{
			"MeanderingProgrammer/render-markdown.nvim",
			ft = { "markdown", "ipynb" },
			opts = {
				overrides = {
					filetype = {
						ipynb = {
							anti_conceal = {
								enabled = false,
							},
						},
					},
				},
			},
		},
	},

	opts = {
		kernel = {
			auto_connect = true,
			python_path = "/usr/bin/python3",
			show_status = true,
		},

		shadow = {
			location = "workspace",
		},
	},
}
