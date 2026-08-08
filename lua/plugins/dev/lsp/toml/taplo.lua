local lsp = require("utils.lsp")

lsp.setup_if_executable({
	name = "taplo",
	executable = "taplo",
	config = {
		filetypes = { "toml" },
		root_markers = { ".taplo.toml", "taplo.toml", ".git" },
	},
})
