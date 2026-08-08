local lsp = require("utils.lsp")

lsp.setup_if_executable({
	name = "rust_analyzer",
	executable = "rust-analyzer",
})
