local tool = "marksman"
local lsp = require("utils.lsp")
local which = require("utils.which")

if not which:is_exists(tool) then
	return
end

vim.lsp.config(tool, {
	capabilities = lsp.capabilities(),
	filetypes = { "markdown", "md" },
	settings = {
		marksman = {},
	},
})

vim.lsp.enable(tool)
