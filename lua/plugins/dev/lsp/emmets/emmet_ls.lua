local lsp = require("utils.lsp")

lsp.setup_if_executable({
	name = "emmet_ls",
	executable = "emmet-ls",
	config = {
		filetypes = {
			"html",
			"css",
			"scss",
			"sass",
			"less",
			"javascriptreact",
			"typescriptreact",
			"pug",
			"templ",
			"markdown",
		},
		init_options = {
			includeLanguages = {},
			excludeLanguages = {},
			extensionsPath = {},
			preferences = {},
			showAbbreviationSuggestions = true,
			showExpandedAbbreviation = "always",
			showSuggestionsAsSnippets = true,
			syntaxProfiles = {},
			variables = {},
		},
	},
})
