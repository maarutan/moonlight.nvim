local which = require("utils.which")
local lsp = require("utils.lsp")
local tool = "html"

if not which:is_exists("vscode-html-language-server") then
	return
end

vim.lsp.config(tool, {
	capabilities = lsp.capabilities(),
	filetypes = { "html", "htm", "xhtml", "templ" },
	init_options = {
		provideFormatter = true,
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
		configurationSection = { "html", "css", "javascript" },
	},
})

vim.lsp.enable(tool)
