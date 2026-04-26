local which = require("utils.which")
local lsp = require("utils.lsp")
local tool = "jsonls"

if not which:is_exists("vscode-json-language-server") then
	return
end

vim.lsp.config(tool, {
	capabilities = lsp.capabilities(),
	filetypes = { "json", "jsonc" },
	settings = {
		json = {
			validate = { enable = true },
			format = { enable = true },
		},
	},
})

vim.lsp.enable(tool)
