vim.lsp.config("html", {
	filetypes = { "html", "htmldjango", "blade", "ejs" },
	init_options = {
		provideFormatter = true,
	},
	root_dir = vim.fs.root(0, { "package.json", "node_modules", ".git" }),
})

vim.lsp.enable("html")
