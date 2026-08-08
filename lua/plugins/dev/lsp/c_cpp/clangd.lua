local lsp = require("utils.lsp")

lsp.setup_if_executable({
	name = "clangd",
	executable = "clangd",
})
