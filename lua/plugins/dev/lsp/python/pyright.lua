local lsp = require("utils.lsp")

lsp.setup_if_executable({
	name = "pyright",
	executable = "pyright",
	config = {
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
	},
})
