local which = require("utils.which")
local lsp = require("utils.lsp")
local tool = "cssls"

if not which:is_exists("vscode-css-language-server") then
	return
end

vim.lsp.config(tool, {
	capabilities = lsp.capabilities(),
	filetypes = { "css", "scss", "less" },
	settings = {
		css = {





			validate = true,
		},
		scss = {
			validate = true,
		},
		less = {
			validate = true,
		},
	},
})

vim.lsp.enable(tool)
