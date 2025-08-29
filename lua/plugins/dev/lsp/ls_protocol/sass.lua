local lspconfig = require("lspconfig")
-- local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig.somesass_ls.setup({
	-- capabilities = capabilities,
	filetypes = { "sass", "scss", "less" },
})
