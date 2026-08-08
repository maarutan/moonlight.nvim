local lsp = require("utils.lsp")

lsp.setup_if_executable({
	name = "jsonls",
	executable = "vscode-json-language-server",
	config = {
		filetypes = { "json", "jsonc" },
		init_options = {
			provideFormatter = true,
		},
		root_markers = { ".git" },
		settings = {
			json = {
				validate = { enable = true },
				format = { enable = true },
			},
		},
	},
})
