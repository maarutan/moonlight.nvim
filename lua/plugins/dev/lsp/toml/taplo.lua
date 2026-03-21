local which = require("utils.which")
local lsp = require("utils.lsp")
local tool = "taplo"

if not which:is_exists("taplo") then
	return
end

vim.lsp.config(tool, {
	capabilities = lsp.capabilities(),
	filetypes = { "toml" },
})

vim.lsp.enable(tool)
