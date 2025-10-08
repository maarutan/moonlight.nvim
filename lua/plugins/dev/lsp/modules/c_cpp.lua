vim.lsp.config("clangd", {
	cmd = { "clangd" },
	filetypes = { "c", "cpp", "objc", "objcpp", "c++" },
	root_dir = vim.fs.root(0, { "compile_commands.json", ".git" }),
})

vim.lsp.enable("clangd")
