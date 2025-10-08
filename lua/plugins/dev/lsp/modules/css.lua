vim.lsp.config("cssls", {
	settings = {
		css = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
		scss = {
			validate = true,
		},
		less = {
			validate = true,
		},
	},
	filetypes = {
		"css",
		"scss",
		"sass",
		"less",
		"html",
		"javascriptreact",
		"typescriptreact",
		"vue",
		"svelte",
	},
	root_dir = vim.fs.root(0, { "package.json", "node_modules", ".git" }),
})

vim.lsp.enable("cssls")
