local lsp = require("utils.lsp")

lsp.setup_if_executable({
	name = "jdtls",
	executable = "jdtls",
	config = {
		settings = {
			java = {
				eclipse = {
					downloadSources = true,
				},
				configuration = {
					updateBuildConfiguration = "interactive",
				},
				maven = {
					downloadSources = true,
				},
				implementationsCodeLens = {
					enabled = true,
				},
				referencesCodeLens = {
					enabled = true,
				},
				references = {
					includeDecompiledSources = true,
				},
				signatureHelp = {
					enabled = true,
				},
				contentProvider = {
					preferred = "fernflower",
				},
				format = {
					enabled = true,
				},
			},
		},
	},
})
