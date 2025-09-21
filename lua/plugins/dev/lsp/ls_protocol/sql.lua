local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("sqlls", {
	capabilities = capabilities,
})

vim.lsp.enable("sqlls")
