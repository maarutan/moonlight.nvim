vim.lsp.config("jsonls", {
	settings = {
		json = {
			schemas = {
				{
					description = "Package.json schema",
					fileMatch = { "package.json" },
					url = "https://json.schemastore.org/package.json",
				},
				{
					description = "ESLint config schema",
					fileMatch = { ".eslintrc.json", ".eslintrc" },
					url = "https://json.schemastore.org/eslintrc.json",
				},
				{
					description = "Prettier config schema",
					fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
					url = "https://json.schemastore.org/prettierrc",
				},
				{
					description = "TypeScript config schema",
					fileMatch = { "tsconfig.json", "tsconfig.*.json" },
					url = "https://json.schemastore.org/tsconfig.json",
				},
			},
			validate = { enable = true },
		},
	},
})

vim.lsp.enable("jsonls")
