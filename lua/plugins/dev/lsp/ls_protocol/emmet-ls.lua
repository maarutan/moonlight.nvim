vim.lsp.config("emmet_ls", {
	filetypes = {
		"html",
		"css",
		"markdown",
		"javascriptreact",
		"typescriptreact",
		"vue",
		"blade.php",
		"htmldjango",
	},
	init_options = {
		emmet = {
			showExpandedAbbreviation = "always",
			showAbbreviationSuggestions = true,
			showSuggestionsAsSnippets = true,
		},
	},
})

vim.lsp.enable("emmet_ls")
