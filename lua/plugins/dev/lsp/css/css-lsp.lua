local which = require("utils.which")
local lsp = require("utils.lsp")
local tool = "cssls"

if not which:is_exists("vscode-css-language-server") then
	return
end

vim.lsp.config(tool, {
	capabilities = lsp.capabilities(),
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
		"html",
		"javascriptreact",
		"typescriptreact",
		"vue",
		"svelte",
	},
	root_dir = vim.fs.root(0, { "package.json", "node_modules", ".git" }),
})

vim.lsp.enable(tool)
