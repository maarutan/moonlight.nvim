local lsp = require("utils.lsp")

lsp.setup_if_executable({
	name = "html",
	executable = "vscode-html-language-server",
	config = {
		filetypes = { "html", "htm", "xhtml", "templ" },
		root_markers = { "package.json", ".git" },
		init_options = {
			provideFormatter = true,
			embeddedLanguages = {
				css = true,
				javascript = true,
			},
			configurationSection = { "html", "css", "javascript" },
		},
	},
})
