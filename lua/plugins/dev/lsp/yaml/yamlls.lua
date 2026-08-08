local lsp = require("utils.lsp")

lsp.setup_if_executable({
	name = "yamlls",
	executable = "yaml-language-server",
	config = {
		filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
		root_markers = { ".git" },
		settings = {
			redhat = {
				telemetry = {
					enabled = false,
				},
			},
			yaml = {
				validate = true,
				hover = true,
				completion = true,
				format = {
					enable = true,
				},
			},
		},
	},
})
