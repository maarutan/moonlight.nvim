local tool = "pyright"
local lsp = require("utils.lsp")
local which = require("utils.which")

if not which:is_exists(tool) then
	return
end

vim.lsp.config(tool, {
	capabilities = lsp.capabilities(),
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
})

vim.lsp.enable(tool)
