local lsp = require("utils.lsp")

lsp.setup_if_executable({
	name = "cssls",
	executable = "vscode-css-language-server",
	config = {
		settings = {
			css = {
				validate = true,
				lint = {
					unknownAtRules = "ignore",
				},
			},
			scss = {
				validate = true,
			},
			less = {
				validate = true,
			},
		},
		filetypes = {
			"css",
			"scss",
			"sass",
			"less",
			"vue",
			"svelte",
		},
		init_options = {
			provideFormatter = true,
		},
		root_markers = { "package.json", ".git" },
	},
})
