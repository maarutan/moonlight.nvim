local which = require("utils.which")
local lsp = require("utils.lsp")
local tool = "emmet_ls"

if not which:is_exists("emmet-ls") then
	return
end

vim.lsp.config(tool, {
	capabilities = lsp.capabilities(),
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
})

vim.lsp.enable(tool)
