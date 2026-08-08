local lsp = require("utils.lsp")

lsp.setup_if_executable({
	name = "marksman",
	executable = "marksman",
	config = {
		filetypes = { "markdown", "markdown.mdx", "md" },
		root_markers = { ".marksman.toml", ".git" },
		settings = {
			marksman = {},
		},
	},
})
