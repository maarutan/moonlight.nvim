local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("clangd", {
	cmd = { "clangd" },
	filetypes = { "c", "cpp", "objc", "objcpp", "c++" },
	root_dir = vim.fs.root(0, { "compile_commands.json", ".git" }),
	capabilities = capabilities,
})

vim.lsp.enable("clangd")
