local which = require("utils.which")
local lsp = require("utils.lsp")
local tool = "yamlls"

if not which:is_exists("yaml-language-server") then
	return
end

vim.lsp.config(tool, {
	capabilities = lsp.capabilities(),
	filetypes = { "yaml" },
	settings = {
		yaml = {
			validate = true,
			hover = true,
			completion = true,
			format = {
				enable = true,
			},
		},
	},
})

vim.lsp.enable(tool)
